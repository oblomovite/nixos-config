{ stdenv, jdk11, rlwrap, makeWrapper}:

stdenv.mkDerivation rec {
  pname = "clojure-lsp";
  version = "1.10.1.489";
  clojure-lsp  = builtins.fetchGit {
    owner = "snoe";
    url = "https://github.com/snoe/clojure-lsp.git";
    rev = "${version}";
    ref = "master";
    sha256 = "100l28z0rgfjsl9qpkda3iafa7005jcfh1wd6hwvpmwc5ks4vm1x";
  };

  buildInputs = [ makeWrapper ];

  outputs = [ "out" "prefix" ];

  installPhase = let
    binPath = stdenv.lib.makeBinPath [ rlwrap jdk11 ];
  in ''
      mkdir -p $out/bin

      # Copy the script there and make it executable
      cp clojure-lsp $out/bin
      chmod +x $out/bin/clojure-lsp
  '';

}
