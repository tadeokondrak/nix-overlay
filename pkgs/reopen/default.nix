{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "reopen";
  version = "653a2e6772c0ff96ba195c65655f457c1002629f";

  src = fetchFromGitHub {
    owner = "tadeokondrak";
    repo = pname;
    rev = version;
    sha256 = "13gi6fq6a56vmpn9z3w5mca0lfrdh23nbwlljyng8akwcglinl2n";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  postInstall = ''
    ln -s $out/bin/reopen $out/bin/xdg-open
  '';
}
