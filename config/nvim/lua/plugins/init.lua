local overrides = require("configs.overrides")

return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("configs.conform")
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").setup()
			require("telescope").load_extension("fzf")
		end,
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"coffebar/neovim-project",
		opts = overrides.nvimproject,
		-- init = function()
		-- enable saving the state of plugins in the session
		-- vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
		-- vim.opt.sessionoptions:remove("tabpages")
		-- end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "Shatur/neovim-session-manager" },
		},
		-- lazy = false,
		-- priority = 100,
	},

	{
		"smoka7/hop.nvim",
		version = "v2.5.1",
		cmd = {
			"HopWord",
		},
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	-- {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- },

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		cmd = {
			"NvimTreeFocus",
		},
		opts = overrides.nvimtree,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		-- init = function()
		--   require("core.utils").load_mappings "harpoon"
		-- end,
		opts = overrides.harpoon,
		-- dependencies = { "nvim-lua/plenary.nvim" },
	},
}

-- To make a plugin not be loaded
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = false
-- },

-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
-- {
--   "mg979/vim-visual-multi",
--   lazy = false,
-- }
