{config, ... }:
{
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        autocd = true;
        history = {
            path = "~/.cache/zsh/histfile";
            save = 1000;
            share = true;
            size = 1000;
        };
        initExtra = ''
            export PATH="/home/fergus/bin:$PATH"
            export PATH="/home/fergus/.cargo/bin:$PATH"'';
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