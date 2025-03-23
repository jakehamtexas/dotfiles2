{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jakeh";
  home.homeDirectory = "/home/jakeh";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

programs.neovim = {
  enable = true;
  viAlias = true;
  vimAlias = true;
  defaultEditor = true;
};

programs.kitty = {
  enable = true;

  shellIntegration.enableBashIntegration = true;

  themeFile = "Catppuccin-Macchiato";
};

programs.git = {
  enable = true;

  userEmail = "jakehamtexas@gmail.com";
  userName = "Jake Hamilton";

  ignores = [
    "*~"
    "*.swp"
  ];
};

programs.oh-my-posh = {
  enable = true;

  # Managed in programs.bash.initExtra
  enableBashIntegration = false;
};

home.sessionPath = [
  "${config.home.homeDirectory}/dotfiles/shell/path"
];

programs.bash = {
  enable = true;

  initExtra = ''
  eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init bash --config ${./shell/oh-my-posh/conf.toml})"
  '';
};
}
