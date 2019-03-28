{ lib }:

{ modules ? []
, macros ? []
, prefix ? ""
, modulePrefix ? prefix
, macroPrefix ? prefix
, language ? "moon"
, modulePath ? "modules/"
, macroPath ? "macros/"
}:

''
  mkdir -p $out/share/aegisub/automation/{autoload,include}

  ${lib.concatStringsSep "\n" (builtins.map (output: ''
  install -D "${macroPath}${macroPrefix}${output}.${language}" \
      ''${${output}}/share/aegisub/automation/autoload/"${macroPrefix}${output}.${language}"

  ln -s ''${${output}}/share/aegisub/automation/autoload/* \
      $out/share/aegisub/automation/autoload/
  '') macros)}

  ${lib.concatStringsSep "\n" (builtins.map (output: ''
  [[ -d ${modulePath}${modulePrefix}${output} ]] && {
      mkdir -p ''${${output}}/share/aegisub/automation/{autoload,include}
      cp -r "${modulePath}${modulePrefix}${output}" \
          ''${${output}}/share/aegisub/automation/include/
  }

  install -D "${modulePath}${modulePrefix}${output}.${language}" \
      ''${${output}}/share/aegisub/automation/include/"${modulePrefix}${output}.${language}"

  ln -s ''${${output}}/share/aegisub/automation/include/* \
      $out/share/aegisub/automation/include/
  '') modules)}
''
