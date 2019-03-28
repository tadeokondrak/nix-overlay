{ stdenv, fetchFromGitHub, meson, ninja, pkg-config, curl, perl, moonscript }:

stdenv.mkDerivation rec {
  pname = "ffi-experiments";
  version = "e8d9c915390aaa8ffa1d220f4696f4fe2ca6ae6e";

  src = fetchFromGitHub {
    owner = "TypesettingTools";
    repo = pname;
    rev = version;
    sha256 = "0fcas1gnpapl7z27w0bk7cif902ylcnmgxcd3iq615ppgq86yh9z";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];

  buildInputs = [ curl perl moonscript ];

  outputs = [
    "out"
    "BadMutex"
    "DownloadManager"
    "PreciseTimer"
    "requireffi"
  ];

  postBuild = ''
    ninja lua
  '';

  installPhase = ''
    install -D bad-mutex/BadMutex.lua   $BadMutex/share/aegisub/automation/include/BM/BadMutex.lua
    install -D bad-mutex/libBadMutex.so $BadMutex/share/aegisub/automation/include/BM/BadMutex/libBadMutex.so

    install -D download-manager/DownloadManager.lua  $DownloadManager/share/aegisub/automation/include/DM/DownloadManager.lua
    install -D download-manager/libDownloadManager.so $DownloadManager/share/aegisub/automation/include/DM/DownloadManager/libDownloadManager.so

    install -D precise-timer/PreciseTimer.lua $PreciseTimer/share/aegisub/automation/include/PT/PreciseTimer.lua
    install -D precise-timer/libPreciseTimer.so $PreciseTimer/share/aegisub/automation/include/PT/PreciseTimer/libPreciseTimer.so

    install -D requireffi/requireffi.lua $requireffi/share/aegisub/automation/include/requireffi/requireffi.lua

    mkdir -p $out/share/aegisub/automation/include
    ln -s {$BadMutex,$DownloadManager,$PreciseTimer,$requireffi}/share/aegisub/automation/include/* $out/share/aegisub/automation/include/
  '';
}
