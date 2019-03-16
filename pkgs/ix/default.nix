{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "ix";

  src = fetchurl {
    url = "https://ix.io/client";
    sha256 = "a7f8ff373eedccb255ec7814c15b22c0dd56c42c783e8afe1f24601534d18275";
  };

  unpackPhase = ''
    cp $src ix
  '';

  installPhase = ''
    install -Dm755 ix $out/bin/ix
  '';
}
