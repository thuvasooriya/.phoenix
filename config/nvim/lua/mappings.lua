require("nvchad.mappings")

local map = vim.keymap.set
-- local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "File Format with conform" })

-- no need because of using better-escape.neovim
-- "jj" and "jk" are mapped to <ESC>
-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<leader>fp", "<cmd> Telescope neovim-project discover <CR>", { desc = "Telescope Find projects" })

map("n", "<leader>tt", "<cmd> tabnew <CR>", { desc = "Tab Create new" })
map("n", "<leader>tn", "<cmd> tabnext <CR>", { desc = "Tab Switch next" })

map("n", "<leader>gg", "<cmd> LazyGit <CR>", { desc = "LazyGit Open" })

map("n", "<leader>ls", "<cmd> Lazy sync <CR>", { desc = "Lazy Sync Config" })
map("n", "<leader>ll", "<cmd> HopWord <CR>", { desc = "Hop" })

-- wip code runner function
-- TODO: cleanup, safe execution of c and cpp
-- TODO: execute zig build if build.zig detected in root directory

map({ "n", "t" }, "<C-a>", function()
	local file = vim.fn.expand("%:t")
	local fp = vim.fn.expand("%:p:h")
	local ft = vim.bo.ft
	require("nvchad.term").runner({
		id = "run",
		pos = "sp",
		cmd = function()
			local ft_cmds = {
				python = "python3 " .. file,
				cpp = "zr " .. file,
				c = "zr " .. file,
				zig = "zr " .. file,
			}
			return "cd " .. fp .. " && clear && " .. ft_cmds[ft]
		end,
	})
end, { desc = "Code Runner" })

-- Yes, we're just executing a bunch of Vimscript, but this is the officially
-- endorsed method; see https://github.com/L3MON4D3/LuaSnip#keymaps
-- vim.cmd[[
-- " Use Tab to expand and jump through snippets
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
--
-- " Use Shift-Tab to jump backwards through snippets
-- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- ]]

-- " Expand or jump in insert mode
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
--
-- " Jump forward through tabstops in visual mode
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
-- " Jump backward through snippet tabstops with Shift-Tab (for example)
-- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
-- smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
