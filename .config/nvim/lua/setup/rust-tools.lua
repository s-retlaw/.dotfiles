
local opts = {
  tools = {
    on_initialized = function()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
        pattern = { "*.rs" },
        callback = function()
          vim.lsp.codelens.refresh()
          vim.cmd('RustSetInlayHints')
        end,
      })
    end,
    inlay_hints = {
      parameter_hints_prefix = " ",
      other_hints_prefix = " ",
    },
  },
  server = {
--    on_attach = my_on_attach,
--    capabilities = cap,

    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}
require('rust-tools').setup(opts)


