{ lib, pkgs, ... }:
let
  libbeaker = pkgs.stdenv.mkDerivation {
    pname = "libbeaker";
    version = "0.0.0";
    src = fetchGit {
      url = "https://git.bwaaa.monster/beaker";
      rev = "abc598baf15d6f8a4de395a27ba34b1e769558e1";
    };
    buildInputs = with pkgs; [ pkg-config ];
    buildPhase = "make ";
    installPhase = ''
      mkdir -p "$out"
      make INSTALL_PREFIX="$out/" LDCONFIG="ldconfig -C /tmp/ld.so.cache" info install
    '';
  };

  omnisearch-pkg = pkgs.stdenv.mkDerivation {
    pname = "omnisearch";
    version = "0.0.0";
    src = fetchGit {
      url = "https://git.bwaaa.monster/omnisearch";
      rev = "ddf39b56505a3a83bf888e245068160b4b5f24bd";
    };
    buildInputs = with pkgs; [
      curl
      libxml2
      libbeaker
      pkg-config
    ];
    buildPhase = ''
      make CFLAGS="-Wall -Wextra -O2 -Isrc -I${pkgs.libxml2.dev}/include/libxml2" all
    '';
    installPhase = ''
      mkdir -p $out/bin $out/etc/omnisearch/{templates,static}
      cp -rf bin/* "$out/bin"
    '';
  };
in
omnisearch-pkg
