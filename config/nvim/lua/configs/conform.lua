local options = {
	lsp_fallback = true,
	timeout_ms = 2000,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },

		sh = { "shfmt" },
		zig = { "zigfmt" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		nix = { "nixpkgs-fmt" },
		-- sv = { "verible" },
	},
}

require("conform").setup(options)
