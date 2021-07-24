{
  emacsPackagesNg,
  mutate,
  msmtp,
  writeText,
  docbook5,
  graphviz,
  hunspellWithDicts,
  hunspellDicts,
  fetchFromGitHub,
  fetchpatch,
  imagemagickBig
}:

let


  nix-mode-overrides = {
    none = x: {};

    # local-clone = oldAttrs: {
    # src = /home/grahamc/projects/nixos/nix-mode;
    # };

    master-floating = oldAttrs: {
      src = builtins.fetchGit {
        url = "https://github.com/nixos/nix-mode.git";
        ref = "master";
      };
    };

    master-2019-01-29 = oldAttrs: {
      src = builtins.fetchGit {
        url = "https://github.com/nixos/nix-mode.git";
        ref = "master";
        rev = "1e53bed4d47c526c71113569f592c82845a17784";
      };
    };

    etu-master-floating = oldAttrs: {
      src = builtins.fetchGit {
        url = "https://github.com/etu/nix-mode.git";
        ref = "master";
      };
    };
  };

in

emacsPackagesNg.emacsWithPackages (epkgs: (
  (with epkgs.melpaPackages; [

    # Cut + Paste
    easy-kill

    # Grammer, weasel words, passive-voice checker.
    writegood-mode

    # Completion Framework
    #icomplete-vertical

    # Ivy + Extensions
    ivy
    swiper
    # ivy-prescient
    # ivy-hydra
    # ivy-rich
    # ivy-hydra
    # ivy-pass

    ## Python
    python-mode
    sphinx-doc
    python-docstring
    blacken
    py-isort
    pyimport

    # Killing + Yanking
    browse-kill-ring

    ## Required for Jupyter
    websocket
    simple-httpd
    zmq

    # Theme and Modeline
    zenburn-theme
    all-the-icons
    all-the-icons-ivy
    nyan-mode # MY CAT
    minions # Do not display Minor modes on modeline directly
    # delight # Change appearence of Minor Modes as displayed on modeline

    # Syntax Highlighting and Pretty Symbols
    symbol-overlay
    pretty-mode
    ipretty
    highlight-parentheses
    rainbow-blocks
    rainbow-delimiters
    visual-regexp

    # Window Management
    ace-window
    switch-window
    winum

    # Navigation
    avy


    # Keybinding
    hydra
    general

    # Bookmarks
    bm

    # Dired Packages
    dired-rainbow
    dired-sidebar
    dired-icon

    # Lisp Package
    # lispy

    # Mail

    # Accounting
    ledger-mode
    ledger-import

    # Ripgrep
    rg
    ag
    deadgrep
    ripgrep

    # Snippets
    yasnippet
    yasnippet-snippets

    # Package Configuration
    use-package

    # Cold Folding
    origami

    # Password and GPG Key Management
    pass

    # Better *Help* Buffers
    helpful

    # Operate on grep results
    wgrep

    ### TO SORT ###
    # (nix-mode.overrideAttrs nix-mode-overrides.master-2019-01-29)
    projectile
    markdown-mode
    rust-mode
    auto-compile

    dash
    dash-functional

    artbollocks-mode
    anzu

    which-key
    flx
    thingopt
    session
    amx
    prescient
    alert
    ibuffer-vc
    epkg
    async
    diff-hl
    direnv
    editorconfig
    elixir-mode
    elm-mode
    erlang
    # fill-column-indicator
    ghc
    go-mode
    graphviz-dot-mode
    hcl-mode


    ####################
    # pangu-spacing    #
    # page-break-lines #
    ####################


  ]) ++ (with epkgs; [

    ## Media Player ##
    emms

    ## Clipboard ##
    clipmon

    ## Reader Utilities
    # Read .epub files in emacs
    nov

    # Speed Reading
    spray

    ## Writing Utilities
    wordnut
    powerthesaurus
    define-word
    synosaurus
    academic-phrases
    guess-language
    # helm-flyspell
    langtool
    # auto-dictionary
    # dictionary
    google-translate

    ## Editor Utilities
    aggressive-indent
    undo-tree
    multiple-cursors
    smartparens
    browse-kill-ring
    web-beautify
    ggtags


    ## Jupyter
    jupyter

    ## Hy
    hy-mode

    ## Goland
    go-mode

    # R
    ess

    ## Typescript
    tide

    # Misc Modes
    ssh-config-mode
    dockerfile-mode
    lua-mode

    ## Workspaces
    perspective
    persp-projectile

    ## Amenities
    dashboard
    speed-type

    ## Chess
    chess

    # Editor Utilities
    expand-region
    atomic-chrome
    edit-server

    # Systemd Utilities
    systemd

    # Arduino Utilities
    arduino-mode

    # OpenScad Utilities
    scad-mode
    scad-preview

    ## Javascript Utilities
    xref-js2
    js2-mode
    rjsx-mode
    js2-refactor
    js-auto-beautify
    js-import
    json-reformat
    latex-preview-pane
    web-mode
    yaml-mode
    json-mode

    ## Emacs Utilities ###
    # Performance Profiler
    esup
    # Garbage Collection
    gcmh
    # Benchmarking Statistics
    benchmark-init
    # Organize various auto-generated files
    no-littering

    ### Emacs Utilities ###

    # Language Server Protocol
    lsp-mode
    lsp-ui
    # dap-mode
    # lsp-java


    # Python
    python
    jedi
    pyvenv

    # Clojure
    clojure-mode
    clojure-mode-extra-font-locking
    cider
    cider-eval-sexp-fu
    clj-refactor

    ## General Editting
    evil

    # For running tmux, etc. inside emacs
    # Bridge to libvterm to display a terminal in an Emacs Buffer
    # emacs-libvterm
    vterm

    # Compnay
    company
    company-quickhelp
    company-box
    company-tabnine
    company-arduino
    company-c-headers
    company-box
    company-flx
    company-auctex
    company-math
    company-web
    company-anaconda
    company-restclient
    company-irony
    company-lsp
    company-nixos-options
    company-dict
    company-shell
    company-go
    company-anaconda
    company-jedi
    company-prescient

    # Nix
    nix-mode
    nix-buffer

    # Git/Magit
    gitconfig-mode
    gitignore-mode
    magit
    forge
    transient
    git-gutter

    # Flycheck
    flycheck
    flycheck-package
    flycheck-indicator
    flycheck-clojure
    flycheck-joker
    flycheck-irony
    flycheck-ledger
    package-lint

    # C/C++
    irony
    irony-eldoc
    omnisharp

    # Utils
    restclient
    pdf-tools

    ob-async
    ob-ipython
    ob-rust
    ob-go
    ob-diagrams
    # ob-restclient
    org-drill
    free-keys

    # To Organize
    org-bullets

    python-pytest

  ])

  ++ (with epkgs.orgPackages; [


    ## ORG ##
    ####################
    # org-plus-contrib #
    ####################
    org

  ])

  ++ ([

    imagemagickBig

  ]) ++

  [(emacsPackagesNg.trivialBuild {
    pname = "robs-emacs-mode";
    version = "1970-01-01";
    src = mutate ./default.el {
      inherit msmtp graphviz;
      spelling = hunspellWithDicts ([hunspellDicts.en-us]);
      schemas = writeText "schemas.xml" ''
          <locatingRules xmlns="http://thaiopensource.com/ns/locating-rules/1.0">
            <documentElement localName="section" typeId="DocBook"/>
            <documentElement localName="chapter" typeId="DocBook"/>
            <documentElement localName="article" typeId="DocBook"/>
            <documentElement localName="book" typeId="DocBook"/>
            <typeId id="DocBook" uri="${docbook5}/xml/rng/docbook/docbookxi.rnc" />
          </locatingRules>
        '';
    };
  })]
))
