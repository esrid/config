return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			-- Default options: fallback to LSP if no formatter found
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- HTML: use prettierd or prettier, stop after first available
				html = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				-- CSS: use prettierd or prettier, stop after first available
				css = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				-- Go: goimports first, then gofmt
				go = {
					"goimports",
					"gofmt",
					stop_after_first = true, -- usually enough to run goimports alone
				},
			},
		})
	end,
}
