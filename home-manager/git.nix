{ pkgs, ... }:

{
    programs.git = {
        package = pkgs.gitAndTools.gitFull;
        enable = true;
        userName = "brunoc";
        userEmail = "bruno@brunoc.org";
        aliases = {
            co = "checkout";
            ci = "commit";
            cia = "commit --amend";
            s = "status";
            st = "status";
            b = "branch";
            p = "pull --rebase";
            pu = "push";
            };
        ignores = [ "*~" "*.swp" ];
    extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        protocol.keybase.allow = "always";
        pull.rebase = "false";
        };
    };
}