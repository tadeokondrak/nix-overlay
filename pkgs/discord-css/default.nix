{ writers, lib, coreutils, discord, beautifuldiscord, cssFile ? null }:

(writers.writeBashBin "discord-css" ''
  PATH="${lib.makeSearchPath "bin" [ discord coreutils beautifuldiscord ]}"
  cssfile="${cssFile}"
  touch "$HOME/.cache/cssname"
  if [[ "$(cat "$HOME/.cache/cssname")" == "$cssfile" ]]; then
    Discord
  else
    Discord & beautifuldiscord --css "$cssfile"
    echo "$cssfile" > "$HOME/.cache/cssname"
  fi
'')
