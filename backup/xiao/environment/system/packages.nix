
{ config, lib, pkgs, ... }:

{
  # imports = [
    # ./tex.nix

    # ../../../../programs/emacs.nix
  # ];


  environment.systemPackages = (with pkgs;

    let
      pythonWithPackages = python3WithPackages:
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
          scikitlearn
          # imblearn
          # imgaug
          # tensorflow
          Keras
          imageio
        ];

      python3WithPackages = python3.withPackages pythonWithPackages;

    in
      [


        python3WithPackages

        calibre

        # libtensorflow
        # openimageio
        # openimageio2
        tikzit
        nmap
        nixpkgs-lint

        cargo

        leiningen
        clojure
        rlwrap
        lumo

        blender
        openscad

        virtualbox
        #virtualboxExtpack

        # unstable.packageName

        git
        htop
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
        # nodejs-11_x
        nodejs
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
        epdfview

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
        evince


        tcpdump
        reptyr
        gnutls
        pciutils

        brightnessctl
        glxinfo

        zathura

      ]);

}
