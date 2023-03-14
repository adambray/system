{ home-manager }:

[
  (import ../darwin)
  home-manager.darwinModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    users.users.adam.home = "/Users/adam";
  }
]
