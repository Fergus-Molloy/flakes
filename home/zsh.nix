{ pkgs, ... }:
let
  # pure zsh prompt
  pure = pkgs.stdenv.mkDerivation {
    name = "pure";
    version = "1.23.0";
    src = pkgs.fetchFromGitHub {
      owner = "sindresorhus";
      repo = "pure";
      rev = "refs/tags/v1.23.0";
      hash = "sha256-BmQO4xqd/3QnpLUitD2obVxL0UulpboT8jGNEh4ri8k=";
    };
    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };

in
{
  # comp warns that /nix/store is insecure so link to somewhere secure
  home.file.".zsh/pure".source = pure;
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
      save = 5000;
      share = true;
      size = 1000;
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
      fpath+=($HOME/.zsh/pure)

      autoload -U promptinit; promptinit
      autoload -U compinit && compinit

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      [[ ! -r /home/fergus/.opam/opam-init/init.zsh ]] || source /home/fergus/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      ${pkgs.fastfetch}/bin/fastfetch
      prompt pure

      ${pkgs.tmux}/bin/tmux start-server
      if [ -z "''$TMUX" ]; then
        ${pkgs.tmux}/bin/tmux has-session -t dev 2> /dev/null && tmux new-session || tmux new-session -s dev
      fi
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
    };
  };
}
