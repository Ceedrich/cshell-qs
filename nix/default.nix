{...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    buildInputs = with pkgs; [
      quickshell
      kdePackages.qtdeclarative
    ];
  in {
    devShells.default = pkgs.mkShell {inherit buildInputs;};

    packages.default = self'.packages.cshell;

    packages.cshell = pkgs.writeShellApplication {
      name = "cshell";
      runtimeInputs = with pkgs;
        [
          brightnessctl
          swaynotificationcenter
        ]
        ++ buildInputs;

      text = ''
        qs -p ${./../src} "$@"
      '';
    };
  };
}
