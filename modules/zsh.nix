{ config, user, pkgs, ... }:
{
  home.file.".docker-completion.zsh".source = "${pkgs.docker}/share/zsh/site-functions/_docker";
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history = {
      path = "/home/${user}/.cache/zsh/histfile";
      save = 1000;
      share = true;
      size = 1000;
    };
    initExtra = ''
      export PATH="/home/${user}/.local/bin:$PATH"
      export PATH="/home/${user}/.cargo/bin:$PATH"
      export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\n'
      fpath=(~/.docker-completion.zsh $fpath)
      autoload -U compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      export TERM=xterm-kitty
      export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
      [[ ! -r /home/fergus/.opam/opam-init/init.zsh ]] || source /home/fergus/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
      export test=1
      neofetch
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
      v = "nvim";
      vim = "nvim";
      grep = "rg";
      top = "btop";
      cat = "bat";
      find = "fd";
      #better ls
      ls = "eza -lh -s=name --git --group-directories-first --no-permissions --no-user --icons";
      lsa = "eza -lha -s=name --git --group-directories-first --no-permissions --no-user --icons";
      lsp = "eza -lha -s=name --git --group-directories-first --icons";
      lsg = "eza -lh -s=name --git --group-directories-first --git-ignore --no-permissions --no-user --icons";
      # git aliases
      gaa = "git add --all";
      gau = "git add -u";
      gst = "git status";
      gc = "git commit";
      gC = "git commit -m";
      gp = "git pull";
      gP = "git push";
      gs = "git switch";
      gS = "git switch -c";
      gr = "git rebase";
    };
  };
}
