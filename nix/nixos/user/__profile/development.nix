{ ... }@_haumeaArgs:
{ config, lib, pkgs, ... }@_hmModuleArgs: {
  home.packages = [
    pkgs.devenv
  ];

  home.sessionVariables = {
    AIDER_DARK_MODE = "true";
    OLLAMA_API_BASE = "http://lima:11434";
  };

  programs.bat.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config.hide_env_diff = true;
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
  programs.git.difftastic.enable = true;
  programs.git.extraConfig = {
    commit.gpgsign = true;
    gpg.format = "ssh";
    gpg.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    init.defaultBranch = "main";
    pull.rebase = true;
  };
  programs.git.userEmail = lib.mkDefault "46090392+putquo@users.noreply.github.com";
  programs.git.userName = "Preston van Tonder";

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
    email = lib.mkDefault "46090392+putquo@users.noreply.github.com";
    name = "Preston van Tonder";
  };
  programs.jujutsu.settings.signing = {
    backend = "ssh";
    backends.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    behavior = "own";
  };
  programs.jujutsu.settings.ui.pager = ":builtin";

  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host *
      IdentityAgent ~/.1password/agent.sock 
  '';

  programs.starship.enable = true;
  programs.starship.settings = {
    aws = {
      symbol = "aws ";
    };

    azure = {
      symbol = "az ";
    };

    buf = {
      symbol = "buf ";
    };

    bun = {
      symbol = "bun ";
    };

    c = {
      symbol = "C ";
    };

    cpp = {
      symbol = "C++ ";
    };

    cobol = {
      symbol = "cobol ";
    };

    conda = {
      symbol = "conda ";
    };

    container = {
      symbol = "container ";
    };

    crystal = {
      symbol = "cr ";
    };

    cmake = {
      symbol = "cmake ";
    };

    daml = {
      symbol = "daml ";
    };

    dart = {
      symbol = "dart ";
    };

    deno = {
      symbol = "deno ";
    };

    dotnet = {
      symbol = ".NET ";
    };

    directory = {
      read_only = " ro";
    };

    docker_context = {
      symbol = "docker ";
    };

    elixir = {
      symbol = "exs ";
    };

    elm = {
      symbol = "elm ";
    };

    fennel = {
      symbol = "fnl ";
    };

    fossil_branch = {
      symbol = "fossil ";
    };

    gcloud = {
      symbol = "gcp ";
    };

    git_branch = {
      symbol = "git ";
    };

    gleam = {
      symbol = "gleam ";
    };

    golang = {
      symbol = "go ";
    };

    gradle = {
      symbol = "gradle ";
    };

    guix_shell = {
      symbol = "guix ";
    };

    haskell = {
      symbol = "haskell ";
    };

    helm = {
      symbol = "helm ";
    };

    hg_branch = {
      symbol = "hg ";
    };

    java = {
      symbol = "java ";
    };

    julia = {
      symbol = "jl ";
    };

    kotlin = {
      symbol = "kt ";
    };

    lua = {
      symbol = "lua ";
    };

    nodejs = {
      symbol = "nodejs ";
    };

    memory_usage = {
      symbol = "memory ";
    };

    meson = {
      symbol = "meson ";
    };

    nats = {
      symbol = "nats ";
    };

    nim = {
      symbol = "nim ";
    };

    nix_shell = {
      symbol = "nix ";
    };

    ocaml = {
      symbol = "ml ";
    };

    opa = {
      symbol = "opa ";
    };

    os = {
      symbols = {
        AIX = "aix ";
        Alpaquita = "alq ";
        AlmaLinux = "alma ";
        Alpine = "alp ";
        Amazon = "amz ";
        Android = "andr ";
        Arch = "rch ";
        Artix = "atx ";
        Bluefin = "blfn ";
        CachyOS = "cach ";
        CentOS = "cent ";
        Debian = "deb ";
        DragonFly = "dfbsd ";
        Emscripten = "emsc ";
        EndeavourOS = "ndev ";
        Fedora = "fed ";
        FreeBSD = "fbsd ";
        Garuda = "garu ";
        Gentoo = "gent ";
        HardenedBSD = "hbsd ";
        Illumos = "lum ";
        Kali = "kali ";
        Linux = "lnx ";
        Mabox = "mbox ";
        Macos = "mac ";
        Manjaro = "mjo ";
        Mariner = "mrn ";
        MidnightBSD = "mid ";
        Mint = "mint ";
        NetBSD = "nbsd ";
        NixOS = "nix ";
        Nobara = "nbra ";
        OpenBSD = "obsd ";
        OpenCloudOS = "ocos ";
        openEuler = "oeul ";
        openSUSE = "osuse ";
        OracleLinux = "orac ";
        Pop = "pop ";
        Raspbian = "rasp ";
        Redhat = "rhl ";
        RedHatEnterprise = "rhel ";
        RockyLinux = "rky ";
        Redox = "redox ";
        Solus = "sol ";
        SUSE = "suse ";
        Ubuntu = "ubnt ";
        Ultramarine = "ultm ";
        Unknown = "unk ";
        Uos = "uos ";
        Void = "void ";
        Windows = "win ";
      };
    };

    package = {
      symbol = "pkg ";
    };

    perl = {
      symbol = "pl ";
    };

    php = {
      symbol = "php ";
    };

    pijul_channel = {
      symbol = "pijul ";
    };

    pixi = {
      symbol = "pixi ";
    };

    pulumi = {
      symbol = "pulumi ";
    };

    purescript = {
      symbol = "purs ";
    };

    python = {
      symbol = "py ";
    };

    quarto = {
      symbol = "quarto ";
    };

    raku = {
      symbol = "raku ";
    };

    rlang = {
      symbol = "r ";
    };

    ruby = {
      symbol = "rb ";
    };

    rust = {
      symbol = "rs ";
    };

    scala = {
      symbol = "scala ";
    };

    spack = {
      symbol = "spack ";
    };

    solidity = {
      symbol = "solidity ";
    };

    status = {
      symbol = "[x](bold red) ";
    };

    sudo = {
      symbol = "sudo ";
    };

    swift = {
      symbol = "swift ";
    };

    typst = {
      symbol = "typst ";
    };

    terraform = {
      symbol = "terraform ";
    };

    zig = {
      symbol = "zig ";
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.options = [ "--cmd" "cd" ];

  xdg.userDirs.extraConfig.XDG_PROJECTS_DIR = "$HOME/projects";
}
