{ stdenv, fetchhg, wayland, libGL, libX11 }:

stdenv.mkDerivation rec {
  name = "glpaper-${rev}";
  rev = "94c2ad7cb96dbd03c1655af356a6b282c590fbac";

  src = fetchhg {
    url = "https://bitbucket.org/Scoopta/glpaper";
    inherit rev;
    sha256 = "1b2ypd72ayvqsywlwwvrbzr01f7i16d3090nq7qpd1n49ww6gn2p";
  };

  buildInputs = [ wayland libGL libX11 ];

  preBuild = "cd Release";

  installPhase = "install -D glpaper $out/bin/glpaper";
}
