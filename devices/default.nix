{ darwin, flake-utils, home-manager }:

{
  darwinConfigurations = {
    "Adams-Personal-MBP" = import ./personal.nix { inherit darwin flake-utils home-manager; };
    "Adams-Work-MBP" = import ./work.nix { inherit darwin flake-utils home-manager; };
  };
}
