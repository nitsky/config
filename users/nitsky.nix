{ pkgs, ... }:
import ../home {
  accounts = {
    personal = {
      name = "David Yamnitsky";
      email = "david@yamnitsky.com";
    };
    work = {
      name = "David Yamnitsky";
      email = "david@tangram.xyz";
    };
  };
  inherit pkgs;
}
