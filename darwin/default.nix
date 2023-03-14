{
  homebrew.enable = true;
  homebrew.casks = additionalCasks ++ [
    "1password-cli"
    "1password"
    "beekeeper-studio"
    "bettertouchtool"
    "discord"
    "docker"
    "firefox"
    "google-chrome"
    "google-cloud-sdk"
    "iterm2"
    "obsidian"
    "raycast"
    "rectangle"
    "slack"
    "zoom"
  ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
    "repl-flake"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  system.defaults.dock.autohide = true;

  system.stateVersion = 4;
}
