{ ... }: {
  # enable mullvad daemon
  services.mullvad-vpn.enable = true;

  # enable keybase daemon
  services.kbfs.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;
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

  # for mounting usb devices
  services.udisks2.enable = true;

  services.monero = {
    enable = false;
    extraConfig = ''
      # RPC configuration
      public-node=1                             # Advertise the RPC-restricted port over p2p peer lists
      rpc-restricted-bind-ip=0.0.0.0            # Bind restricted RPC to all interfaces
      rpc-restricted-bind-port=18089            # Bind restricted RPC on custom port to differentiate from default unrestricted RPC (18081)
      no-igd=1                                  # Disable UPnP port mapping

      # ZMQ configuration
      zmq-pub=tcp://127.0.0.1:18083

      out-peers=32
      in-peers=64
      add-priority-node=p2pmd.xmrvsbeast.com:18080
      add-priority-node=nodes.hashvault.pro:18080
      disable-dns-checkpoints=1

      # Block known-malicious nodes from a DNSBL
      enable-dns-blocklist=1
    '';
  };

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
      "multi" = {
        fingerprint = {
          "DP-0" = "00ffffffffffff0004729004db2f00910a1d0104a53c227806ee91a3544c99260f505421080001010101010101010101010101010101565e00a0a0a029503020350056502100001a000000ff00234153504b7276575a43327664000000fd001e9022de3b010a202020202020000000fc00584232373148550a20202020200172020312412309070183010000654b040001015a8700a0a0a03b503020350056502100001a5aa000a0a0a046503020350056502100001a6fc200a0a0a055503020350056502100001a22e50050a0a0675008203a0056502100001e1c2500a0a0a011503020350056502100001a0000000000000000000000000000000000000019";
          HDMI-0 = "00ffffffffffff0010accaa151474b321320010380351e78ee96d5a655519d260f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff004653354b5742330a2020202020000000fc0044454c4c205345323432324858000000fd00304b1f5412000a20202020202001bc020323b14b900504030201111213141f8300000065030c001000681a00000101304b002a4480a070382740302035000f282100001a011d8018711c1620582c250020c23100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f2821000018000000000000000000000000000000000000000096";
        };
        config = {
          "DP-0" = {
            enable = true;
            crtc = 0;
            primary = true;
            mode = "2560x1440";
            rate = "144.00";
            position = "1920x0";
          };
          "HDMI-0" = {
            enable = true;
            crtc = 1;
            primary = false;
            mode = "1920x1080";
            rate = "60.00";
            position = "0x0";
          };
        };
      };
    };
  };

}
