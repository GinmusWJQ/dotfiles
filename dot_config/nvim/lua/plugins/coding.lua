return {
  -- 颜色美化器
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  -- 继承原本的nvim-cmp,修改快捷键，并且添加cmdline补全模式
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })

      local cmpline_mapping = {
        ["<C-j>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
        ["<C-k>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
      }

      -- 搜索模式
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(cmpline_mapping),
        sources = {
          { name = "buffer" },
        },
      })
      -- 普通的cmdline模式
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(cmpline_mapping),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
  -- 代码缩略
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {
      provider_selector = function(_bufnr, _filetype)
        return { "treesitter", "indent" }
      end,
      -- open opening the buffer, close these fold kinds
      -- use `:UfoInspect` to get available fold kinds from the LSP
      close_fold_kinds = { "comment", "imports" },
      open_fold_hl_timeout = 500,
    },
    config = function(_, opts)
      require("ufo").setup(opts)
    end,
  },
}
