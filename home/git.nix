{ config, pkgs, lib, ... }:
  let
    gitUser = "Chad W Pry";
    gitEmail = "chad.pry@gmail.com";
    # isDarwin = system == "aarch64-darwin" || system == "x86_64-darwin";
  in {
    programs.git = {
      enable = true;
      # userName = "Chad W Pry";
      # userEmail = "chad.pry@gmail.com";
      userName = "${gitUser}";
      userEmail = "${gitEmail}";
      aliases = {
        st = "status";
        ci = "commit";
        br = "branch";
        co = "checkout";
        df = "diff";
        lg = "log -p";
      };
      extraConfig = {
        color = {
          branch = {
            current = "yellow reverse";
            local = "yellow";
            remote = "green";
          };
          diff = {
            frag = "magenta bold";
            meta = "yellow bold";
            new = "green bold";
            old = "red bold";
            whitespace = "red reverse";
          };
          status = {
            added = "yellow";
            changed = "green";
            untracked = "cyan";
          };
          ui = "auto";
        };
        credential = {
          helper = "store";
        };
        core = {
          autocrlf = false;
          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
          editor = "nvim";
        };
        filter= {
          lfs = {
            required = true;
            clean = "git-lfs clean -- %f";
            smudge = "git-lfs smudge -- %f";
            process = "git-lfs filter-process";
          };
        };
        http = {
          sslVerify = false;
        };
        init = {
          defaultBranch = "main";
        };
        lfs.enable = true;
        mergetool = {
          diffmerge = {
            cmd = "diffmerge --merge --result=$MERGED $LOCAL $BASE $REMOTE";
            trustExitCode = false;
          };
        };
        pager = {
          branch = false;
        };
      };
    };
  }
