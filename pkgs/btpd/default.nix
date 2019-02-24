{ stdenv, fetchFromGitHub, autoreconfHook, openssl }:

stdenv.mkDerivation rec {
  pname = "btpd";
  version = "0.16";

  src = fetchFromGitHub {
    owner = "btpd";
    repo = pname;
    rev = "v${version}";
    sha256 = "0r8jml306jjfr0cpmgjv78kjln0pq899vj1v3pgnys2j6i3wq9s0";
  };

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ openssl ];
}
