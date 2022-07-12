
vim.cmd('source ~/.config/nvim/autoload/plug.vim')

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugins')

Plug 'nvim-lua/plenary.nvim' -- useful lua functions used by severla plugins

Plug 'lunarvim/colorschemes'
Plug 'lunarvim/darkplus.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'scrooloose/nerdtree' -- file manager -- what about vifm?

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'christoomey/vim-textobj-codeblock'
Plug 'wellle/targets.vim'

Plug 'tpope/vim-surround' -- used to surround items or to change a surround
Plug 'tpope/vim-repeat' -- repeat things liek the surround command
Plug 'matze/vim-move' -- use A hjkl to move text
Plug 'lukas-reineke/indent-blankline.nvim' -- used to highlight indents and blank lines
Plug 'nvim-lualine/lualine.nvim'  -- lua based status line
Plug 'tversteeg/registers.nvim' -- used to show a popup for Ctrl R options
Plug 'RRethy/vim-illuminate' -- used to illuminate the word under the cursor

Plug('akinsho/toggleterm.nvim', {['tag'] = 'v1.*'}) -- embed a terminal in nvim
Plug 'folke/which-key.nvim' -- used to show available key combinations

Plug 'numToStr/Comment.nvim'

--Treesitter
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

-- LSP client and AutoInstaller
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

-- nvim-cmp items
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug "NTBBloodbath/rest.nvim"


  -- Telescope
Plug "nvim-telescope/telescope.nvim"
  -- use "tom-anders/telescope-vim-bookmarks.nvim"
Plug "nvim-telescope/telescope-media-files.nvim"

  -- Git
Plug "lewis6991/gitsigns.nvim"
Plug "f-person/git-blame.nvim"
-- Plug "ruifm/gitlinker.nvim"
Plug "mattn/vim-gist"



vim.call('plug#end')

require "setup.colorscheme"
require "setup.nerdtree"
require "setup.lualine"
require "setup.registers"
require "setup.toggleterm"
require "setup.comment"
require "setup.treesitter"
require "setup.lsp-installer"
require "setup.lspconfig"
require "setup.rust-tools"
require "setup.cmp"
require "setup.rest"

require "setup.gist"
require "setup.git-blame"
require "setup.gitsigns"

require "setup.telescope"
require "setup.telescope-file-browser"

require "setup.whichkey"


