{ config, pkgs, user, ... }: {
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to the password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    initialPassword = "password";
    shell = pkgs.zsh;
    packages = with pkgs;[ ];
  };

  environment.variables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    TERM = "kitty";
    TERMINAL = "kitty";
  };


  # need both shells otherwise weird things can happen with user accounts
  environment.shells = with pkgs;
    [ bashInteractive zsh ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    keepassxc
    keybase # gpg identity verifier
    killall
    neovim

    # git tools
    lazygit
    gh
  ];


  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Fergus Molloy";
        email = "fergus@molloy.xyz";
      };
      checkout = {
        defaultRemote = "origin";
        guess = true;
      };
      init = { defaultBranch = "main"; };
      branch = { autoSetupRebase = "always"; };
      push = { autoSetupRemote = true; };
      # create this manually on each machine, to store gpg stuff
      include = { path = "/home/${user}/.gituser"; };
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
    twemoji-color-font
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  # setup mouse and keyboard for xserver
  services.xserver = {
    xkb = {
      layout = "gb";
      variant = "";
    };
  };
  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    mouse.accelSpeed = "1";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  services.keybase.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "23.05"; # Did you read the comment?

  # Configure automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
