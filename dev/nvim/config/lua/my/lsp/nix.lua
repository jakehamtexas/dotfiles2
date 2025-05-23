return function(opts)
	vim.lsp.config["nixd"] = {
		cmd = { "nixd" },
		filetypes = opts.filetypes,
		root_markers = { "flake.lock", ".git" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				pkgs = {
					expr = "import <nixpkgs> { }",
				},
				options = {
					nixos = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.jakeh.options',
					},
					home_manager = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.jakeh.options',
					},
				},
			},
		},
		capabilities = opts.capabilities or nil,
	}

	vim.lsp.enable("nixd")
end
