{ stdenv, fetchFromGitHub, git, nodejs, nodePackages, discord }:

stdenv.mkDerivation rec {
  pname = "betterdiscordctl";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "bb010g";
    repo = pname;
    rev = "2094539792a68595c294e3c4160f3d677366b29f";
    sha256 = "0hfqa7qppzvbb66jjqwpw6p18hkxjh20fld8nznrpjd8xrajz8kv";
  };

  pathAdd = stdenv.lib.makeSearchPath "/bin" [ git nodejs nodePackages.asar ];

  installPhase = ''
    sed -i "s@^scan=/opt@scan=${discord}/opt@g" betterdiscordctl
    sed -i 's/^DISABLE_UPGRADE=$/DISABLE_UPGRADE=yes/' betterdiscordctl
    sed -i 's/^global_asar=$/global_asar=yes/' betterdiscordctl
    sed -i -e '2i PATH="${pathAdd}:$PATH"' betterdiscordctl
    install -D betterdiscordctl $out/bin/betterdiscordctl
  '';

  meta = with stdenv.lib; {
    description = "A utility for managing BetterDiscord on Linux";
    homepage = https://github.com/bb010g/betterdiscordctl;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.linux;
  };
}
