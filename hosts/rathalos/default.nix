{ config, pkgs, lib, user, inputs, ... }:
let
  host = "rathalos";
  nixCats = import ../../modules/nixcats { inherit inputs; };
in
{
  imports = [
    ./hardware-configuration.nix
    nixCats.nixosModules.default
  ];


  nixCats = {
    enable = true;
    packageNames = [ "nixCats" ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?

  # set freq govenor 
  # "performance" - max speed all the time
  # "powersave" - min speed all the time
  # "ondemand" - scale speed based on load
  # "conservative" - scale speed but in increments rather than big jumps
  # "schedutil" - scale speed based on kernel scheduler
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";

  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    useOSProber = true;
    efiSupport = true;
    configurationLimit = 10;
  };
  # boot.loader.efi.canTouchEfiVariables = true;

  # enable mullvad daemon
  services.mullvad-vpn.enable = false;

  # Extra packages just for this system
  environment.systemPackages = with pkgs; [
    # mullvad-vpn # mullvad vpn
    # qbittorrent
  ];
  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  # user shell
  programs.zsh.enable = true;
}
