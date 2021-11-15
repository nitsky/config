{ ... }: {
  programs.lf = {
    enable = true;
    commands = {
      extract = ''''${{
        # https://xkcd.com/1168/
        set -f
        case $f in
          *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar -xjvf $f;;
          *.tar.gz|*.tgz) tar -xzvf $f;;
          *.tar.xz|*.txz) tar -xJvf $f;;
          *.zip) unzip $f;;
          *.rar) unrar x $f;;
        esac
      }}'';
      jump = ''''${{
        f=$(fd | fzf)
        if [ -d $f ]; then
          cmd="cd"
        else
          cmd="select"
        fi
        lf -remote "send $id $cmd $f"
      }}'';
      rmrf = ''''${{
        set -f
        echo $fx
        printf "Are you sure you want to rm -rf? [Y/n] "
        read answer
        [ $answer = "Y" ] && rm -rf $fx
      }}'';
      tar = ''''${{
        set -f
        mkdir $1
        cp -r $fx $1
        tar czf $1.tar.gz $1
        rm -rf $1
      }}'';
      trash = ''''${{
        set -f
        mv $fx ~/.trash/
        echo "files moved to trash"
      }}'';
    };
    keybindings = {
      "<c-f>" = "search";
      "<c-t>" = "jump";
      "<esc>" = ":unselect; clear";
      "<space>" = "toggle";
      "D" = "trash";
      "H" = "cd ~/";
      "J" = "bottom";
      "K" = "top";
      "R" = "rmrf";
      "i" = "set hidden!";
      "x" = "cut";
    };
    settings = {
      hidden = true;
      icons = true;
      preview = false;
      period = 1;
      ratios = "1";
    };
  };
}
