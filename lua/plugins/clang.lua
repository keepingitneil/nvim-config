return {
  { import = "lazyvim.plugins.extras.lang.clangd" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          cmd = {
            "/usr/bin/clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--all-scopes-completion",
            "--j=4",
          },
          init_options = {
            clangdFileStatus = true,
          },
          settings = {
            clangd = {
              arguments = {
                "--clang-tidy",
              },
            },
          },
        },
      },
    },
  },
}
