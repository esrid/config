local opts = {noremap=true, silent = true}
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>",opts)
vim.keymap.set("n", "leadero", ":nohlsearch<CR>",opts)



vim.keymap.set("n", "gh", function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

  vim.fn.setreg("+", {}, "V")

  for _, diagnostic in ipairs(diagnostics) do
    vim.fn.setreg("+", vim.fn.getreg("+") .. diagnostic["message"], "V")
  end
end)

