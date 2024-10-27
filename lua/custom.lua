local M = {}

-- add extra plugins here
M.plugins = {
  require "plugins.ayu",
  require "plugins.lualine",
  require "plugins.avante",
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "stevearc/resession.nvim",
    },
    config = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "main",
    },
  },
  {
    "justinmk/vim-sneak",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    config = function() require("tiny-code-action").setup() end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      win = {
        type = 'split',
        position = 'right'
      }
    },
    cmd = "Trouble",
  }
}

-- add extra configuration options here, like extra autocmds etc.
-- feel free to create your own separate files and require them in here
M.configs = function()
  require("ayu").colorscheme()
  require("toggleterm").setup {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.47
      else
        return 20 -- Default size if direction is unknown
      end
    end,
    open_mapping = [[<c-\>]],
    direction = "vertical",
    shade_terminals = false,
  }
  require("render-markdown").setup {
    code = {
      enabled = true,
      sign = false,
      style = "normal",
    },
  }
  require "functions"
end
-- add servers to be used for auto formatting here
M.formatting_servers = {
  rust_analyzer = {},
  lua_ls = {},
}

-- add Tree-sitter to auto-install
M.ensure_installed = { "toml" }

-- add any null-ls sources you want here
M.setup_sources = function(b)
  return {
    b.formatting.autopep8,
    b.formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    b.formatting.black.with {
      extra_args = { "--fast" },
    },
    b.formatting.stylua,
  }
end

return M
