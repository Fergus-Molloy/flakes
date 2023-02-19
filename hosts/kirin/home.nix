{pkgs, user, ...}:
{
    imports = [ 
        ../../modules/starship/starship.nix
        ../../modules/kitty/kitty.nix 
        ../../modules/neofetch/neofetch.nix
    ];
}