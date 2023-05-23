return {
  -- uncomment and add tools to ensure_installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "marksman",
        "stylua",
        "prettierd",
        "shellcheck",
        "shfmt",
        "flake8",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      },
    },
  },
  -- core language specific extension modules
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.dap.nlua" },

  -- custom language specific extension modules
  -- { import = "plugins.extras.lang.java" },
  { import = "plugins.extras.lang.rust" },
  { import = "plugins.extras.lang.nodejs" },
  {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
