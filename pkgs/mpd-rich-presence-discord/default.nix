{ stdenv, fetchFromGitHub, cmake, discord-rpc, mpd_clientlib }:

stdenv.mkDerivation rec {
  name = "mpd-rich-presence-discord";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "SSStormy";
    repo = name;
    rev = "26a5c4a08f4765791978df5e80d1a0379df7732b";
    sha256 = "0ddmcq2cirxgsmb2l1hrmqhxirxsg57q5dldk1idki21k7p0f299";
  };
  nativeBuildInputs = [ cmake mpd_clientlib ];
  buildInputs = [ discord-rpc ];
  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
  installPhase = ''
    install -D mpd_discord_richpresence $out/bin/mpd_discord_richpresence
  '';
}
