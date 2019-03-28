{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "yutils";
  version = "17012015";

  src = fetchFromGitHub {
    owner = "Youka";
    repo = "Yutils";
    rev = version;
    sha256 = "1b1jzqds4n6kxfxzwmrgwsmck3xi27bbbn549wb6c176brn9m9af";
  };

  installPhase = ''
    install -D src/Yutils.lua $out/share/aegisub/automation/autoload/Yutils.lua
  '';
}
