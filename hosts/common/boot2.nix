{ pkgs, lib, ... }:
let
  # script to only show grub menu if shift key is held at boot
  hold_shift = pkgs.writeShellScriptBin "31_hold_shift" ''
    #! /bin/sh
    set -e

    prefix="/usr"
    exec_prefix="''${prefix}"
    datarootdir="''${prefix}/share"

    export TEXTDOMAIN=grub
    export TEXTDOMAINDIR="''${datarootdir}/locale"
    source "''${datarootdir}/grub/grub-mkconfig_lib"

    found_other_os=

    make_timeout () {

      if [ "x''${GRUB_FORCE_HIDDEN_MENU}" = "xtrue" ] ; then 
        if [ "x''${1}" != "x" ] ; then
          if [ "x''${GRUB_HIDDEN_TIMEOUT_QUIET}" = "xtrue" ] ; then
        verbose=
          else
        verbose=" --verbose"
          fi

          if [ "x''${1}" = "x0" ] ; then
        cat <<EOF
    if [ "x\''${timeout}" != "x-1" ]; then
      if keystatus; then
        if keystatus --shift; then
          set timeout=-1
        else
          set timeout=0
        fi
      else
        if sleep''$verbose --interruptible 3 ; then
          set timeout=0
        fi
      fi
    fi
    EOF
          else
        cat << EOF
    if [ "x\''${timeout}" != "x-1" ]; then
      if sleep''$verbose --interruptible ''${GRUB_HIDDEN_TIMEOUT} ; then
        set timeout=0
      fi
    fi
    EOF
          fi
        fi
      fi
    }

    adjust_timeout () {
      if [ "x''$GRUB_BUTTON_CMOS_ADDRESS" != "x" ]; then
        cat <<EOF
    if cmostest ''$GRUB_BUTTON_CMOS_ADDRESS ; then
    EOF
        make_timeout "''${GRUB_HIDDEN_TIMEOUT_BUTTON}" "''${GRUB_TIMEOUT_BUTTON}"
        echo else
        make_timeout "''${GRUB_HIDDEN_TIMEOUT}" "''${GRUB_TIMEOUT}"
        echo fi
      else
        make_timeout "''${GRUB_HIDDEN_TIMEOUT}" "''${GRUB_TIMEOUT}"
      fi
    }

      adjust_timeout

        cat <<EOF
    if [ "x\''${timeout}" != "x-1" ]; then
      if keystatus; then
        if keystatus --shift; then
          set timeout=-1
        else
          set timeout=0
        fi
      else
        if sleep''$verbose --interruptible 3 ; then
          set timeout=0
        fi
      fi
    fi
    EOF
  '';
in
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    useOSProber = true;
    efiSupport = true;
    configurationLimit = 10;
    splashImage = ./nix-wallpaper-dracula.png;
    timeoutStyle = lib.mkDefault "hidden";
    extraFiles = {
      "31_hold_shift" = "${hold_shift}/bin/31_hold_shift";
    };
  };
}
