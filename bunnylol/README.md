# bunnylol (dotfiles package)

Shortcuts for [bunnylol.rs](https://github.com/facebook/bunnylol.rs) plus a local web UI for editing them.

## Files

| Path | Purpose |
|---|---|
| `bunnylol/.config/bunnylol/config.toml` | Source of truth. `[user_bindings]`, `[history]`, `[server]`. |
| `bunnylol/.local/bin/bunnylol-ui` | Python 3 HTTP server + HTML form (port 8001). |
| `bunnylol/.config/systemd/user/bunnylol-ui.service` | Runs the UI. |

`stow bunnylol` (or the manual symlinks below) links these into `$HOME`.

## How it works

- `bunnylol` prefers `/etc/bunnylol/config.toml` over `~/.config/bunnylol/config.toml`. The dotfiles setup makes `/etc/bunnylol/config.toml` a **symlink** to the tracked repo file. Verify with `readlink /etc/bunnylol/config.toml`.
- The CLI reads the config on every run. The running server (`bunnylol serve`, port 8000) reloads when the config's mtime changes, so no restart is needed after edits.
- The UI reads and writes the same repo file with `tomlkit`, preserving comments and the `[history]`/`[server]` sections. It refuses to write if the `/etc` symlink is broken.
- The UI runs on `127.0.0.1:8001`. Its `ui` binding (aliases `configui`, `bunnyui`) points at itself, so `http://localhost:8000/?cmd=ui` opens it.

## Quickstart (new device)

1. Install bunnylol, e.g. `cargo install bunnylol` or a distro package. Confirm `bunnylol --version`.
2. Clone and link the dotfiles:
   ```sh
   git clone git@github.com:meetrajivvora/.dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   stow -v bunnylol          # or use the manual symlinks below
   ```
   Manual equivalent:
   ```sh
   mkdir -p ~/.config/bunnylol ~/.local/bin ~/.config/systemd/user
   ln -sfn ~/.dotfiles/bunnylol/.config/bunnylol/config.toml ~/.config/bunnylol/config.toml
   ln -sfn ~/.dotfiles/bunnylol/.local/bin/bunnylol-ui ~/.local/bin/bunnylol-ui
   ln -sfn ~/.dotfiles/bunnylol/.config/systemd/user/bunnylol-ui.service ~/.config/systemd/user/bunnylol-ui.service
   ```
3. Create the UI's Python environment (needs `tomlkit`):
   ```sh
   python3 -m venv ~/.local/share/bunnylol-ui/venv
   ~/.local/share/bunnylol-ui/venv/bin/pip install tomlkit
   ```
4. Point `/etc` at the tracked config. If it is already a valid symlink, skip this step:
   ```sh
   if [ ! -L /etc/bunnylol/config.toml ]; then
     sudo mkdir -p /etc/bunnylol
     if [ -e /etc/bunnylol/config.toml ]; then
       sudo mv /etc/bunnylol/config.toml /etc/bunnylol/config.toml.stock
     fi
     sudo ln -s ~/.dotfiles/bunnylol/.config/bunnylol/config.toml /etc/bunnylol/config.toml
   fi
   readlink /etc/bunnylol/config.toml
   ```
5. Enable the services:
   ```sh
   systemctl --user daemon-reload
   bunnylol service install        # or create the server unit yourself
   systemctl --user enable --now bunnylol.service bunnylol-ui.service
   ```
6. Open the UI: <http://localhost:8001/> or <http://localhost:8000/?cmd=ui>.

## Usage

- Add/edit/delete bindings in the form. Writes land in `bunnylol/.config/bunnylol/config.toml`; commit them to keep the repo in sync.
- From a terminal: `bunnylol <name>` opens the shortcut; `bunnylol --dry-run <name>` prints the resolved URL.
- From the browser's search bar (pointed at `http://localhost:8000/?cmd=%s`): type `ui` to open the config page, or any binding name.

## Troubleshooting

| Symptom | Check |
|---|---|
| Shortcut ignored | `readlink /etc/bunnylol/config.toml` — must point at the repo file. An OS update may replace it with the stock file; restore the symlink. |
| UI service fails | `systemctl --user status bunnylol-ui.service`; confirm the venv exists and `tomlkit` is installed. |
| UI refuses to save | It means the `/etc` symlink is not pointing at the repo file; fix the symlink. |
| Changes not visible | The server reloads on mtime; check `curl -s http://localhost:8000/?cmd=<name>` and the server logs. |
| UI not reachable | `ss -tlnp | grep 8001`; confirm the service is active. |

## Notes

- `/etc` is an ostree deployment on Bazzite: the symlink can be replaced on OS updates. Re-check after upgrades.
- The UI has no authentication and binds to localhost only. Do not expose port 8001.
- The venv lives outside the repo (`~/.local/share/bunnylol-ui/venv`) and is not tracked.
