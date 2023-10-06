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
Assuming you are using my vimrc then you may notice that when you go to edit code files you get an error saying that the languager servers are not installed.
Normally you would then install these using mason.nvim, however i have not included this in my config as we can instead use nix development shells to install language servers.
You can see the configured dev shells in `~/.flake/shells/flake.nix`, to use one of these shells run `echo "use flake ~/.flake/shells#<shellName>" > .envrc && direnv allow`,
I recommend running this in the directory you want to use the tools from. This will then install and add the configured programs to your PATH.
When you leave the directory in which you ran that command these tools will be removed from your PATH.
