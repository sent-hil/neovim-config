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
map("n", "<leader>q", ":qa!<CR>", {})

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>", {})

-- Move around splits
--map("n", "<leader>wh", "<C-w>h", { desc = "switch window left" })
--map("n", "<leader>wj", "<C-w>j", { desc = "switch window right" })
--map("n", "<leader>wk", "<C-w>k", { desc = "switch window up" })
--map("n", "<leader>wl", "<C-w>l", { desc = "switch window down" })

-- Splits
map("n", "<C-w>l", "<C-w>v", { desc = "Split vertically" })
map("n", "<C-w>j", "<C-w>s", { desc = "Split horizontally" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to top split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to bottom split" })

-- Reload configuration without restart nvim
map("n", "<leader>r", ":source $MYVIMRC<CR>", { desc = "Reload configuration without restart nvim" })

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader>p", builtin.find_files, { desc = "Open Telescope to find files" })
map("n", "<leader>f", builtin.live_grep, { desc = "Open Telescope to do live grep" })
map("n", "<leader>b", builtin.buffers, { desc = "Open Telescope to list buffers" })
map("n", "<leader>m", builtin.marks, { desc = "Open Telescope to list buffers" })
--map("n", "<leader>fh", builtin.help_tags, { desc = "Open Telescope to show help" })
--map("n", "<leader>fo", builtin.oldfiles, { desc = "Open Telescope to list recent files" })
map("n", "<leader>cm", builtin.git_commits, { desc = "Open Telescope to list git commits" })
-- NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree sidebar" }) -- open/close
--map("n", "<leader>nr", ":NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })         -- refresh
--map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { desc = "Search file in NvimTree" }) -- search file

-- LSP
map(
  "n",
  "<leader>gm",
  function() require("conform").format { lsp_fallback = true } end,
  { desc = "General Format file" }
)

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- Comment
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment", remap = true })

map("n", "<leader>o", ":Outline<CR>", { desc = "Toggle Outline" }) -- open/close

map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- GPTModelsCode
vim.api.nvim_set_keymap('v', '<leader>a', ':GPChatToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>a', ':GPChatToggle<CR>', { noremap = true })

--vim.api.nvim_set_keymap('v', '<leader>c', ':GPTModelsChat<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>c', ':GPTModelsChat<CR>', { noremap = true })

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

-- Navigate softwrapped lines like regular lines
map("n", "gj", "j")
map("n", "j", "gj")
