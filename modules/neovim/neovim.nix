{config, ...}:
{
    home.file.".config/nvim".source = fetchFromGithub {
        owner="Fergus-Molloy";
        repo="nvim-pde";
        rev = "92f2b96";
        sha256 = "00000000000000000000000000000000000000000000000000000000";
    };
}