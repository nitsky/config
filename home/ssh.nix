{ ... }: {
  programs.ssh = {
    enable = true;
    controlMaster = "yes";
    forwardAgent = true;
    matchBlocks = {
      babyshark = {
        host = "babyshark";
        hostname = "100.100.213.21";
      };
      ezzy = {
        host = "ezzy";
        hostname = "100.76.197.41";
      };
      mba = {
        host = "mba";
        hostname = "100.89.221.9";
      };
      snowflake = {
        host = "snowflake";
        hostname = "100.98.192.32";
      };
      vader = {
        host = "vader";
        hostname = "100.103.90.38";
      };
      win = {
        host = "win";
        hostname = "100.98.218.54";
      };
    };
  };
}
