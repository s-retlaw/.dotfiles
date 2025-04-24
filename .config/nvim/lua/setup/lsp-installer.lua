require("nvim-lsp-installer").setup({
  ensure_installed = { -- also see lspconfig
--    "awk_ls", 
--    "ansiblels",
--    "bashls",
--    "ccls",
--    "dockerls",
--    "graphql",
    "html",
--    "jdtls", -- java
--    "jsonls",
--    "lemminx", -- xml
--    "omnisharp", -- c# 
    "pyright", -- python
    "rust_analyzer",
--    "spectral", --open api
--    "sumneko_lua",
    "taplo", -- cargo files
--    "terraformls",
--    "tsserver", -- js
    "yamlls",
    --                          "zeta_note", -- note the     re are several for MD
  }, -- ensure these servers a     re always installed
  automatic_installation = true, -- automatically      detect which servers to install (based on which serv     ers are set up via lspconfig)
  ui = {
    border = "rounded",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})
