{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    buildInputs = with pkgs; [
      quickshell
      kdePackages.qtdeclarative
    ];
  in {
    devShells.${system}.default = pkgs.mkShell {
      inherit buildInputs;
    };
    packages.${system}.default = pkgs.writeShellApplication {
      name = "cshell";
      runtimeInputs = with pkgs;
        [
          brightnessctl
          swaynotificationcenter
        ]
        ++ buildInputs;

      text = ''
        qs -p ${./.}/src "$@"
      '';
    };
  };
}
