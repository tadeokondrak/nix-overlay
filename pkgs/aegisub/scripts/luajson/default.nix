{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "luajson-aegisub";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "harningt";
    repo = "luajson";
    rev = version;
    sha256 = "0hl0fii62hrzba1ra9l0l1yhq50xvfargwq7ncmfz9s6vs66r8i5";
  };

  installPhase = ''
    mkdir -p $out/share/aegisub/automation/include
		mv lua/* $out/share/aegisub/automation/include/
  '';
}
