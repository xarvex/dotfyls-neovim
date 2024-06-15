{
  description = "Personal Neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; # do not override/follow

    flake-parts.url = "github:hercules-ci/flake-parts";

    systems.url = "github:nix-systems/default";
  };

  outputs = { flake-parts, nixpkgs, nixpkgs-unstable, self, systems }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      ({ flake-parts-lib, lib, ... }:
        let
          inherit (lib) mkOption types;
          inherit (flake-parts-lib) mkTransposedPerSystemModule;

          specialArgsType = types.submodule {
            options = {
              self = mkOption { };
              package = mkOption { type = types.package; };
              extraPackages = mkOption { type = types.listOf types.package; };
            };
          };
        in
        mkTransposedPerSystemModule {
          name = "specialArgs";
          option = mkOption {
            type = types.lazyAttrsOf specialArgsType;
            default = { };
          };
          file = self;
        })
    ];

    systems = import systems;

    perSystem = { system, ... }:
      let
        pkgs = import nixpkgs { inherit system; };

        neovim-unwrapped = (import nixpkgs-unstable { inherit system; }).neovim-unwrapped;

        # this currently does not work, unable to import modules
        neovim-wrapped = pkgs.symlinkJoin {
          name = neovim-unwrapped.name;
          paths = [ neovim-unwrapped ];
          buildInputs = with pkgs; [ makeWrapper ];
          postBuild = ''
            wrapProgram "$out"/bin/nvim --add-flags '-u '${self}'/init.lua'
          '';
        };
      in
      {
        packages.default = neovim-unwrapped; # will be bundled with config
        apps.default = {
          type = "app";
          program = "${neovim-wrapped}/bin/nvim";
        };

        specialArgs.default = {
          inherit self;

          package = neovim-unwrapped;
          extraPackages = with pkgs; [
            clang
            git
            gnumake
            ripgrep
          ];
        };
      };
  };
}
