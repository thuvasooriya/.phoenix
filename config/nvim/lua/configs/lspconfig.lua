local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = { "html", "cssls", "tsserver", "clangd", "zls", "pyright", "astro", "texlab" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_init = on_init,
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.verible.setup({
	on_attach = on_attach,
	root_dir = function()
		return vim.loop.cwd() -- fixes git problem with verible
	end,
	cmd = { "verible-verilog-ls", "--rules_config_search" },
})
