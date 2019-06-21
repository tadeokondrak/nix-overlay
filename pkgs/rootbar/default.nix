{ stdenv, fetchhg, pkg-config, wayland, gtk3, json_c, libpulseaudio }:

stdenv.mkDerivation rec {
  pname = "rootbar";
  version = "b37193337ed5";

  src = fetchhg {
    url = "https://hg.sr.ht/~scoopta/rootbar";
    rev = version;
    sha256 = "0kdy60jfwdrhbn895rp1wkpfpnfcq9npyhmnrw3bbrx43cnw0n47";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ wayland gtk3 json_c libpulseaudio ];

  preConfigure = "cd Release";

  installPhase = "install -D rootbar $out/bin/rootbar";
}
