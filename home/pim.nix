user:
{ pkgs, ... }: {
  accounts = {
    email = {
      maildirBasePath = "mail";
      accounts = with user.accounts.personal; {
        personal = {
          primary = true;
          realName = name;
          address = email;
          userName = email;
          passwordCommand = "gopass migadu.com/${email}";
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
        work = with user.accounts.work; {
          realName = name;
          address = email;
          userName = email;
        };
      };
    };
  };
  programs.mbsync.enable = true;
  services.imapnotify.enable = true;
  services.mbsync.enable = true;
}
