{ pkgs, ... }:
let
  host = "kirin";
in
{
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "${host}";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure X11
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
    };
    #windowManager = {
    #  i3.enable = true;
    #};
    desktopManager = {
      plasma5.enable = true;
    };
    libinput.mouse.accelProfile = "flat";
    layout = "gb";
    xkbVariant = "";
  };

  services.picom = {
    enable = true;
    vSync = true;
    fade = true;
    backend = "glx";
    settings = {
      glx-swap-method = 2;
    };
    # make some stuff sligtly transparent
    # opacityRules = ["90:class_g = 'kitty'"];
  };

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
    rustup # rust stuff
    clang # compiler that can be used to speed up rust linking times
    lld # linker that can be used to speed up rust linking times
  ];
}
