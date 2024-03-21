{ inputs, ... }:

{
  users.users.adambray.home = "/Users/adambray";

  home-manager.users.adambray = ../home-manager;
  home-manager.useUserPackages = true;

  homebrew.enable = true;
  homebrew.casks = [
    "1password-cli"
    "1password"
    "beekeeper-studio"
    "bettertouchtool"
    "discord"
    "disk-inventory-x"
    "docker"
    "firefox"
    "finicky"
    "flycut"
    "gitkraken"
    "google-chrome"
    "google-cloud-sdk"
    "google-drive"
    "iterm2"
    "keepingyouawake"
    "keycastr"
    "meld"
    "obsidian"
    "raycast"
    "rectangle"
    "slack"
    "warp"
    "zoom"
  ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
    "repl-flake"
  ];

  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system.defaults.dock.autohide = true;

  system.stateVersion = 4;
}
