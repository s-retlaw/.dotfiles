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
"set relativenumber

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

set splitright


let mapleader=" "

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

" TextObj - Custom text objects for the line, indent level, entier file, etc
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'christoomey/vim-textobj-codeblock'

" rust items
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

Plug 'github/copilot.vim'

" used to select objects, i.e text objects
Plug 'wellle/targets.vim'

" nvim-cmp items
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" LSP client and AutoInstaller
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Telesecope setup
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Install Vimspector
Plug 'puremourning/vimspector'

"comments
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

call plug#end()

" Post plugin setup
color gruvbox
set background=dark

" vim surround
let g:surround_99 = "```\r```"

:map <C-n> :NERDTreeToggle<CR>

" --setup telescope
"  " Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" -- Setup TreeSitter
lua <<EOF
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = { "python", "rust", "c", "cpp", "c_sharp", "java",  "lua", "json", "json5", "html", "yaml", "toml", "regex", "javascript", "dockerfile", "bash", "css", "hcl" }, -- "maintained", -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = true, 
  },
  indent = {
    enable = true, 
  },
-- used to setup numToStr/Comment.nvim
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
EOF


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
                          "rust_analyzer",
                          "spectral", --open api
                          "sumneko_lua",
                          "terraformls", 
                          "tsserver", -- js
                          "yamlls",
--                          "zeta_note", -- note there are several for MD
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


lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
--  cmp.setup.filetype('gitcommit', {
--    sources = cmp.config.sources({
--      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--    }, {
--      { name = 'buffer' },
--    })
--  })
--
--  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--  cmp.setup.cmdline('/', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--      { name = 'buffer' }
--    }
--  })
--
--  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--  cmp.setup.cmdline(':', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
--      { name = 'cmdline' }
--    })
--  })
--
  -- Setup lspconfig.
--  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--    capabilities = capabilities
--  }
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
  "omnisharp", -- c#, vb
  "pyright", -- python
  "rust_analyzer",
  "spectral", --open api
  "sumneko_lua",
  "terraformls", 
  "tsserver", -- js
  "yamlls",
 -- "zeta_note", -- note there are several for MD
  }
for _, lsp in ipairs(servers) do
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = capabilities
  }
end
EOF
""""""""""""""""""
" VIMSPECTOR SETUP
""""""""""""""""""

"    Key Mapping Function
"    F5  <Plug>VimspectorContinue  When debugging, continue. Otherwise start debugging.
"    Shift F5  <Plug>VimspectorStop  Stop debugging.
"    Ctrl Shift F5 <Plug>VimspectorRestart Restart debugging with the same configuration.
"    F6  <Plug>VimspectorPause Pause debuggee.
"    F9  <Plug>VimspectorToggleBreakpoint  Toggle line breakpoint on the current line.
"    Shift F9  <Plug>VimspectorAddFunctionBreakpoint Add a function breakpoint for the expression under cursor
"    F10 <Plug>VimspectorStepOver  Step Over
"    F11 <Plug>VimspectorStepInto  Step Into
"    Shift F11 <Plug>VimspectorStepOut Step out of current function scope

let g:vimspector_base_dir='~/.config/nvim/plugins/vimspector'
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
"packadd! vimspector
":Vimspector_install --all

" setup nomToStr/Comment
lua << EOF
require('Comment').setup { 
  pre_hook = function(ctx)
  local U = require 'Comment.utils'

  local location = nil
  if ctx.ctype == U.ctype.block then
    location = require('ts_context_commentstring.utils').get_cursor_location()
  elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
    location = require('ts_context_commentstring.utils').get_visual_start_location()
  end

  return require('ts_context_commentstring.internal').calculate_commentstring {
    key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
    location = location,
    }
  end, 
  }
EOF
