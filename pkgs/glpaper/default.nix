{ stdenv, fetchhg, wayland, libGL, libX11 }:

stdenv.mkDerivation rec {
  name = "glpaper-${rev}";
  rev = "2e5f6c69c78e7da5e860714f79708d555f60691f";

  src = fetchhg {
    url = "https://bitbucket.org/Scoopta/glpaper";
    inherit rev;
    sha256 = "0pal98h8pvd1dqyrj6ykdb46lp5m0lz5bwdz9mw3v59wzrxs0wfy";
  };

  buildInputs = [ wayland libGL libX11 ];

  preBuild = "cd Release";

  installPhase = "install -D glpaper $out/bin/glpaper";
}
