{ stdenv, writeScript, bash, coreutils, discord, beautifuldiscord, cssFile ? null }:

stdenv.mkDerivation rec {
  pname = "discord-css";
  version = "0.0.1";

  path = stdenv.lib.makeSearchPath "bin" [ coreutils discord beautifuldiscord ];
  src = writeScript "discord" ''
    #!/usr/bin/env bash
    PATH="${path}"
    CSS_FILE="${cssFile}"
    touch "$HOME/.cache/cssname"
    if [[ "$(cat "$HOME/.cache/cssname")" == "$CSS_FILE" ]]; then
      Discord
    else
      Discord & beautifuldiscord --css "$CSS_FILE"
      echo "$CSS_FILE" > "$HOME/.cache/cssname"
    fi
  '';

  unpackPhase = ''
    cp $src discord
  '';

  installPhase = ''
    install -D discord $out/bin/discord
  '';
}
