{pkgs, user, ...}:
{
    imports = [ 
        ../../modules/kitty/kitty.nix 
        ../../modules/neofetch/neofetch.nix
    ];
}