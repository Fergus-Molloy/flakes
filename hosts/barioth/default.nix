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

  # enable keybase daemon
  services.kbfs.enable = true;

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
    autorandr
    obsidian
    rclone

    gnupg
    pinentry-qt
    pinentry-tty

    (nixvim.legacyPackages."${system}".makeNixvimWithModule { inherit pkgs; module = import ../../modules/nvim; })
  ];
  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # user shell
  programs.zsh.enable = true;

  # for mounting usb devices
  services.udisks2.enable = true;

  # setup screens
  services.autorandr = {
    enable = true;
    defaultTarget = "desktop";
    profiles = {
      "desktop" = {
        fingerprint = {
          "DP-0" = "00ffffffffffff0004729004db2f00910a1d0104a53c227806ee91a3544c99260f505421080001010101010101010101010101010101565e00a0a0a029503020350056502100001a000000ff00234153504b7276575a43327664000000fd001e9022de3b010a202020202020000000fc00584232373148550a20202020200172020312412309070183010000654b040001015a8700a0a0a03b503020350056502100001a5aa000a0a0a046503020350056502100001a6fc200a0a0a055503020350056502100001a22e50050a0a0675008203a0056502100001e1c2500a0a0a011503020350056502100001a0000000000000000000000000000000000000019";
        };
        config = {
          "DP-0" = {
            enable = true;
            crtc = 0;
            primary = true;
            mode = "2560x1440";
            rate = "144.00";
            position = "0x0";
          };
        };
      };
    };
  };

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
