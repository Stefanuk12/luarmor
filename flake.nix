{
  description = "Luarmor documentation (Mintlify)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        # The Mintlify CLI is only published to npm, so run it through npx
        # with a pinned Node version instead of packaging it.
        mintlify = pkgs.writeShellApplication {
          name = "mintlify";
          runtimeInputs = [ pkgs.nodejs_22 ];
          text = ''
            exec npx --yes mintlify@latest "$@"
          '';
        };
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.mintlify;
      });

      apps = forAllSystems (pkgs: {
        # nix run: start the local preview server
        default = {
          type = "app";
          meta.description = "Start the Mintlify preview server";
          program = "${pkgs.writeShellScript "mintlify-dev" ''
            exec ${self.packages.${pkgs.stdenv.hostPlatform.system}.mintlify}/bin/mintlify dev "$@"
          ''}";
        };
        # nix run .#broken-links: check internal links
        broken-links = {
          type = "app";
          meta.description = "Check the docs for broken links";
          program = "${pkgs.writeShellScript "mintlify-broken-links" ''
            exec ${self.packages.${pkgs.stdenv.hostPlatform.system}.mintlify}/bin/mintlify broken-links "$@"
          ''}";
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.mintlify
            pkgs.nodejs_22
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
