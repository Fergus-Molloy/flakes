{ config, pkgs, lib, user, ... }:
let
  host = "diablos";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop-environments/i3/i3.nix
  ];
  # set freq govenor 
  # "performance" - max speed all the time
  # "powersave" - min speed all the time
  # "ondemand" - scale speed based on load
  # "conservative" - scale speed but in increments rather than big jumps
  # "schedutil" - scale speed based on kernel scheduler
  powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";

  networking.hostName = "${host}";

  time.hardwareClockInLocalTime = true;
  # Bootloader
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;
  # to setup wifi do the following
  # $ wpa_cli
  # > scan
  # > scan_results
  # > add_network
  # > set_network 0 ssid "SSID"
  # > set_network 0 psk "password"
  # > enable_network 0
  # > save_config
  # we can now load this config after restarts with `wpa_supplicant -B -i wlo1 -c /run/wpa_supplicant/wpa_supplicant.conf`
  networking.networkmanager.enable = true;


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

  # fonts
  fonts.fonts = with pkgs; [
    twemoji-color-font
  ];


  # Extra packages just for this system
  environment.systemPackages = with pkgs; [
    dotnet-sdk_7
    dotnet-aspnetcore_7
    docker-compose
    udisks # for mounting usb devices
  ];
  virtualisation.docker.enable = true;
  programs.zsh.enable = true;

  # for mounting usb devices
  services.udisks2.enable = true;


  # for backlight
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  users.users.${user}.packages = with pkgs; [
    rustup # rust stuff
    rust-analyzer
    clang # compiler that can be used to speed up rust linking times
    lld # linker that can be used to speed up rust linking times
    discord # chat app
    stylua # lua formatter

  ];

  nixpkgs.overlays = [
    # This overlay will pull the latest version of Discord
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "12yrhlbigpy44rl3icir3jj2p5fqq2ywgbp5v3m1hxxmbawsm6wi";
          };
        }
      );
    })
  ];
}
