{ stdenv, fetchFromGitHub, qmake, pkg-config, qtbase, qtdeclarative, libpng_apng, zlib, libarchive }:

# TODO: desktop entry

stdenv.mkDerivation rec {
  pname = "cemu";
  version = "1.2";
  rev = "1621ab4c8acd4c9e251b63e3b4a8db6f77e16066";

  src = fetchFromGitHub {
    owner = "CE-Programming";
    repo = "CEmu";
    inherit rev;
    sha256 = "1bll3bzkpyqy9xmlvfj8b0s5v6pgvgykgvm5w0pf07w1gxpcjkn6";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ qmake pkg-config ];
  buildInputs = [ qtbase qtdeclarative libpng_apng zlib libarchive ];

  preConfigure = ''
    substituteInPlace gui/qt/CEmu.pro --replace \
        '$$system(git describe --abbrev=7 --always)' \
        "${builtins.substring 0 7 rev}"
  '';

  qmakeFlags = [ "-r gui/qt/CEmu.pro" "TARGET_NAME=cemu" "CEMU_VERSION=v${version}" "USE_LIBPNG=system" ];
}
