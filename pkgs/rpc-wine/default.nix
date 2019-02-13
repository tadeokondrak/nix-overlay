{ stdenv, fetchFromGitHub, rapidjson, wine, wineWowPackages }:

stdenv.mkDerivation rec {
  pname = "rpc-wine";
  version = "1.0.0";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "Marc3842h";
    repo = pname;
    rev = version;
    sha256 = "05mchqfal2skb3bxm62a55rya8b5ql0zxiwjn41ijzcycfy1p825";
  };

  nativeBuildInputs = [ (if stdenv.targetPlatform.system == "i686-linux" then wine else wineWowPackages.stable) ];
  buildInputs = [ rapidjson ];

  buildPhase = ''
    bash build.sh --skip-${if stdenv.targetPlatform.system == "i686-linux" then "64" else "32"}-bit
  '';

  installPhase = ''
    install bin*/discord-rpc.dll.so -D $out/lib/wine/discord-rpc.dll.so
  '';

  meta = with stdenv.lib; {
    description = "discord-rpc.dll implementation for Wine allowing your Wine games to interact with your native Discord instance";
    homepage = https://github.com/Marc3842h/rpc-wine;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
