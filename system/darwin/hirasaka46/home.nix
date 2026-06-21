{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sl
    gti
    typst
    texlivePackages.haranoaji
    texlivePackages.haranoaji-extra
  ];

  home.sessionVariables.TYPST_FONT_PATHS =
    "${pkgs.texlivePackages.haranoaji.tex}/fonts/opentype/public/haranoaji"
    + ":"
    + "${pkgs.texlivePackages.haranoaji-extra.tex}/fonts/opentype/public/haranoaji-extra";
}
