{ config, pkgs, lib, user, inputs, ... }:
let
  host = "rathalos";
in
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./qsv.nix
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

  # set freq govenor 
  # "performance" - max speed all the time
  # "powersave" - min speed all the time
  # "ondemand" - scale speed based on load
  # "conservative" - scale speed but in increments rather than big jumps
  # "schedutil" - scale speed based on kernel scheduler
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";

  networking =
    let
      ports = [
        69 # ssh
        51820 # mullvad
        8080 # qbittorrent webui
        9637 # qbittorrent connection
        80
        443
      ];
    in
    {
      hostName = "${host}";
      extraHosts = ''
        127.0.0.1   local.com
        127.0.0.1   qbittorrent.local.com
      '';
      networkmanager.enable = true;
      firewall.enable = true;
      firewall.allowedTCPPorts = ports;
      firewall.allowedUDPPorts = ports;
    };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      Port = 69;
    };
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


  # Extra packages just for this system
  environment.systemPackages = with pkgs; [
    neovim
    mullvad-vpn # mullvad vpn
  ];
  virtualisation.docker.enable = true;
  environment.variables = {
    # some commands require a full path to the shell
    SHELL = "/run/current-system/sw/bin/zsh";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  # user shell
  programs.zsh.enable = true;
}
