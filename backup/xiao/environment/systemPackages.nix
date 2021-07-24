{ config, lib, pkgs, ... }:

{
  # imports = [
    # ./base-medium.nix
  # ];

  # environment.systemPackages = with pkgs; [

  environment.systemPackages = (with pkgs;

    let
      pythonWithPackages = pythonWithPackages:
        with python3Packages;

        [

          # Jupyter
          jupyter_core
          jupyter_console
          jupyter_client
          notebook

          # Python linting, syntax-highlighting, etc.
          jedi
          virtualenv
          flake8
          autopep8
          epc
          
          # Packages
          numpy
          matplotlib
          sympy
          scipy
          pandas
          # scikit-learn
        ];

      python3WithPackages = python3.withPackages pythonWithPackages;

    in
      [

        nmap
        nixpkgs-lint

        cargo

        leiningen
        clojure
        lumo

        blender
        openscad

        virtualbox
        #virtualboxExtpack

        python3WithPackages
        # unstable.packageName

        git
        htop
        networkmanager_dmenu
        nix-prefetch-scripts
        vagrant
        wget
        which
        chromium
        libvirt
        qemu_kvm
        kvm
        clipmenu
        blueman

        ## Javascript
        # nodejs
        nodejs-11_x
        yarn

        ## Terminal
        vim
        qutebrowser
        gnupg

        # Can't decide on a terminal
        termite
        alacritty
        kitty
        tmux

        maven

        texlive.combined.scheme-full
        auctex

        # sci
        R
        graphviz
        gnuplot

        # utils
        keychain
        aspell
        pastebinit
        wgetpaste
        gnupg
        openvpn
        qrencode
        unrar
        unzip
        p7zip
        imagemagickBig
        pv

        # glxinfo # imgurbash

        tcpdump
        reptyr
        gnutls
        pciutils

        brightnessctl
        glxinfo

        displaylink
      ]);

}
