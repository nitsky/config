{ inputs, pkgs, ... }:
import ../home {
  username = "nitsky";
  git = {
    name = "David Yamnitsky";
    email = "david@yamnitsky.com";
  };
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
} {
  inherit pkgs;
}
