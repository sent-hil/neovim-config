local function scrolloff_should_reenable()
  if vim.w.orig_scrolloff == nil then return false end -- Nothing to do.
  if vim.fn.winheight(0) <= vim.w.orig_scrolloff then return true end -- Too small for override.
  return vim.w.orig_scrolloff < vim.fn.winline() and vim.fn.winline() < vim.fn.winheight(0) - vim.w.orig_scrolloff
end

local function scrolloff_add_autocmd()
  vim.api.nvim_create_augroup("h4s_scrolloff_enhanced", { clear = true })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = "h4s_scrolloff_enhanced",
    callback = function()
      if scrolloff_should_reenable() then
        vim.opt.scrolloff = vim.w.orig_scrolloff
        vim.w.orig_scrolloff = nil
        return true -- Remove the autocmd.
      end
    end,
  })
end

local function scrolloff_disable()
  vim.w.orig_scrolloff = vim.opt.scrolloff:get()
  vim.opt.scrolloff = 0
  scrolloff_add_autocmd()
end

local function scroll_very_bottom()
  local current_line = vim.fn.line "."
  scrolloff_disable()
  -- Move one line up to see the line above cursor
  vim.cmd(string.format(":norm! %dGzb", current_line + 3))
  -- Move back to original line
  vim.cmd(string.format(":norm! %dG", current_line))
end

local function scroll_very_top()
  local current_line = vim.fn.line "."
  scrolloff_disable()
  -- Move one line up to position with zt
  vim.cmd(string.format(":norm! %dGzt", current_line - 3))
  -- Move back to original line
  vim.cmd(string.format(":norm! %dG", current_line))
end

vim.keymap.set("n", "zb", scroll_very_bottom, { desc = "better bottom" })
vim.keymap.set("n", "zt", scroll_very_top, { desc = "better top" })
