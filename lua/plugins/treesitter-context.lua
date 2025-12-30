return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy", -- or "BufReadPost" etc.
    opts = {}, -- Optional: customize here or in setup()
  },
}
