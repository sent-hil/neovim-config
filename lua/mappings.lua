--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: mappings.lua
-- Description: Key mapping configs
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

-- <leader> is a space now
local map = vim.keymap.set
map("n", "<leader>q", ":qa<CR>", {})

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", {})

-- Splits
map("n", "<C-w>l", "<C-w>v", { desc = "Split vertically" })
map("n", "<C-w>j", "<C-w>s", { desc = "Split horizontally" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to top split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to bottom split" })

-- Navigate softwrapped lines like regular lines
map("n", "gj", "j")
map("n", "j", "gj")
map("n", "q", ":bd<cr>")

-- Reload configuration without restart nvim
map(
  "n",
  "<leader>r",
  ":source $MYVIMRC<CR>",
  { desc = "Reload configuration without restart nvim" }
)

-- Comment
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- PLUGINS

-- Telescope
local builtin = require "telescope.builtin"
map(
  "n",
  "<leader>p",
  builtin.find_files,
  { desc = "Open Telescope to find files" }
)
map(
  "n",
  "<leader>f",
  builtin.live_grep,
  { desc = "Open Telescope to do live grep" }
)

-- NvimTree
map(
  "n",
  "<leader>n",
  ":NvimTreeToggle<CR>",
  { desc = "Toggle NvimTree sidebar" }
) -- open/close

-- Goto buffer in position...
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })

for i = 1, 9 do
  map(
    "n",
    ("<Leader>%s"):format(i),
    ("<Plug>(cokeline-focus-%s)"):format(i),
    { silent = true }
  )
end

-- Trouble
map(
  "n",
  "<leader>o",
  function() vim.cmd.Symbols() end,
  { desc = "Toggle Symbols" }
) -- open/close

-- Navigate wildmenu, ie the menu that opens up when you do `:A<tab>` with
-- arrow keys.
vim.opt.wildcharm = ("<C-Z>"):byte()
vim.keymap.set(
  "c",
  "<up>",
  function() return vim.fn.wildmenumode() == 1 and "<left>" or "<up>" end,
  { expr = true }
)
vim.keymap.set(
  "c",
  "<down>",
  function() return vim.fn.wildmenumode() == 1 and "<right>" or "<down>" end,
  { expr = true }
)
vim.keymap.set(
  "c",
  "<left>",
  function() return vim.fn.wildmenumode() == 1 and "<up>" or "<left>" end,
  { expr = true }
)
vim.keymap.set(
  "c",
  "<right>",
  function() return vim.fn.wildmenumode() == 1 and " <bs><C-Z>" or "<right>" end,
  { expr = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>sd",
  [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],
  { silent = true, noremap = true }
)
