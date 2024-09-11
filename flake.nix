{
  description = "Personal Neovim";

  inputs = {
    devenv.url = "github:cachix/devenv";

    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };

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
      imports = [ inputs.devenv.flakeModule ];

      systems = import inputs.systems;

      perSystem =
        { pkgs, ... }:
        let
          inherit (nixpkgs) lib;

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

          devenv.shells = rec {
            default = neovim;

            neovim = {
              devenv.root =
                let
                  devenvRoot = builtins.readFile inputs.devenv-root.outPath;
                in
                # If not overriden (/dev/null), --impure is necessary.
                lib.mkIf (devenvRoot != "") devenvRoot;

              name = "Neovim";

              packages = [
                pkgs.neovim
                pkgs.nodejs_22
              ];

              enterShell = ''
                NVIM_APPNAME="dotfyls/devshell/nvim/$(sha1sum - <<<"''${PWD}" | head -c40)''${PWD//[^a-zA-Z0-9]/-}"
                export NVIM_APPNAME
                mkdir -p "''${XDG_CONFIG_HOME:-''${HOME}/.config}/dotfyls/devshell/nvim"
                ln -fsT "''${PWD}" "''${XDG_CONFIG_HOME:-''${HOME}/.config}/''${NVIM_APPNAME}"
              '';

              languages = {
                lua = {
                  enable = true;
                  package = pkgs.luajit;
                };
                nix.enable = true;
              };

              pre-commit.hooks = {
                deadnix.enable = true;
                flake-checker.enable = true;
                nixfmt-rfc-style.enable = true;
                statix.enable = true;
                stylua.enable = true;
              };
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
                gcc
                git
                gnumake
                nodejs_22
              ];
            };

            xdg.configFile = {
              "nvim/init.lua".source = ./init.lua;
              "nvim/lua" = {
                recursive = true;
                source = ./lua;
              };
            };

            systemd.user.tmpfiles.rules = [
              "C+ ${config.xdg.configHome}/nvim/lazy-lock.json 0644 - - - ${./lazy-lock.json}"
            ];
          };
      };
    };
}
