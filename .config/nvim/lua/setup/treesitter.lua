local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {
--    "bash",
--    "c",
--    "cpp",
--    "c_sharp",
    "css",
    "dockerfile",
--    "hcl",
    "html",
--    "java",
    "javascript",
    "json",
    "json5",
--    "lua",
    "python",
--    "regex",
    "rust",
    "toml",
    "yaml",
  }, -- "maintained", -- Only use parsers that are maintained

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

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
  },

  textobjects = {
    -- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
  },
}
