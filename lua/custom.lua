local M = {}

-- add extra plugins here
M.plugins = {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("ayu").setup {
        mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
        terminal = true, -- Set to `false` to let terminal manage its own colors.
        overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
      }
    end,
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  -- colorscheme for lualine
  {
    -- Rose-pine - Soho vibes for Neovim
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "main",
    },
  },
  -- -- Statusline
  -- -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  {
    "nvim-lualine/lualine.nvim",
    opts = function() require "plugins.configs.lualine" end,
  },
  {
    "justinmk/vim-sneak",
  },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   config = function()
  --     require("auto-save").setup {
  --       trigger_events = {"InsertLeave"},
  --       debounce_delay = 500
  --     }
  --   end,
  -- }
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for v0.4.0+
      "nvim-tree/nvim-web-devicons", -- If you want devicons
      "stevearc/resession.nvim", -- Optional, for persistent history
    },
    config = true,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
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
