{ stdenv, fetchFromGitHub, autoPatchelfHook, gtk3, pango, cairo, libcxx, glib }:

stdenv.mkDerivation rec {
  pname = "sciter-sdk";
  version = "4.2.6.9";

  src = fetchFromGitHub {
    owner = "c-smile";
    repo = pname;
    rev = "c926703b2cce972875e7f6379c525eef66c95986";
    sha256 = "1wg4hvmlafkv1pd5snwxqqz36jgb8fvspfbvyc56pdqd5c19988s";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gtk3
    pango
    libcxx
    cairo
    glib
  ];

  installPhase = ''
    install -D bin.gtk/x64/libsciter-gtk.so $out/lib/libsciter-gtk.so
  '';
}
