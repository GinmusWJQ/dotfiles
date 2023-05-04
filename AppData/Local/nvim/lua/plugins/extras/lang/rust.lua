return {

  -- extend auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
          local crates = require("crates")
          crates.setup()
          vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Toggle Crates" })
          vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload Creates" })

          vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show Version" })
          vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show Features" })
          -- vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
          --
          -- vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
          -- vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
          -- vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
          -- vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
          -- vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
          -- vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)
          --
          -- vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
          -- vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
          -- vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
          -- vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "crates" },
      }))
    end,
  },

  -- add rust to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
    end,
  },

  -- correctly setup mason lsp extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust-analyzer", "taplo" })
    end,
  },

  -- correctly setup mason dap extensions
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb" })
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      -- make sure mason installs the server
      setup = {
        rust_analyzer = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "rust_analyzer" then
              vim.keymap.set("n", "<leader>rh", "<CMD>RustHoverActions<CR>", { buffer = buffer, desc = "RustHoverActions"})
              vim.keymap.set("n", "<leader>rd", "<CMD>RustDebuggables<CR>", { buffer = buffer, desc = "Run RustDebuggables" })
              vim.keymap.set("n", "<leader>rc", "<CMD>RustOpenCargo<CR>", { buffer = buffer, desc = "Open Cargo.toml" })
              vim.keymap.set("n", "<leader>rp", "<CMD>RustParentModule<CR>", { buffer = buffer, desc = "Open Parent Moudule" })
            end
          end)
          local mason_registry = require("mason-registry")
          local rust_tools_opts = vim.tbl_deep_extend("force", opts, {
            tools = {
              hover_actions = {
                auto_focus = false,
                border = "none",
              },
              inlay_hints = {
                show_parameter_hints = true,
              },
            },
            server = {
              settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    features = "all",
                  },
                  -- Add clippy lints for Rust.
                  checkOnSave = true,
                  check = {
                    command = "clippy",
                    features = "all",
                  },
                  procMacro = {
                    enable = true,
                  },
                },
              },
            },
          })
          if mason_registry.has_package("codelldb") then
            -- rust tools configuration for debugging support
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
              or extension_path .. "lldb/lib/liblldb.so"

            rust_tools_opts = vim.tbl_deep_extend("force", rust_tools_opts, {
              dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
              },
            })
          end
          require("rust-tools").setup(rust_tools_opts)
          return true
        end,
        taplo = function(_, _)
          local crates = require("crates")
          local function show_documentation()
            if vim.fn.expand("%:t") == "Cargo.toml" and crates.popup_available() then
              crates.show_popup()
            else
              vim.lsp.buf.hover()
            end
          end
          require("lazyvim.util").on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "taplo" then
              vim.keymap.set("n", "K", show_documentation, { buffer = buffer })
            end
          end)
          return false -- make sure the base implementation calls taplo.setup
        end,
      },
    },
  },
}
