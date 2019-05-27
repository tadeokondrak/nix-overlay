{ stdenv, fetchhg, pkg-config, wayland, gtk3, json_c, libpulseaudio }:

stdenv.mkDerivation rec {
  pname = "rootbar";
  version = "7119b6b34dc7";

  src = fetchhg {
    url = "https://hg.sr.ht/~scoopta/rootbar";
    rev = version;
    sha256 = "0chwxbvb66hrmbqi6gz5kaf5lfr2z7vm685gpdk77j2c0ydbnmw3";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ wayland gtk3 json_c libpulseaudio ];

  preConfigure = "cd Release";

  installPhase = "install -D rootbar $out/bin/rootbar";
}
