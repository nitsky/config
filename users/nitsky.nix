{ inputs, pkgs, ... }:
import ../home {
  accounts = {
    personal = {
      name = "David Yamnitsky";
      email = "david@yamnitsky.com";
    };
    work = {
      name = "David Yamnitsky";
      email = "david@tangram.dev";
    };
  };
  git = {
    name = "David Yamnitsky";
    email = "david@yamnitsky.com";
  };
  sshKeyKeygrip = "CC89063AD3C9C6D31240CC3E5C709ABF4F7284C0";
  username = "nitsky";
} {
  inherit pkgs;
}
