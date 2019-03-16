{ stdenv, python37Packages, fetchFromGitHub, fetchpatch }:

python37Packages.buildPythonApplication rec {
  pname = "mydiscord";
  version = "20180901";

  src = fetchFromGitHub {
    owner = "justinoboyle";
    repo = pname;
    rev = "0a4e3b2dcb8afff3b66a28d5893eed705627be40";
    sha256 = "144kpdr9alqdpcjckk10kp7xzrv6l04xcwwqp6hqngykz7hj5zr3";
  };

  patches = [
    ./nixos-find-discord.patch
  ];

  doCheck = false;

  propagatedBuildInputs = with python37Packages; [ psutil ];

  meta = with stdenv.lib; {
    description = "Automagically adds custom CSS and JS support to Discord";
    homepage = https://github.com/justinoboyle/mydiscord;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
    broken = true;
  };
}
