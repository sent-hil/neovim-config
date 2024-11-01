--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: autocmds.lua
-- Description: Autocommand functions
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

-- Auto format on save using the attached (optionally filtered) language server
-- clients https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
autocmd("BufWritePre", {
  pattern = "",
  command = ":silent Format",
})

-- Don"t auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

autocmd("Filetype", {
  pattern = {
    "xml",
    "html",
    "xhtml",
    "css",
    "scss",
    "javascript",
    "typescript",
    "yaml",
    "lua",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

autocmd("Filetype", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("BufWinEnter", {
  desc = "return cursor to where it was last time closing the file",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

autocmd("Filetype", {
  pattern = { "AvanteInput" },
  callback = function() vim.opt_local.wrap = true end,
})

-- Expand current buffer path in nvim-tree
local function auto_update_path()
  local buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(buf)
  if vim.fn.isdirectory(bufname) or vim.fn.isfile(bufname) then
    require("nvim-tree.api").tree.find_file(vim.fn.expand "%:p")
  end
end

autocmd("BufEnter", { callback = auto_update_path })

-- Map `q` to close terminal when open. Any of the terminal toggle commands
-- will work in place of :TermFloat
autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.keymap.set("n", "q", ":TermFloat<CR>", { buffer = true, silent = true })
  end,
})

-- Show | at end of line if it is over 80 characters.
local namespace = vim.api.nvim_create_namespace "wrap_limit"

local function update_wrap_limit_indicator()
  local buf = vim.api.nvim_get_current_buf()

  -- Clear any existing extmarks in the namespace to prevent duplicates
  vim.api.nvim_buf_clear_namespace(buf, namespace, 0, -1)

  -- Loop through each line in the buffer and set the indicator if line length is 80 or more
  for line = 0, vim.api.nvim_buf_line_count(buf) - 1 do
    local line_text = vim.api.nvim_buf_get_lines(buf, line, line + 1, false)[1]
      or ""
    local text_length = #line_text

    -- Only add the indicator if the line length is 80 or more
    if text_length >= 80 then
      vim.api.nvim_buf_set_extmark(buf, namespace, line, text_length, {
        virt_text = { { "│", "NonText" } }, -- Only a single thin indicator line
        virt_text_pos = "eol", -- End of line, no overlap with text
        hl_mode = "combine",
      })
    end
  end
end
vim.api.nvim_create_autocmd(
  { "BufEnter", "TextChanged", "TextChangedI", "InsertLeave" },
  {
    pattern = "*",
    callback = update_wrap_limit_indicator,
  }
)
