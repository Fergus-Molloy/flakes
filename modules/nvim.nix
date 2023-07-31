{ ... }:
{
  xdg.configFile."nvim" = {
    source = builtins.fetchGit {
      url = "https://github.com/fergus-molloy/nvchad";
      rev = "952cd8de2f03242b300d3b339d4bac94b1b8d279";
    };
  };
}
