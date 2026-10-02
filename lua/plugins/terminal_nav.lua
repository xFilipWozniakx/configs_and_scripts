return {
  -- Konfiguracja dla Snacks Terminal (domyślny w LazyVim)
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.terminal = opts.terminal or {}
      local orig_setup = opts.terminal.setup
      opts.terminal.setup = function(self)
        orig_setup(self)
        -- ZMIANA: Używamy Ctrl+v zamiast jj, aby uniknąć przypadkowego wywołania
        vim.keymap.set("t", "<C-v>", [[<C-\><C-n>]], { buffer = true, desc = "Terminal Normal Mode" })
        -- Opcjonalnie: Ctrl+q do całkowitego zamknięcia terminala
        vim.keymap.set("t", "<C-q>", "<cmd>q<cr>", { buffer = true, desc = "Close Terminal" })
      end
    end,
  },
  -- Konfiguracja dla ToggleTerm (dla kompatybilności)
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      opts.terminal_mappings = true
    end,
    config = function(_, opts)
      require("toggleterm").setup(opts)
      vim.keymap.set("t", "<C-v>", [[<C-\><C-n>]], { desc = "Terminal Normal Mode" })
      vim.keymap.set("t", "<C-q>", "<cmd>q<cr>", { desc = "Close Terminal" })
    end,
  },
}
