{ config, pkgs, lib, user, nixvim, ... }:
let
  host = "barioth";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop-environments/i3.nix
    ../../modules/steam.nix
    ../../modules/nvidia.nix
  ];

  system.stateVersion = "23.11"; # Did you read the comment?

  services.xserver.videoDrivers = [ "nvidia" ];

  # wipe root on every boot
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /mnt
    mount -t btrfs /dev/mapper/enc /mnt
    btrfs subvolume delete /mnt/root
    btrfs subvolume snapshot /mnt/root-blank /mnt/root
  '';

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  # set freq govenor 
  # "performance" - max speed all the time
  # "powersave" - min speed all the time
  # "ondemand" - scale speed based on load
  # "conservative" - scale speed but in increments rather than big jumps
  # "schedutil" - scale speed based on kernel scheduler
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";

  networking.hostName = "${host}";

  time.hardwareClockInLocalTime = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader
  # boot.loader.grub = {
  #   enable = true;
  #   devices = [ "nodev" ];
  #   useOSProber = true;
  #   efiSupport = true;
  # };
  # boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # enable mullvad daemon
  services.mullvad-vpn.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Extra packages just for this system
  environment.systemPackages = with pkgs; [
    udisks # for mounting usb devices
    mullvad-vpn # mullvad vpn
    tmuxinator
    element-desktop

    (nixvim.legacyPackages."${system}".makeNixvimWithModule { inherit pkgs; module = import ../../modules/nvim; })
  ];
  virtualisation.docker.enable = true;

  # user shell
  programs.zsh.enable = true;

  # for mounting usb devices
  services.udisks2.enable = true;

  users.users.${user}.packages = with pkgs; [
    discord # chat app
  ];

  nixpkgs.overlays = [
    # This overlay will pull the latest version of Discord
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "0f4m3dzbzir2bdg33sysqx1xi6qigf5lbrdgc8dgnqnqssk7q5mr";
          };
        }
      );
    })
  ];
}
