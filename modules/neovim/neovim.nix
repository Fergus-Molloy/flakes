{config, pkgs, ...}:
{
    home.file.".config/nvim".source = pkgs.fetchFromGitHub {
        owner="Fergus-Molloy";
        repo="nvim-pde";
        rev = "51ba38a";
        sha256 = "sha256-DiWiz9dNf2k0OtMXXfTTwzrH2RnZlMh8IiQLAQpdOtg=";
    };
}