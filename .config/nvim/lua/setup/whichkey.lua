
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

which_key.setup({
  registers = false,
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
})

local opts = {
  mode = "n", -- NORMAL mode
  prefix = " ",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  -- b = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
  ["w"] = { "<cmd>w<CR>", "Write" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No HL" },
  ["q"] = { '<cmd>lua require("setup.functions").smart_quit()<CR>', "Quit" },
  ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
  o = {
    name = "Options",
    w = { '<cmd>lua require("setup.functions").toggle_option("wrap")<cr>', "Wrap" },
    r = { '<cmd>lua require("setup.functions").toggle_option("relativenumber")<cr>', "Relative" },
    l = { '<cmd>lua require("setup.functions").toggle_option("cursorline")<cr>', "Cursorline" },
    s = { '<cmd>lua require("setup.functions").toggle_option("spell")<cr>', "Spell" },
    p = { '<cmd>lua require("setup.functions").toggle_option("paste")<cr>', "Paste" },
    t = { '<cmd>lua require("setup.functions").toggle_tabline()<cr>', "Tabline" },
  },

  s = {
    name = "Split",
    s = { "<cmd>split<cr>", "HSplit" },
    v = { "<cmd>vsplit<cr>", "VSplit" },
  },

--  d = {
--    name = "Debug",
--    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
--    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
--    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
--    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
--    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
--    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
--    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
--    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
--    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
--  },


  f = {
    name = "Find",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>GitBlameToggle<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    G = {
      name = "Gist",
      a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
      d = { "<cmd>Gist -d<cr>", "Delete" },
      f = { "<cmd>Gist -f<cr>", "Fork" },
      g = { "<cmd>Gist -b<cr>", "Create" },
      l = { "<cmd>Gist -l<cr>", "List" },
      p = { "<cmd>Gist -b -p<cr>", "Create Private" },
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    -- o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    -- S = {
    --   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    --   "Workspace Symbols",
    -- },
    t = { '<cmd>lua require("setup.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
    -- u = { '<cmd>LuaSnipUnlinkCurrent<cr>', "Unlink Snippet" },

  },


  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    -- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    -- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    -- t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = " ",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)


