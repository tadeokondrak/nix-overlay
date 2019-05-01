{ stdenv, fetchFromGitHub, libxcb, xcbutil, xcbutilwm, libconfig, pcre }:

stdenv.mkDerivation rec {
  pname = "custard";
  version = "unstable-2019-04-28";

  src = fetchFromGitHub {
    owner = "Sweets";
    repo = pname;
    rev = "13b2cfce767b8abb487288ce7c0bf21532d1a927";
    sha256 = "077ik4jnwdcvnj7z27hrw65kdnx02qnia979mcf90dqwiafz0vxg";
  };

  buildInputs = [ libxcb xcbutil xcbutilwm libconfig pcre ];

  makeFlags = [
    "CFLAGS=-Wno-format-security"
    "PREFIX="
    "DESTDIR=$(out)"
  ];
}
