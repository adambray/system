{ pkgs, ... }:

{
  imports = [
    (import ./one-password.nix)
    (import ./vscode)
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ../../packages/overlay.nix) ];
  };

  home = {
    packages = with pkgs; [
      codespell
      elixir
      exa
      gnupg
      helix
      jdk
      kubectl
      k9s
      navi
      nixpkgs-fmt
      nodePackages.prettier
      nodejs-18_x
      ripgrep
      rustup
      terraform
      tree
      vscode-update-exts
      watch
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "23.05";
  };

  programs.direnv = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Adam Bray";
    userEmail = "adam@mechanical-orchard.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.ssh = {
    enable = true;
    controlPath = "none";
  };

  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmux-resurrect
      tmuxPlugins.continuum
    ];

    extraConfig = ''
        # Some tweaks to the status line
        set -g status-right "%b %d %Y | %l:%M %p"
        set -g status-justify centre
        set -g status-left-length 60

        # Highlight active window
        set -g window-status-current-style fg=red,bg=black,bold

        set-option -g renumber-windows on

        # hjkl pane navigation
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Enable RGB colour if running in xterm(1)
        # set-option -sa terminal-overrides ",xterm*:Tc"

        # work with upterm
        set-option -ga update-environment " UPTERM_ADMIN_SOCKET"

        # useful when pairing on different sized screens
        set-window-option -g window-size smallest

        # Change the default $TERM to xterm-256color
        # set -g default-terminal "xterm-256color"

        # No bells at all
        set -g bell-action none

        # Use focus events
        set -g focus-events on

        # Keep current path when creating new panes/windows
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        # Use vim keybindings in copy mode
        setw -g mode-keys vi

        # Setup 'v' to begin selection as in Vim
        bind-key -T copy-mode-vi v send -X begin-selection

        bind-key -T copy-mode-vi y send -X copy-selection
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

        # Update default binding of `Enter` to also use copy-pipe
        unbind -T copy-mode-vi Enter
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"

        # Turn the mouse on
        set -g mouse on
        bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe "pbcopy"

        # Set window notifications
        setw -g monitor-activity off
        set -g visual-activity off

        # reduce esc time for vim
        set -g escape-time 10

        # Automatically set window title
        # setw -g automatic-rename
        set -g pane-border-status top
        setw -g pane-border-format ' #P #T : #{pane_current_path} '

        # Display pane numbers longer
        set -g display-panes-time 4000

        # Display status bar messages longer
        set-option -g display-time 2000

        # Start pane and window numbering at 1 instead of 0
        setw -g base-index 1
        setw -g pane-base-index 1

        # pane border colors
        set -g pane-border-style fg='#31AFD4'
        set -g pane-active-border-style fg='#FF007F'

        # List of plugins
        # set -g @plugin 'tmux-plugins/tpm'
        # set -g @plugin 'christoomey/vim-tmux-navigator'
        # TODO plugin doesn't currently detect lvim, so doing it manually here:
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l


      #    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      #    run '~/.tmux/plugins/tpm/tpm'
    '';

  };

  programs.zsh = {
    enable = true;
    localVariables = {
      RPROMPT = null;
    };
    shellAliases =
      let
        update-command =
          if pkgs.stdenv.isLinux
          then "sudo nixos-rebuild"
          else "darwin-rebuild";
      in
      {
        lvim = "~/.local/bin/lvim";
        update = ''
          cd ~/.system \
            && ${update-command} switch --flake . \
            && exec $SHELL
        '';
        update-code-extensions = ''
          vscode-update-exts \
            > ~/.system/modules/home-manager/vscode/extensions.nix
        '';
      };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "miloshadzic";
    };
  };
}
