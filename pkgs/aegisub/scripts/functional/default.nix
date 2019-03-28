{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "functional";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = "Functional";
    rev = "v${version}";
    sha256 = "19mp5hfbmyb1xqwllyl5acy22ipy07k9v4ggbhqm23n5kr8l8g57";
  };

  installPhase = ''
    install -D Functional.moon $out/share/aegisub/automation/autoload/Functional.moon
  '';
}
