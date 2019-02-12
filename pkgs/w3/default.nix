{ stdenv, fetchFromGitHub, python3, writeText, weechat, makeWrapper }:

stdenv.mkDerivation rec {
  name = "w3";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "qguv";
    repo = name;
    rev = version;
    sha256 = "1s1m88fbxkr01p5vblbfx5rg5l15z4wr8flm69zs3g5n7ak664m6";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ];

  installPhase = ''
    install -Dm755 w3 $out/bin/w3
    wrapProgram $out/bin/w3 --prefix PATH : "${weechat}/bin"
  '';
}
