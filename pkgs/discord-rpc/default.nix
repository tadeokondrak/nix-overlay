{ stdenv, fetchFromGitHub, cmake, rapidjson, examples ? false }:

stdenv.mkDerivation rec {
  pname = "discord-rpc";
  version = "3.4.0";

  src = fetchFromGitHub {
    owner = "discordapp";
    repo = pname;
    rev = "v${version}";
    sha256 = "04cxhqdv5r92lrpnhxf8702a8iackdf3sfk1050z7pijbijiql2a";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ rapidjson ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=true"
    "-DBUILD_EXAMPLES=" + (if examples then "true" else "false")
  ];

  meta = with stdenv.lib; {
    description = "Simple Python script that adds CSS hot-reload to Discord";
    homepage = https://github.com/leovoel/BeautifulDiscord;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
