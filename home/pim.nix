{ pkgs, ... }: {
  accounts = {
    email = {
      maildirBasePath = "mail";
      accounts = {
        personal = {
          primary = true;
          realName = "David Yamnitsky";
          address = "david@yamnitsky.com";
          userName = "david@yamnitsky.com";
          passwordCommand = "gopass migadu.com/david@yamnitsky.com";
          imap = {
            host = "imap.migadu.com";
            port = 993;
          };
          smtp = {
            host = "smtp.migadu.com";
            port = 465;
          };
          imapnotify = {
            enable = true;
            onNotify = "\${pkgs.isync}/bin/mbsync test-%s";
            onNotifyPost = "\${pkgs.notmuch}/bin/notmuch new && \${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
          };
          msmtp = {
            enable = true;
          };
          notmuch = {
            enable = true;
          };
        };
        work = {
          realName = "David Yamnitsky";
          address = "david@tangram.xyz";
          userName = "david@tangram.xyz";
        };
      };
    };
  };
  programs.mbsync.enable = true;
  services.imapnotify.enable = true;
  services.mbsync.enable = true;
}
