{ stdenv, fetchurl, fetchzip, cabextract, xvfb_run, wine }:

stdenv.mkDerivation rec {
  pname = "wineprefix";
  version = "yes";

  src = /var/empty;

  dotnet40 = (fetchurl {
    url = "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe";
    sha256 = "65e064258f2e418816b304f646ff9e87af101e4c9552ab064bb74d281c38659f";
  });

  dotnet45 = (fetchurl {
    url = "https://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe";
    sha256 = "a04d40e217b97326d46117d961ec4eda455e087b90637cb33dd6cc4a2c228d83";
  });

  gdiplus = (fetchzip {
    name = "gdiplus.dll";
    url = "https://download.microsoft.com/download/0/A/F/0AFB5316-3062-494A-AB78-7FB0D4461357/windows6.1-KB976932-X86.exe";
    sha256 = "12qxjbilrikkf15hgqpvbc4vqd01hmrk439x08j7fc92m5ifjp52";
    downloadToTemp = true;
    postFetch = ''
      ${cabextract}/bin/cabextract $downloadedFile \
          --filter x86_microsoft.windows.gdiplus_6595b64144ccf1df_1.1.7601.17514_none_72d18a4386696c80/gdiplus.dll
      install -D */gdiplus.dll $out
    '';
  });

  buildInputs = [ xvfb_run wine ];

  buildPhase = ''
    # Create the prefix
    mkdir $out
    export WINEARCH=win32
    export WINEPREFIX=$out
    xvfb-run wineboot -u

    # Remove Mono
    listing="$(wine uninstaller --list | grep "Wine Mono")"
    guid="''${listing%%\|*}"
    wine uninstaller --remove "$guid"
    rm -f "$WINEPREFIX/windows/system32/mscoree.dll"

    # Install dotnet

    ## dotnet40
    WINEDLLOVERRIDES=fusion=b wine $dotnet40 /q /c:"install.exe /q"
    wine reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Install /t REG_DWORD /d 0001 /f
    wine reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Version /t REG_SZ /d "4.0.30319" /f

    ## dotnet45
    WINEDLLOVERRIDES=fusion=b wine $dotnet45 /q /c:"install.exe /q"

    # Install gdiplus
    install -D $gdiplus $WINEPREFIX/windows/system32/gdiplus.dll

    # Registry edit to:
    # - Enable dotnet/gdiplus
    # - Set directsound low latency settings
    cat > edit.reg << EOF
    Windows Registry Editor Version 5.00

    [HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]
    "*gdiplus"="native"
    "*mscoree"="native"

    [HKEY_CURRENT_USER\Software\Wine\DirectSound]
    "HelBuflen"="512"
    "SndQueueMax"="3"
    EOF
    wine regedit edit.reg

    # Don't finish until wine is closed.
    wineserver -w
  '';

  installPhase = "
  ";

  meta = with stdenv.lib; {
    license = licenses.unfree;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.linux;
    broken = !stdenv.isi686;
  };
}
