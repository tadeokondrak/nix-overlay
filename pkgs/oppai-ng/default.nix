{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "oppai-ng";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "Francesco149";
    repo = pname;
    rev = version;
    sha256 = "0qxr7ybpm5g3la908vzk7f3gr384vprv8xq92kf7n1p1g85bbxrw";
  };

  buildPhase = ''
    ./build
  '';

  installPhase = ''
    install -D oppai $out/bin
  '';
}
