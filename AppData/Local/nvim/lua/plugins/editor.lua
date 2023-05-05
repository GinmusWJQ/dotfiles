return {
  -- 添加一些自定义的telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "debugloop/telescope-undo.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_cutoff = 0.2,
            preview_height = 0.4,
          },
          height = 0.9,
          width = 0.9,
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["j"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["gg"] = function(...)
              return require("telescope.actions").move_to_top(...)
            end,
            ["G"] = function(...)
              return require("telescope.actions").move_to_bottom(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
        },
      },
      extensions = {
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.4,
          },
        },
      },
    },
    keys = {
      {
        "<leader>sN",
        "<cmd>Telescope notify<cr>",
        desc = "View Nvim-Notify History",
      },
      {
        "<leader>su",
        "<cmd>Telescope undo<cr>",
        desc = "View Undo History",
      },
      {
        "<leader>sB",
        "<cmd>Telescope file_browser path=%:p:h=%:p:h<cr>",
        desc = "Browser Files",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
      telescope.load_extension("undo")
      telescope.load_extension("file_browser")
      telescope.load_extension("notify")
    end,
  },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = function()
      local icons = require("lazyvim.config").icons
      require("symbols-outline").setup({
        symbols = {
          File = { icon = icons.kinds.File, hl = "TSURI" },
          Module = { icon = icons.kinds.Module, hl = "TSNamespace" },
          Namespace = { icon = icons.kinds.Namespace, hl = "TSNamespace" },
          Package = { icon = icons.kinds.Package, hl = "TSNamespace" },
          Class = { icon = icons.kinds.Class, hl = "TSType" },
          Method = { icon = icons.kinds.Method, hl = "TSMethod" },
          Property = { icon = icons.kinds.Property, hl = "TSMethod" },
          Field = { icon = icons.kinds.Field, hl = "TSField" },
          Constructor = { icon = icons.kinds.Constructor, hl = "TSConstructor" },
          Enum = { icon = icons.kinds.Enum, hl = "TSType" },
          Interface = { icon = icons.kinds.Interface, hl = "TSType" },
          Function = { icon = icons.kinds.Function, hl = "TSFunction" },
          Variable = { icon = icons.kinds.Variable, hl = "TSConstant" },
          Constant = { icon = icons.kinds.Constant, hl = "TSConstant" },
          String = { icon = icons.kinds.String, hl = "TSString" },
          Number = { icon = icons.kinds.Number, hl = "TSNumber" },
          Boolean = { icon = icons.kinds.Boolean, hl = "TSBoolean" },
          Array = { icon = icons.kinds.Array, hl = "TSConstant" },
          Object = { icon = icons.kinds.Object, hl = "TSType" },
          Key = { icon = icons.kinds.Key, hl = "TSType" },
          Null = { icon = icons.kinds.Null, hl = "TSType" },
          EnumMember = { icon = icons.kinds.EnumMember, hl = "TSField" },
          Struct = { icon = icons.kinds.Struct, hl = "TSType" },
          Event = { icon = icons.kinds.Event, hl = "TSType" },
          Operator = { icon = icons.kinds.Operator, hl = "TSOperator" },
          TypeParameter = { icon = icons.kinds.TypeParameter, hl = "TSParameter" },
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem.filtered_items = {
        hide_gitigored = false,
        visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
        hide_dotfiles = false,
      }
      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    -- opts = function(_, opts)
    --   vim.list_extend(opts.defaults, {
    --     ["<leader>r"] = { name = "rust actions", ["c"] = { name = "crate action" } },
    --   })
    -- end,
    opts = {
      defaults = {
        ["<leader>r"] = { name = "rust actions", ["c"] = { name = "crate action" } },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.register(opts.defaults)
    end,
  },
}
