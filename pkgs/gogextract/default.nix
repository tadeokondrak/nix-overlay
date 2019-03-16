{ stdenv, fetchFromGitHub, python3 }:

stdenv.mkDerivation rec {
  pname = "gogextract";
  version = "6601b32feacecd18bc12f0a4c23a063c3545a095";

  src = fetchFromGitHub {
    owner = "Yepoleb";
    repo = pname;
    rev = version;
    sha256 = "0hh4hc9mskawsph859cx5n194qkwa3122gkcsywm917n77fncfq5";
  };

  buildInputs = [ python3 ];

  installPhase = ''
    install -D gogextract.py $out/bin/gogextract
  '';
}
