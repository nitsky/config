{ ... }: {
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_threads = true;
      hide_userland_threads = true;
      show_program_path = false;
      tree_view = true;
      vim_mode = true;
    };
  };
}
