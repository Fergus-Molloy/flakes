{config, user, ... }:
{
    home.file.".docker-completion.zsh".source = ./.docker-completion.zsh;
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
            export PATH="/home/${user}/bin:$PATH"
            export PATH="/home/${user}/.cargo/bin:$PATH"
            fpath=(~/.docker-completion.zsh $fpath)
            autoload -U compinit && compinit
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
            '';
        shellAliases = {
            # general aliases
            cl="clear";
            rm="rm -vr";
            cp="cp -r";
            sudo="sudo ";
            mkdir="mkdir -p";
            c = "cargo";
            cr = "cargo run";
            # better tools
            v = "nvim";
            vim = "nvim";
            grep = "rg";
            top = "bpytop";
            cat ="bat";
            find = "fd";
            #better ls
            ls="exa -lh -s=name --git --group-directories-first --no-permissions --no-user --icons";
            lsa="exa -lha -s=name --git --group-directories-first --no-permissions --no-user --icons";
            lsp="exa -lha -s=name --git --group-directories-first --icons";
            lsg="exa -lh -s=name --git --group-directories-first --git-ignore --no-permissions --no-user --icons";
            # git aliases
            gaa="git add --all";
            gc="git commit";
            gcm="git commit -m";
            gp="git pull";
            gpu="git push";
            gs="git switch";
            gsc="git switch -c";
        };
    };
}
