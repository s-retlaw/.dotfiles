-- NerdTree post plugin setup
--

--return function()
  local opts = { noremap = true, silent = true }
  local term_opts = { silent = true }

  -- Shorten function name
  local keymap = vim.api.nvim_set_keymap

  keymap("n", "<C-n>", "<cmd>NERDTreeToggle<cr>", opts)
--end
