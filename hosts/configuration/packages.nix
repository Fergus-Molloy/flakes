{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl

    vim # in case nvim breaks
    unzip # decompress zips
    tree # see folder structure from command line
    jq # json helper
    udisks # for mounting usb devices
  ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    font-awesome
    twemoji-color-font
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
