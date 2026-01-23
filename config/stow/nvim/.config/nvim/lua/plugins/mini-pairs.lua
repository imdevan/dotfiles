return {
  {
    "echasnovski/mini.pairs",
    opts = function(_, opts)
      opts.modes = {
        insert = true,
        command = false,
        terminal = true,
      }
      return opts
    end,
  },
}
