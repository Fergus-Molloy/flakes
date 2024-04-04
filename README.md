# Install
1. install nixos
2. edit `/etc/nixos/configuration.nix` to install git and add the following lines to enable flake support
```nix
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
```
3. run `sudo nixos-rebuild switch` then reboot
4. log back in and clone this repo `git clone http://github.com/Fergus-Molloy/flakes.git .flake`
5. cd into `.flake`
6. copy `/etc/nixos/hardware-configuration.nix` into the relevant host (this will overwrite the existing config there)
7. now run `sudo nixos-rebuild switch --flake .#<host>`
8. reboot and you should have a working system as configured by this repo.
9. you will want to setup ssh for github this can be done using the normal commands. git username, email and any gpg configuration should be placed in `~/.gituser`
10. finish configuring the system. Firefox will be using defaults and i recommend using my neovim config `git clone git@github.com:Fergus-Molloy/vimrc.git ~/.config/nvim`

# Usage
## basic keymaps
alt+enter -> new kitty terminal
alt+g -> new firefox window
alt+d -> open rofi (application launcher)

## neovim / dev shells
Neovim is automatically installed and configured using nixvim, this includes language servers.
When developing a project, tools specific to that project should be installed via a devshell.
There are several pre-configured devshells in shells/flake.nix to use these run `direnv-create <shell>`.
This will automatically create an `.envrc` and allow direnv to run. If the folder is a git repo it will also add
`.envrc` and `.direnv` to `.git/info/exclude` (local only .gitignore).

If the project uses a `flake.nix` then run `echo "use flake" > .envrc && direnv allow` to use the already configured tools.
