{ stdenv, fetchFromGitHub, libxcb, xcbutilwm, xcbutilkeysyms, xorgproto }:

stdenv.mkDerivation rec {
  pname = "windowchef";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "tudurom";
    repo = pname;
    rev = "v${version}";
    sha256 = "02fvb8fxnkpzb0vpbsl6rf7ssdrvw6mlm43qvl2sxq7zb88zdw96";
  };

  buildInputs = [
    libxcb
    xcbutilwm
    xcbutilkeysyms
    xorgproto
  ];

  installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
}
