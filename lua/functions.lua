-- Functions for easy access.
vim.api.nvim_create_user_command("CodeAction", function(_) require("tiny-code-action").code_action() end, { nargs = 0 })

vim.api.nvim_create_user_command(
  "Diagnostics",
  function(_) vim.cmd "Trouble diagnostics toggle focus=true" end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "Format",
  function(_) require("conform").format { lsp_fallback = true } end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "IncomingCalls",
  function(_) vim.cmd "Trouble lsp_incoming_calls focus=true" end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command("Lsp", function(_) vim.cmd "Trouble lsp focus=true" end, { nargs = 0 })

vim.api.nvim_create_user_command("OldFiles", function(_) vim.cmd "Telescope oldfiles" end, { nargs = 0 })

vim.api.nvim_create_user_command(
  "OutgoingCalls",
  function(_) vim.cmd "Trouble lsp_outgoing_calls focus=true" end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command("Symbols", function(_) vim.cmd "Trouble symbols toggle focus=true" end, { nargs = 0 })
