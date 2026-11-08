{ ... }@haumeaArgs:
{ config, lib, pkgs, ... }@homeManagerModuleArgs: {
  home.packages = [
    pkgs.devenv
    pkgs.oauth2c
    pkgs.just
    pkgs.jwt-cli
    pkgs.step-cli
  ];

  home.sessionVariables = {
    AIDER_DARK_MODE = "true";
    OLLAMA_API_BASE = "http://lima:11434";
  };

  programs.bat.enable = true;

  programs.claude-code.enable = true;

  programs.difftastic.enable = true;
  programs.difftastic.git.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config.hide_env_diff = true;
  programs.direnv.config.warn_timeout = "0";
  programs.direnv.config.whitelist.prefix =
    [ config.xdg.configHome "${config.home.homeDirectory}/projects" ];

  programs.eza.enable = true;

  programs.fish.shellAbbrs.ga = "git add";
  programs.fish.shellAbbrs.gaa = "git add -A";
  programs.fish.shellAbbrs.gb = "git branch";
  programs.fish.shellAbbrs.gbm = "git branch -m";
  programs.fish.shellAbbrs.gco = "git checkout";
  programs.fish.shellAbbrs.gcb = "git checkout -b";
  programs.fish.shellAbbrs.gc = "git commit";
  programs.fish.shellAbbrs.gcm = "git commit -m";
  programs.fish.shellAbbrs.gca = "git commit --amend";
  programs.fish.shellAbbrs.gcf = "git commit --amend --no-edit";
  programs.fish.shellAbbrs.gp = "git push";
  programs.fish.shellAbbrs.gpf = "git push --force-with-lease --force-if-includes";
  programs.fish.shellAbbrs.gpl = "git pull";
  programs.fish.shellAbbrs.grs = "git restore";
  programs.fish.shellAbbrs.grst = "git restore --staged";
  programs.fish.shellAbbrs.gst = "git status";
  programs.fish.shellAliases.g = "git";
  programs.fish.shellAliases.openvpn = "openvpn3";

  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;

  programs.gh.enable = true;

  programs.git.enable = true;
  programs.git.signing.format = "ssh";
  programs.git.signing.key = lib.mkDefault "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4z+GCnpEmPq2uRl1Ol8a83Xjmeiqk1q8XV3cZh7pWZ";
  programs.git.signing.signByDefault = true;
  programs.git.signing.signer = "${pkgs._1password-gui}/bin/op-ssh-sign";
  programs.git.settings = {
    init.defaultBranch = "main";
    pull.rebase = true;
    user.email = lib.mkDefault "46090392+putquo@users.noreply.github.com";
    user.name = "Preston van Tonder";
  };

  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
  programs.helix.languages.language = [
    {
      name = "nix";
      auto-format = true;
      formatter.command = "nixpkgs-fmt";
    }
  ];
  programs.helix.settings = {
    editor = {
      color-modes = true;
      completion-trigger-len = 1;
      cursorline = true;
      line-number = "relative";
      true-color = true;
      undercurl = true;
    };
    editor.cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
    editor.lsp = {
      display-inlay-hints = true;
      display-messages = true;
    };
    keys.normal = { X = "extend_line_above"; };
    keys.select = { X = "extend_line_above"; };
    theme = "dracula";
  };
  programs.helix.themes = { empty = { }; };

  programs.jujutsu.enable = true;
  programs.jujutsu.settings.user = {
    inherit (config.programs.git.settings.user) email name;
  };
  programs.jujutsu.settings.signing = {
    backend = "ssh";
    backends.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    behavior = "own";
    key = config.programs.git.signing.key;
  };
  programs.jujutsu.settings.ui.pager = ":builtin";

  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;
  programs.ssh.settings."*" = {
    forwardAgent = false;
    addKeysToAgent = "no";
    compression = false;
    serverAliveInterval = 0;
    serverAliveCountMax = 3;
    hashKnownHosts = false;
    userKnownHostsFile = "~/.ssh/known_hosts";
    controlMaster = "no";
    controlPath = "~/.ssh/master-%r@%n:%p";
    controlPersist = "no";
    identityAgent = "~/.1password/agent.sock";
  };

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.presets = [ "plain-text-symbols" ];

  programs.zoxide.enable = true;
  programs.zoxide.options = [ "--cmd" "cd" ];

  xdg.userDirs.extraConfig.PROJECTS = "$HOME/projects";
}
