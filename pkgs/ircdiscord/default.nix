{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "IRCdiscord";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "tadeokondrak";
    repo = pname;
    rev = version;
    sha256 = "1j1v6kfjdyhslvm9fspjz9pzmgj21qivp9z41b2d23xcd26fw12f";
  };

  modSha256 = "1vx0vz8ffznlp8z1bnvdxgdd7gmy3sgalrgb4h11n4hp7c782zil";
}
