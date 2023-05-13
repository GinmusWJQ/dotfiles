return {
  -- colorscheme 添加tokyonight
  { "folke/tokyonight.nvim", lazy = false },
  -- colorscheme 添加onedark
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
