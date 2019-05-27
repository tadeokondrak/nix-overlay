{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "wl-clipboard-x11";
  version = "3";

  src = fetchFromGitHub {
    owner = "brunelli";
    repo = pname;
    rev = "v${version}";
    sha256 = "0map1kqygjdavcbvsgjlnhqy7rmly7cfn6i9cf881h59rp846453";
  };

  makeFlags = [ "PREFIX=$(out)" ];
}
