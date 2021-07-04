{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
    extraConfig = "lua require('config')";
  };
  xdg.configFile."nvim/lua/config.lua".text = builtins.readFile ./config.lua;
}
