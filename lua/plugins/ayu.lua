return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("ayu").setup {
      mirage = true,
      terminal = true,
      overrides = {},
    }
  end,
}
