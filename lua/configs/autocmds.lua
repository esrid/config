vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(false, { ev.buf })
    end
	end,
})

-- Dans ton init.lua ou un fichier de config lua
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  command = "silent! update",
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.templ", callback = function() vim.cmd("TSBufEnable highlight") end }) 

-- Auto-enable Tree-sitter highlight for Go files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.go",
  callback = function()
    vim.cmd("TSBufEnable highlight")
  end,
})

