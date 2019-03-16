{ stdenv, fetchFromGitHub, oppai-ng }:

stdenv.mkDerivation rec {
  pname = "libmfao";
  rev = "f8675115c58bb7cb0952bb3a7f19be97622c414d";
  name = "${pname}-${rev}";

  src = fetchFromGitHub {
    owner = "Francesco149";
    repo = pname;
    inherit rev;
    sha256 = "0jdm3gz3i8wiam48941r1y9lfl43xhq9wgr58sfp37p1gxqibw5l";
  };

  buildPhase = ''
    ./libbuild.sh
  '';

  installPhase = ''
    install -D mfao.c $out/include/mfao.c
    install -D libmfao.so $out/lib/libmfao.so
  '';
}
