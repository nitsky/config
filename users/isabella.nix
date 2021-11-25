{ inputs, pkgs, ... }:
import ../home {
  accounts = {
    personal = {
      name = "Isabella Tromba";
      email = "isabella.tromba@gmail.com";
    };
    work = {
      name = "Isabella Tromba";
      email = "isabella@tangram.dev";
    };
  };
  git = {
    name = "Isabella Tromba";
    email = "isabella.tromba@gmail.com";
  };
  sshKeyKeygrip = "351FCEECAAB25A6FD9D5B46DBD28E6DA4B110CAB";
  username = "isabella";
} {
  inherit pkgs;
}
