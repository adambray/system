{ fetchFromGitHub
, tmuxPlugins
}:

tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-resurrect";
  version = "";
  src = fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-resurrect";
    rev = "v4.0.0";
    sha256 = "44Ok7TbNfssMoBmOAqLLOj7oYRG3AQWrCuLzP8tA8Kg=";
  };
}
