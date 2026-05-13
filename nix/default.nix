{
  inputs,
  self,
  ...
}: {
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

  flake.nixosModules.default = self.nixosModules.cshell;
  flake.nixosModules.cshell = {
    pkgs,
    lib,
    ...
  }: let
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.cshell;
  in {
    environment.systemPackages = [package];

    systemd.user.services."cshell" = {
      enable = true;
      wantedBy = ["graphical-session.target"];
      description = "CShell, my graphical shell";

      serviceConfig = {
        Type = "simple";
        ExecStart = lib.getExe package;
      };
    };
  };
}
