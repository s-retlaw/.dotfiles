set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
let &packpath = &runtimepath
set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=
source ~/.config/nvim/autoload/plug.vim



" General Vim Settings
" --------------------

set nocompatible
filetype plugin indent on

syntax on
set backspace=2      " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set laststatus=2     " Always display the status line
set autowrite        " Automatically :write before running commands
set formatoptions-=t " Don't auto-break long lines (re-enable this for prose)
set ignorecase

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Display relative line numbers, with absolute line number for current line
set number
set numberwidth=5
set relativenumber

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

set splitright


let mapleader=","

" Base64 decode word under cursor
nmap <Leader>b :!echo <C-R><C-W> \| base64 -d<CR>

" grep recursively for word under cursor
nmap <Leader>g :tabnew\|read !grep -Hnr '<C-R><C-W>'<CR>

" sort the buffer removing duplicates
nmap <Leader>s :%!sort -u --version-sort<CR>

" Don't require saving before closing a buffer
set hidden
set path+=**
set wildmenu
set wildmode=list:longest


set shell=/bin/bash
call plug#begin('~/.config/nvim/plugins')

" Fugitive - Vim meets git. Gstatus, Gdiff, etc.
Plug 'tpope/vim-fugitive'
nnoremap \<space> :Git<cr>:wincmd _<cr>
nnoremap \gr :Grebase -i master<cr>

Plug 'morhetz/gruvbox'

Plug 'scrooloose/nerdtree'

" Surround - Mappings for adding, removing, and changing surrounding characters
Plug 'tpope/vim-surround'
let g:surround_99 = "```\r```"

" TextObj - Custom text objects for the line, indent level, entier file, etc
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'christoomey/vim-textobj-codeblock'
Plug 'neovim/nvim-lspconfig'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'github/copilot.vim'
Plug 'wellle/targets.vim'

" LSP client and AutoInstaller
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
call plug#end()

" Post plugin setup
color gruvbox
set background=dark

" -- Setup LSP
lua <<EOF
require("nvim-lsp-installer").setup({
    ensure_installed = {  
                          "ansiblels",  
                          "dockerls",
                          "html",
                          "jdtls", -- java
                          "jsonls",
                          "lemminx", -- xml
                          "pyright", -- python
                          "remark_ls", -- note there are several for MD
                          "rust_analyzer",
                          "spectral", --open api
                          "sumneko_lua",
                          "terraformls", 
                          "tsserver", -- js
                          "yamlls",
                        }, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
EOF

" require'lspconfig'.rust_analyzer.setup{}
" require'lspconfig'.pylsp.setup{}

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
"set completeopt=menuone,noinsert,noselect
set completeopt=menuone,noinsert

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>lg', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 
  "ansiblels",  
  "dockerls",
  "html",
  "jdtls", -- java
  "jsonls",
  "lemminx", -- xml
  "pyright", -- python
  "remark_ls", -- note there are several for MD
  "rust_analyzer",
  "spectral", --open api
  "sumneko_lua",
  "terraformls", 
  "tsserver", -- js
  "yamlls",
  }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
