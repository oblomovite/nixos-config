{ config, pkgs, lib, ... }:

{

  nixpkgs = {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };

    overlays = [
      (import ./overlay.nix
        {
          # inherit secrets;
        }
      )
    ];
  };

  # nix options for derivations to persist garbage collection
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # environment.pathsToLink = [
  #   "/share/nix-direnv"
  # ];

  environment = {
    systemPackages = (with pkgs;
      let
        # pypi2nix = import (pkgs.fetchgit {
        #   url = "https://github.com/nix-community/pypi2nix";
        #   # adjust rev and sha256 to desired version
        #   rev = "v2.0.1";
        #   sha256 = "sha256:0mxh3x8bck3axdfi9vh9mz1m3zvmzqkcgy6gxp8f9hhs6qg5146y";
        # }) {};


        # pypi2nix = import (pkgs.fetchgit {
        #   url = "https://github.com/nix-community/pypi2nix";
        #   # adjust rev and sha256 to desired version
        #   rev = "v2.0.1";
        #   sha256 = "sha256:0mxh3x8bck3axdfi9vh9mz1m3zvmzqkcgy6gxp8f9hhs6qg5146y";
        # }) {};


        pythonWithPackages = python3WithPackages:
          with python3Packages;

          [
            # Jupyter
            jupyter_core
            jupyter_console
            jupyter_client
            notebook

            # pip

          ];

        # nodeWithPackages = nodejs.withPackages nodejsWithPackages;
        python3WithPackages = python3.withPackages pythonWithPackages;

      in

        [

          # package = pkgs.emacsGcc;
          # extraPackages = (epkgs: [ epkgs.vterm ] );

          emacsGcc

          #   ## Sway Packages ##
          alacritty
          rofi 
          #fuzzel
          #wofi
          swaylock # lockscreen
          swayidle
          xwayland # for legacy apps
          waybar # status bar
          mako # notification daemon
          kanshi # autorandr
          wlr-randr
          firefox-wayland
          grim
          slurp
          wl-clipboard
          clipman
          i3status-rust
          ## Media ##
          vlc
          mplayer
          mpv
          playerctl
          qrencode # image generation for qrcodes
          spotify
          
          # 

          ccls
          python-language-server
          nodePackages.bash-language-server
          nodePackages.typescript-language-server
          pypi2nix # Convert requirements to nix expression

          mplayer
          ## System Monitoring
          vnstat # Network
          htop # General
          powertop # Power # powertop --html=<destination>
          # gotop
          #nvtop # Nvidia
          #libnotify # Not sure I need this
          ## Not sure which I need of the two

          # Learn about disk usage of directories
          dua
          # Learn about disk usage of directories
          duc
          ## Not sure which I need of the two

          # Tools for network auditing
          # dsniff

          # Clipboard Manager
          # parcellite
          # clipster

          ### system profiler ###
          oprofile
          pprof
          valgrind # Debugging and profiling tool suite
          # heaptrack # Heap memory profiler for Linux
          ### system profiler ###

          ## System Monitoring

          # Modeling + Drawing
          blender
          openscad
          #########
          # kicad #
          #########
          krita
          gimp
          unity3d
          godot
          # Modeling + Drawing

          # For sending magic packets
          wol

          # Chess
          chessx
          # crafty
          gnuchess
          xboard
          stockfish
          scid
          scid-vs-pc
          # arena
          eboard
          chessdb

          # Accounting Tool
          ledger
          ledger-autosync

          # Mail Sever
          mu

          ## Languages
          # Lisps
          clisp
          sbcl
          hy

          # Rust
          rustup
          cargo
          rustc

          # Nix Tooling
          # nixfmt
          nixpkgs-lint
          nix-prefetch-scripts
          cachix
          nix-index
          nox
          patchelf

          # Haskell
          cabal-install
          ghc

          # Julia
          # julia

          # R
          R
          # rPackages.ggplot2
          # rPackages.dplyr
          # rPackages.xts

          # Elm
          elmPackages.elm

          # Dictionaries
          hunspell
          hunspellDicts.en-us
          hunspellDicts.de-de
          hunspellDicts.fr-moderne
          aspell
          aspellDicts.fr
          aspellDicts.en
          aspellDicts.de
          aspellDicts.ru

          # Ruby
          ruby
          bundler

          # C/C++
          ccls
          coan
          gcc
          clang
          boost
          gdb
          omnisharp-roslyn


          # Java
          #          jdk14
          #          gradle
          #          gradle-completion
          #          maven

          # Latex
          texlive.combined.scheme-full
          auctex
          tikzit
          graphviz
          gnuplot

          ## General Programming Packages
          universal-ctags
          git
          git-lfs # git extension for verioning large files


          # Library Utility
          # calibre

          # Password Management #
          pass
          pass-otp
          passExtensions.pass-update
          passExtensions.pass-import
          keychain
          pwgen
          pwgen-secure
          mkpasswd
          browserpass
          # Password Management #


          ## System Utils
          pv
          wget
          which
          tcpdump
          reptyr
          gnutls
          pciutils
          nmap
          blueman
          dropbear # initrd ssh
          sshfs

          # btrbk # Btrfs backups

          # System Clipboard
          clipmenu
          pastebinit

          # Terminal + Utils #
          ## Search + Fuzzy Find ##
          # ag
          ripgrep
          fzf
          ## Search + Fuzzy Find ##

          pinentry # gpg-agent context menu
          termite
          alacritty
          gawk
          
          # Set Localized Environment variables eg persisting nix-shell 
          direnv

          # Optimized use_nix implementation for direnv
          # nix-direnv

          # Community driven cheat sheet #
          cheat
          cht-sh
          # Community driven cheat sheet #

          # cat clone with syntax highlighting and git integration
          bat
          # Search engine for the terminal
          surfraw

          glxinfo # graphics card diagnostic tool
          # Terminal + Utils #

          # Ergonomic #
          speedread # command line filter that shows input text as a per-word rapid serial visiual, meant to induce a more optimal reading exprience
          # Ergonomic #

          # File Management #
          ranger
          tree
          file
          rsync # fast, incremental file transfer utility

          ## File Compression ##
          # p7zip
          zip
          unzip
          unrar
          avfs
          ## File Compression ##

          # File Management #


          # Virtualisation Packages #
          # nvidia-docker
          # Virtualisation Packages #


          # Rust
          binutils gcc gnumake openssl pkgconfig
          rustc cargo clippy rustfmt rls rustup 
          # rustracer


          ## Network Tools
          wireshark # Packet Analyzer

          ## SDR
          gnuradio-with-packages # Software Defined Radio (SDR) software
          gr-osmosdr # Gnuradio block for rtl-sdr
          hackrf # SDR platform - drivers
          gnss-sdr # Global Navigation Satellite Systems software-defined reciever
          inspectrum # Tool for analysing captured singlas from sdr recievers
          cubicsdr # Mode S decoder
          ## TO SORT ##

          # clj-kondo


          # rtv
          # screenfetch
          # gnirehtet
          # iw
          # lynx
          # neofetch
          # exa
          # ark
          # abiword
          # coursera-dl
          # youtube-dl
          # system-config-printer
          # wgetpaste
          # openvpn

          boot
          # jdk11
          ## TO SORT ##
          vorbis-tools

          # flutter-beta
          # dart_dev

        ]);
  };
}
