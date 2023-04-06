{ darwin, flake-utils, home-manager, nixpkgs }:

{
  darwinConfigurations = {
    "Adams-Personal-MBP" = import ./personal-macbook.nix { inherit darwin flake-utils home-manager; };
    "Adams-Work-MBP" = import ./work-macbook.nix { inherit darwin flake-utils home-manager; };
  };
}
