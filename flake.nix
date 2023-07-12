{
  description = "A development environment for my latex resume";

  inputs = {
    # Not sure how well tested we are right now,
    # so pinned to a stable nixpkgs
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
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
            pkgs.rsync

            # TODO: This downloades *every* TexLive packages
            # While there is nothging exactly wrong with this,
            # it does download way more than is truly necessary
            # for generating resumes.
            # It would be better to follow the Nix documentation
            # for downloading a subset of TeX packages
            # https://nixos.wiki/wiki/TexLive
            # Additionally, we will have to use the scheme-medium
            # TeXLive package as that is the only one that
            # includes the latexmk package
            pkgs.texlive.combined.scheme-full

            # Misc dependencies
            pkgs.just
          ];
        };
    };
}
