{
  description = "Personal Neovim";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      flake-parts,
      nixpkgs,
      self,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs { inherit system; };

          # This currently does not work, unable to import modules.
          neovim-wrapped = pkgs.symlinkJoin {
            inherit (pkgs.neovim-unwrapped) name;

            paths = [ pkgs.neovim-unwrapped ];
            nativeBuildInputs = with pkgs; [ makeWrapper ];
            postBuild = ''
              wrapProgram "''${out}"/bin/nvim --add-flags '-u '${self}'/init.lua'
            '';
          };
        in
        {
          packages = rec {
            default = neovim;

            # Will be bundled with config.
            neovim = pkgs.neovim-unwrapped;
          };
          apps = rec {
            default = neovim;

            neovim = {
              type = "app";
              program = "${neovim-wrapped}/bin/nvim";
            };
          };
        };

      flake.homeManagerModules = rec {
        default = neovim;

        neovim =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          lib.mkIf config.programs.neovim.enable {
            programs.neovim = {
              withNodeJs = lib.mkDefault false;
              withPython3 = lib.mkDefault false;
              withRuby = lib.mkDefault false;
              extraPackages = with pkgs; [
                clang
                git
                gnumake
                ripgrep
              ];
            };

            xdg.configFile.nvim = {
              recursive = true;
              source = ./.;
            };
          };
      };
    };
}
