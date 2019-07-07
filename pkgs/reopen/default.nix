{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "reopen";
  version = "e12088f0780a2b7f0bfe43dcc022aa52396ab5df";

  src = fetchFromGitHub {
    owner = "tadeokondrak";
    repo = pname;
    rev = version;
    sha256 = "0rj4syfxnjbfparrs7cfamwyb7bjl59c6j0ag5zxfigpw98l18g5";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  postInstall = ''
    ln -s $out/bin/reopen $out/bin/xdg-open
  '';
}
