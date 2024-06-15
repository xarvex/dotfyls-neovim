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
          specialArgsType = lib.types.submodule {
            options = {
              self = lib.mkOption { };
              package = lib.mkOption { type = lib.types.package; };
              extraPackages = lib.mkOption { type = lib.types.listOf lib.types.package; };
            };
          };
        in
        flake-parts-lib.mkTransposedPerSystemModule {
          name = "specialArgs";
          option = lib.mkOption {
            type = lib.types.lazyAttrsOf specialArgsType;
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
