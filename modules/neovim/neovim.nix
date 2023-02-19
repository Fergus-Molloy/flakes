{config, pkgs, ...}:
{
    home.file.".config/nvim".source = pkgs.fetchFromGitHub {
        owner="Fergus-Molloy";
        repo="nvim-pde";
        rev = "51ba38a";
        sha256 = "1sacyyn4vxnhi4w2bivclvllqnn5nisc08iyxbpnhha5rwb4dxwx";
    };
}