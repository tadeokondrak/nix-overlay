{ stdenv, fetchFromGitHub, wlroots, wayland, udev, libGL, libX11, meson, ninja, pkg-config }:

stdenv.mkDerivation rec {
  pname = "kiwmi";
  version = "b5e30f356a95750346e2273f1e4e29810f912f5c";

  src = fetchFromGitHub {
    owner = "buffet";
    repo = pname;
    rev = version;
    sha256 = stdenv.lib.fakeSha256;
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ wlroots wayland udev libGL libX11 ];

  mesonFlags = [ "-Dkiwmi-version=${version}" ];
}
