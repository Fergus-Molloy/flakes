{pkgs, user, ...}:
{
    imports = [ 
        ../../modules/kitty/kitty.nix 
        ../../modules/neofetch/neofetch.nix
        ../../modules/home/i3.nix
    ];
    home.file.".config/wall".source = ../../modules/wall-1440;
}
