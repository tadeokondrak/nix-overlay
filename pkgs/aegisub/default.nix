{ config, stdenv, fetchFromGitHub, autoreconfHook
, pkgs, buildEnv, makeWrapper
, libX11, wxGTK31
, libiconv, fontconfig, freetype
, libGLU_combined
, libass, fftw, ffms
, ffmpeg, pkgconfig, zlib # Undocumented (?) dependencies
, icu, boost, intltool # New dependencies
, spellcheckSupport ? true, hunspell ? null
, automationSupport ? true, lua ? null
, openalSupport ? false, openal ? null
, alsaSupport ? stdenv.isLinux, alsaLib ? null
, pulseaudioSupport ? config.pulseaudio or stdenv.isLinux, libpulseaudio ? null
, portaudioSupport ? false, portaudio ? null }:

assert spellcheckSupport -> (hunspell != null);
assert automationSupport -> (lua != null);
assert openalSupport -> (openal != null);
assert alsaSupport -> (alsaLib != null);
assert pulseaudioSupport -> (libpulseaudio != null);
assert portaudioSupport -> (portaudio != null);

with stdenv.lib;
let
  aegisubScripts = import ./scripts { inherit stdenv pkgs; };

  withScripts = scripts: buildEnv {
    name = "aegisub-scripts-env";
    paths = scripts aegisubScripts ++ [ aegisub ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      unlink $out/bin
      for bin in ${aegisub}/bin/*; do
          makeWrapper "$bin" "$out/bin/$(basename "$bin")" \
              --set AEGISUB_DATA_DIR "$out/share/aegisub"
      done
    '';
  };

  aegisub = stdenv.mkDerivation rec {
    pname = "aegisub";
    version = "75fc5f38d79ac2a776f6ccc452a8b7b3cd85c397";

    src = fetchFromGitHub {
      owner = "TypesettingTools";
      repo = "Aegisub";
      rev = version;
      sha256 = "05q62xikg2im783cjczydfzn7zimxlw5ysbmpf8jv5xwllhdlfm0";
    };

    patches = [ ./use-env-var-for-data-dir.patch ];

    postPatch = ''
      # set version, because git
      cat << EOF > build/git_version.h
      #define BUILD_GIT_VERSION_NUMBER 0
      #define BUILD_GIT_VERSION_STRING "${version}"
      #define TAGGED_RELEASE 1
      EOF

      # set hunspell dir
      substituteInPlace libaegisub/unix/path.cpp \
          --replace /usr/share/hunspell $hunspell/share/hunspell
    '';

    configureFlags = [
      "--with-boost-libdir=${boost}/lib" # autoconf expects a different location
    ];

    nativeBuildInputs = [ autoreconfHook pkgconfig intltool ];

    buildInputs = with stdenv.lib;
    [ libX11 wxGTK31 fontconfig freetype libGLU_combined
      libass fftw ffms ffmpeg zlib icu boost libiconv
    ]
      ++ optional spellcheckSupport hunspell
      ++ optional automationSupport lua
      ++ optional openalSupport openal
      ++ optional alsaSupport alsaLib
      ++ optional pulseaudioSupport libpulseaudio
      ++ optional portaudioSupport portaudio
      ;

    enableParallelBuilding = true;

    hardeningDisable = [ "bindnow" "relro" ];

    passthru = {
      scripts = aegisubScripts;
      inherit withScripts;
    };

    meta = {
      description = "An advanced subtitle editor";
      longDescription = ''
        Aegisub is a free, cross-platform open source tool for creating and
        modifying subtitles. Aegisub makes it quick and easy to time subtitles to
        audio, and features many powerful tools for styling them, including a
        built-in real-time video preview.
      '';
      homepage = http://www.aegisub.org/;
      license = licenses.bsd3;
                # The Aegisub sources are itself BSD/ISC,
                # but they are linked against GPL'd softwares
                # - so the resulting program will be GPL
      maintainers = with maintainers; [ tadeokondrak ];
      platforms = [ "i686-linux" "x86_64-linux" ];
    };
  };
in
  aegisub
