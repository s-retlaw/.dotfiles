
local options = {
  backspace = "2",                           --  Backspace deletes like most programs in insert mode  
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  -- colorcolumn = "120",
  colorcolumn = "80",
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  cursorline = true,                       -- highlight the current line
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  hlsearch = true,                         -- highlight all matches on previous search pattern
  hidden=true,                              -- don't require saving before close
  ignorecase = true,                       -- ignore case in search patterns
  laststatus = 3,
  mouse = "a",                             -- allow the mouse to be used in neovim
  number = true,                           -- set numbered lines
  numberwidth = 5,                         -- set number column width to 2 {default 4}
  pumheight = 10,                          -- pop up menu height
  -- relativenumber = true,                  -- set relative numbered lines
  ruler = true,
  scrolloff = 8,                           -- is one of my fav
  shell="/bin/bash",
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  showcmd = false,
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- always show tabs
  sidescrolloff = 8,
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  tabstop = 2,                             -- insert 2 spaces for a tab
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 400,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = false,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  wrap = false,                            -- display lines as one long line
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

