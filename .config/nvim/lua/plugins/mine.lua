return {
	{
	    "morhetz/gruvbox",
	    lazy = false, -- make sure we load this during startup if it is your main colorscheme
	    priority = 1000, -- make sure to load this before all the other start plugins
	    config = function()
	      -- load the colorscheme here
	      vim.cmd([[colorscheme gruvbox]])
	    end,
	},
    { "kshenoy/vim-signature" },
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "preservim/nerdtree" },
    { "derekwyatt/vim-scala" },
    { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" }, -- fzf native binary
    { "junegunn/fzf.vim" },
    { "tpope/vim-sleuth" },
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        -- Global keymap to toggle tree
	vim.keymap.set('n', '<C-e>', function()
	  require('nvim-tree.api').tree.toggle()
	  end, { noremap = true, silent = true })
	
	local api = require("nvim-tree.api")

	local function my_on_attach(bufnr)
	  -- Optional: keep default mappings
	  api.config.mappings.default_on_attach(bufnr)

	  -- Custom: open file in new tab with 't'
	  vim.keymap.set("n", "t", api.node.open.tab, {
	    desc = "nvim-tree: Open in new tab",
	    buffer = bufnr,
	    noremap = true,
	    silent = true,
	    nowait = true,
	  })
	end
        require("nvim-tree").setup({
          on_attach = my_on_attach,
        })
      end
    }
}
