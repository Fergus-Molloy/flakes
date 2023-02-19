{config, ...}:
{
    programs.kitty.enable = true;
    home.file.".config/neofetch/config.conf".source = ./config.conf;
}