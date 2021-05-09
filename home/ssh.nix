{ ... }: {
  programs.ssh = {
    enable = true;
    controlMaster = "no";
    forwardAgent = true;
    matchBlocks = {
      babyshark = {
        host = "babyshark";
        hostname = "100.100.213.21";
      };
      mba = {
        host = "mba";
        hostname = "100.89.221.9";
      };
      snowflake = {
        host = "snowflake";
        hostname = "100.121.28.94";
      };
      vader = {
        host = "vader";
        hostname = "100.87.20.70";
      };
      win = {
        host = "win";
        hostname = "100.98.218.54";
        user = "Administrator";
      };
    };
  };
}
