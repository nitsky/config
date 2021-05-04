{ pkgs, ... }:
import ../home {
  username = "isabella";
  git = {
    name = "Isabella Tromba";
    email = "isabella.tromba@gmail.com";
  };
  accounts = {
    personal = {
      name = "Isabella Tromba";
      email = "isabella.tromba@gmail.com";
    };
    work = {
      name = "Isabella Tromba";
      email = "isabella@tangram.xyz";
    };
  };
} {
  inherit pkgs;
}
