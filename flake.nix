{
  description = "Personal Neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, nixpkgs, nixpkgs-unstable, self }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
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

    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

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
            nil
            nixpkgs-fmt
            ripgrep
          ];
        };
      };
  };
}
