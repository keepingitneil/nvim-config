return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure we extend the list instead of overwriting it
      if opts.ensure_installed then
        vim.list_extend(opts.ensure_installed, { "jsonnet" })
      else
        opts.ensure_installed = { "jsonnet" }
      end
    end,
  },
}
