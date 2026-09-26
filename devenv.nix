{pkgs, ...}: {
  packages = with pkgs; [quickshell kdePackages.qtdeclarative];
  delta.enable = true;

  processes."qs".exec = "qs -p .";
}
