{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-vsnip
      comment-nvim
      gitsigns-nvim
      lsp-status-nvim
      lsp_extensions-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter
      nvim-web-devicons
      playground
      plenary-nvim
      rust-tools-nvim
      telescope-symbols-nvim
      telescope-nvim
      vim-vsnip
    ];
    extraConfig = ''
      lua << EOF
        ${builtins.readFile ./config.lua}
      EOF
    '';
  };
}
