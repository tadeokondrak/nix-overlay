{ stdenv, fetchFromGitHub, wayland, pkgconfig, meson, ninja }:

stdenv.mkDerivation rec {
  pname = "wlr-randr";
  version = "c4066aa3249963dc7877119cffce10f3fa8b6304";

  src = fetchFromGitHub {
    owner = "emersion";
    repo = pname;
    rev = version;
    sha256 = "1ahw4sv07xg5rh9vr7j28636iaxs06vnybm3li6y8dz2sky7hk88";
  };

  nativeBuildInputs = [ pkgconfig meson ninja ];
  buildInputs = [ wayland ];

  postInstall = "mv $out/bin/wlr-randr $out/bin/xrandr";
}
