{ darwin, flake-utils, home-manager }:

let
  darwinModules = darwinOptions: [
    (import ../darwin darwinOptions)
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.luke = import ../darwin/home;
      users.users.luke.home = "/Users/adam";
    }
  ];
in
{
  darwinConfigurations = {
    "Adams-Personal-MBP" = darwin.lib.darwinSystem {
      system = flake-utils.lib.system.x86_64-darwin;
      modules = darwinModules { };
    };
    "Adams-Work-MBP" = darwin.lib.darwinSystem {
      system = flake-utils.lib.system.aarch64-darwin;
      modules = darwinModules { additionalCasks = [ "tandem" ]; };
    };
  };
}
