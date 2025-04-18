vim.lsp.config["bash-language-server"] = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command)",
			-- Disable shellcheck, since the linter already handles it
			shellcheckPath = "",
		},
	},
}

vim.lsp.enable("bash-language-server")
