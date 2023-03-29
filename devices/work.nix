{ darwin, flake-utils, home-manager }:

darwin.lib.darwinSystem {
  system = flake-utils.lib.system.aarch64-darwin;
  modules = [{
    imports = import ./common.nix { inherit home-manager; };
    homebrew.casks = [
      "amazon-workspaces"
      "tandem"
      "dbvisualizer"
    ];
    home-manager.users.adam = { pkgs, ... }: {
      imports = [ (import ../darwin/home) ];
      programs.zsh = {
        profileExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
      };
    };
  }];
}