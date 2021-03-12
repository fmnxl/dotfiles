{ lib, config, pkgs, ... }:
let
  myPkgs= import /Users/freeman/nixpkgs {
    config = {
      android_sdk.accept_license = true;
    };
  };
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      "macos_option_as_alt" = "yes";
    };
    keybindings = {
      "ctrl+shift+enter" = "new_window_with_cwd";
    };
    extraConfig = ''
      evaluate-commands %sh{
          case $(uname) in
              Linux) copy="xclip -i"; paste="xclip -o" ;;
              Darwin)  copy="pbcopy"; paste="pbpaste" ;;
          esac

          printf "map global user -docstring 'paste (after) from clipboard' p '<a-!>%s<ret>'\n" "$paste"
          printf "map global user -docstring 'paste (before) from clipboard' P '!%s<ret>'\n" "$paste"
          printf "map global user -docstring 'yank to primary' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 primary}<ret>'\n" "$copy"
          printf "map global user -docstring 'yank to clipboard' Y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy -selection clipboard"
          printf "map global user -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
      }
    '';
  };
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    reverseSplit = true;
  };
  programs.direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.zsh.enable = true;
  programs.zsh.localVariables = {
    prompt = "%F{254}%~%f\n%F{magenta}❯%f ";
  };
  programs.zsh.sessionVariables = rec {
    INITIAL_QUERY = "";
    RG_PREFIX = "rg --no-column --line-number --no-heading --color=always --smart-case ";
    FZF_DEFAULT_COMMAND = "${RG_PREFIX} '${INITIAL_QUERY}'";
  };
  programs.zsh.initExtra = ''
    fif() {
      if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
      rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
    }
  '';
  programs.zsh.shellAliases = {
    tree = "exa --tree";
    k = "kak";
    g = "gitui";
    ls = "exa";
    f = ''
      fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --preview $'awk -F  ":" \'/1/ {start = $2<5 ? 0 : $2 - 5; end = $2 + 5; print $1 " " $2 " " start ":" end}\' \'{}\' | cat $1' \
        --ansi --phony --query "$INITIAL_QUERY" \
        --height=50% --layout=reverse
    '';
  };

  programs.kakoune = {
    enable = true;
    config = {
      indentWidth = 2;
      numberLines = {
        enable = true;
      };
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "freeman";
  home.homeDirectory = "/Users/freeman";
  home.packages = [
    pkgs.aerc
    pkgs.slack
    pkgsUnstable.gitAndTools.gitui
    pkgs.gitAndTools.git-standup
    pkgs.glow
    kaiosNixEnv.package
    pkgs.yabai
    pkgs.davmail
    pkgs.pass
    # pkgs.taskell
    pkgs.bat
    pkgs.exa
    pkgs.yabai
    pkgs.tmate
    pkgs.fswatch
    pkgs.ripgrep
    pkgs.ngrok
    pkgs.ipfs
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

}
