{pkgs, user, ...}:
{
    imports = [ 
        ../../modules/kitty/kitty.nix 
        ../../modules/neofetch/neofetch.nix
        ../../modules/home/i3.nix
    ];
    home.file.".background-image".source = ../../modules/wall-1440;
    programs.feh.enable = true;
}
