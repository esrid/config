return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    local rainbow_delimiters = require "rainbow-delimiters"

    vim.g.rainbow_delimiters = {
      -- Apply globally to all languages
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
      },
      -- Use default rainbow query for all
      query = {
        [''] = 'rainbow-delimiters',
        go = 'rainbow-delimiters',  
lua = 'rainbow-blocks',
      },
      -- Define highlight groups (colors)
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end
}
