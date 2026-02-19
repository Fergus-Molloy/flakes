{ pkgs, ... }:
{
  home.file.".config/starship.toml" = {
    source = ./configs/starship.toml;
  };
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history = {
      path = "/home/fergus/.cache/zsh/histfile";
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 5000000;
      share = true;
      size = 1000000;
    };
    sessionVariables = {
      PATH = "/home/fergus/.local/bin:/home/fergus/.cargo/bin:$PATH";
      TIMEFMT = "$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\n'";
      TERM = "xterm-kitty";
      GPG_TTY = "$(tty)";
    };
    initContent = ''
      [[ -f ~/.secrets.zsh ]] && source ~/.secrets.zsh

      fpath=(${pkgs.docker}/share/zsh/site-functions/_docker $fpath)
      fpath=(${pkgs.eza}/share/zsh/site-functions/_eza $fpath)

      autoload -U promptinit; promptinit
      autoload -U compinit && compinit

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      eval "$(${pkgs.just}/bin/just --completions zsh)"
      eval "$(${pkgs.starship}/bin/starship init zsh)"

      tmux start-server 2>&1 > /dev/null
      if [ -z "$TMUX" ]; then
        if tmux has-session -t dev 2>/dev/null; then
          client_count="$(tmux list-clients -t dev 2>/dev/null | wc -l)"

          if [ "$client_count" -eq 0 ]; then
            tmux attach-session -t dev
          else
            tmux new-session
          fi
        else
          tmux new-session -s dev
        fi
      fi

      ${pkgs.fastfetch}/bin/fastfetch
    '';
    shellAliases = {
      # general aliases
      cl = "clear";
      rm = "rm -vr";
      cp = "cp -r";
      sudo = "sudo ";
      mkdir = "mkdir -p";
      c = "cargo";
      cr = "cargo run";
      ":q" = "exit";
      # better tools
      v = ''eval "$EDITOR"'';
      vf = ''eval "$EDITOR" $(fzf)'';
      grep = "rg";
      top = "btop";
      cat = "bat";
      find = "fd";
      k = "kubectl";
      #better ls
      ls = "eza -lh -s=name --git --group-directories-first --no-permissions --icons --no-user";
      lsa = "eza -lha -s=name --git --group-directories-first --no-permissions --icons --no-user";
      lsp = "eza -lha -s=name --git --icons --group-directories-first";
      lsg = "eza -lh -s=name --git --group-directories-first --git-ignore --no-permissions --icons --no-user";
      # git aliases
      gaa = "git add --all";
      gau = "git add -u";
      gst = "git status";
      gc = "git commit";
      gca = "git commit --amend --no-edit";
      gC = "git commit -m";
      gp = "git pull";
      gP = "git push";
      gPf = "git push --force-with-lease";
      gs = "git switch";
      gS = "git switch -c";
      gr = "git rebase";
      gmf = "git merge --ff-only";
      gprc = "gh pr create";
      gd = "git diff -w";
      gD = "git diff --staged -w";
      gl = "git log";
    };
  };
}
