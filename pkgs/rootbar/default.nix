{ stdenv, fetchhg, pkg-config, wayland, gtk3, json_c, libpulseaudio }:

stdenv.mkDerivation rec {
  pname = "rootbar";
  version = "26f34a1125598fb6b033198363cd0dfdbda67054";

  src = fetchhg {
    url = "https://hg.sr.ht/~scoopta/rootbar";
    rev = version;
    sha256 = "1gfbqw0y8l3zr6zdxbscspj9i3r761hvzyk15776gxxnbxm7dkl2";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ wayland gtk3 json_c libpulseaudio ];

  preConfigure = "cd Release";

  installPhase = "install -D rootbar $out/bin/rootbar";
}
