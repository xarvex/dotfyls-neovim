{
  description = "Personal Neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, nixpkgs, nixpkgs-unstable, self }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    perSystem = { system, ... }:
      let
        pkgs = import nixpkgs { inherit system; };

        neovim = (import nixpkgs-unstable { inherit system; }).neovim;

        # this currently does not work, unable to import modules
        neovim-wrapped = pkgs.symlinkJoin {
          name = neovim.name;
          paths = [ neovim ];
          buildInputs = with pkgs; [ makeWrapper ];
          postBuild = ''
            wrapProgram "$out"/bin/nvim --add-flags '-u '${self}'/init.lua'
          '';
        };
      in
      {
        packages.default = neovim;
        apps.default = {
          type = "app";
          program = "${neovim-wrapped}/bin/nvim";
        };
      };

    flake.specialArgs = { inherit self; };
  };
}
