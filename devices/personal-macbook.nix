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
    home-manager.users.adam = import ../modules/home-manager;
  }];
}
