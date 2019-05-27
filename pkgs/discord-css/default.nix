{ writers, lib, coreutils, discord, nodePackages }:

let
  js = ''let __path = require("../common/paths").getUserData(); mainWindow.webContents.on("dom-ready", () => mainWindow.webContents.executeJavaScript(require("fs").readFileSync(`''${__path}/custom.js`, "utf-8")));'';
in writers.writeBashBin "discord-css" ''
  PATH="${lib.makeSearchPath "bin" [ discord nodePackages.asar ]}:$PATH"

  set -e

  discord=${discord.meta.name}
  branch=''${discord%-*}
  version=''${discord##*-}

  case "$branch" in
      "discord")
          configpath=''${XDG_CONFIG_HOME:-$HOME/.config}/discord
          bin=Discord
          ;;
      "discord-ptb")
          configpath=''${XDG_CONFIG_HOME:-$HOME/.config}/discordptb
          bin=DiscordPTB
          ;;
      "discord-canary")
          configpath=''${XDG_CONFIG_HOME:-$HOME/.config}/discordcanary
          bin=DiscordCanary
          ;;
  esac

  [[ ! -f "$configpath/.discord-css-$version" ]] && {
    pushd $configpath/$version/modules/discord_desktop_core > /dev/null

    asar e core.asar core
    pushd core/app > /dev/null

    sed -i 's|mainWindow.on('\'''blur|${js}mainWindow.on('\'''blur|g' mainScreen.js

    popd > /dev/null

    asar p core core.asar

    popd > /dev/null
  }

  $bin
''
