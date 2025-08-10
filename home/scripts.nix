{ ... }:
{
  home.file.".local/bin" = {
    source = ./configs/scripts;
    recursive = true;
  };
}
