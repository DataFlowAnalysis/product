{
  description = "DataFlowAnalysis Product - Eclipse-based RCP product for the data flow analysis";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = nixpkgs.legacyPackages.${system}.mkShellNoCC {
        packages = with pkgs; [
          git
          maven
          openjdk21
        ];
      };
    });
  };
}
