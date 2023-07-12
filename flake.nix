{
  description = "A development environment for my latex resume";

  inputs = {
    # Not sure how well tested we are right now,
    # so pinned to a stable nixpkgs
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in {
      devShells.${system}.default =
        pkgs.mkShell {
          packages = [
            pkgs.gnumake
            pkgs.dhall
            pkgs.texlive.combined.scheme-medium
            pkgs.rsync

            # Misc dependencies
            # pkgs.just
          ];
        };
    };
}
