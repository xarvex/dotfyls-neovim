{
  description = "Personal Neovim";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    systems.url = "github:nix-systems/default";
  };

  outputs = { flake-parts, nixpkgs, self, systems, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = import systems;

    perSystem = { system, ... }:
      let
        pkgs = import nixpkgs { inherit system; };

        # this currently does not work, unable to import modules
        neovim-wrapped = pkgs.symlinkJoin {
          name = pkgs.neovim-unwrapped.name;
          paths = [ pkgs.neovim-unwrapped ];
          buildInputs = with pkgs; [ makeWrapper ];
          postBuild = ''
            wrapProgram "$out"/bin/nvim --add-flags '-u '${self}'/init.lua'
          '';
        };
      in
      {
        packages = rec {
          default = neovim;

          neovim = pkgs.neovim-unwrapped; # will be bundled with config
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

      neovim = ({ config, lib, pkgs, ... }: lib.mkIf config.programs.neovim.enable {
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
      });
    };
  };
}
