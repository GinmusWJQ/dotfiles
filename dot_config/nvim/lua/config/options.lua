-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.winbar = "%=%m %f"

-- fold coding
-- opt.foldcolumn = "1" -- 在最左侧添加层级数
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true

-- ----------Neovide配置-------------

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_remember_window_size = true
  vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end
