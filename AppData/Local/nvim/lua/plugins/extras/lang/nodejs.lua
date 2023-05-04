return {

  -- extend auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "vuki656/package-info.nvim",
        event = { "BufRead package.json" },
        config = true,
      },
      {
        "David-Kunz/cmp-npm",
        event = { "BufRead package.json" },
        config = true,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "npm", keyword_length = 3 },
      }))
    end,
  },

  -- add fontend stuff to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "css", "html", "javascript", "jsdoc", "scss", "typescript" })
    end,
  },

  -- correctly setup mason lsp extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "html-lsp",
        "stylelint-lsp",
        "typescript-language-server",
        "vue-language-server",
        "tailwindcss-language-server",
      })
    end,
  },

  -- correctly setup mason dap extensions
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, { "js" })
  --   end,
  -- },

  {
    "mxsdev/nvim-dap-vscode-js",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      local dap = require("dap")
      local dap_js = require("dap-vscode-js")
      -- vscode-js configuration for debugging support
      local DEBUG_PATH = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
      dap_js.setup({
        node_path = "node",
        debugger_path = DEBUG_PATH,
        adapters = { "pwa-node", "node-terminal", "pwa-chrome" }, -- which adapters to register in nvim-dap
      })
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "launch file (" .. language .. ")",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "attach (" .. language .. ")",
            processid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
      for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-chrome",
            name = "Attach - Remote Debugging",
            request = "attach",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            name = "Launch Chrome",
            request = "launch",
            url = "http://localhost:3000",
            browserLaunchLocation = "workspace",
          },
        }
      end
    end,
  },
}
