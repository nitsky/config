{ ... }: {
  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
      paging = "always";
      tabs = "2";
      theme = "base16";
    };
  };
}
