return {
  "folke/snacks.nvim",
  ---@type snacks.Config
opts = {
  explorer = {
    replace_nvtree = true,
    auto_close = true,
    exclude = {"node_modules", "tmp"},
    hidden = false
  },
  picker = {
    exclude = {"node_modules", "tmp"},
      hidden = false,
  },
},
  keys = {
    { "<leader><space>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
   { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" }
  }
}

