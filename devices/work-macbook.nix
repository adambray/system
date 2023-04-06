{ darwin, flake-utils, home-manager }:

darwin.lib.darwinSystem {
  system = flake-utils.lib.system.aarch64-darwin;
  modules = [{
    imports = [
      ../modules/nix-darwin
      home-manager.darwinModules.home-manager
      {
        home-manager.useUserPackages = true;
        users.users.adam.home = "/Users/adam";
      }
    ];
    homebrew.casks = [
      "amazon-workspaces"
      "tandem"
      "dbvisualizer"
    ];
    home-manager.users.adam = { pkgs, ... }: {
      imports = [ (import ../modules/home-manager) ];
      programs.zsh = {
        profileExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
      };
    };
  }];
}
