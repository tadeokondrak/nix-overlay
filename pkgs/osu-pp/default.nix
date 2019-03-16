{ stdenv, libmfao, oppai-ng }:

stdenv.mkDerivation {
  name = "osu-pp";

  src = libmfao.src;

  buildInputs = [ libmfao oppai-ng ];

  buildPhase = ''
    gcc -O3 examples/osu.c -lm -o osu
  '';

  installPhase = ''
    install -D osu $out/bin/osu-pp
  '';
}
