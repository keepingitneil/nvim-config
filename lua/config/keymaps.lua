-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.del({ "n", "t" }, "<c-/>")

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.keymap.set({ "n", "t", "v" }, "<leader>\\", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local terminal = require("toggleterm.terminal")

  -- Get all existing terminals (visible or hidden)
  local terms = terminal.get_all(true)

  local items = {}

  -- "Create new terminal" option at the top
  table.insert(items, {
    id = -1,
    display = "➕ Create new terminal",
    action = function()
      -- Close all existing terminals first
      for _, term in ipairs(terminal.get_all()) do
        if term:is_open() then
          term:close()
        end
      end
      -- Then open a brand new one
      Terminal:new():toggle()
    end,
  })

  -- Existing terminals
  for _, term in ipairs(terms) do
    local prefix = term:is_open() and "● " or "  "
    table.insert(items, {
      id = term.id,
      display = string.format("%sTerminal %d: %s", prefix, term.id, term.cmd or "toggleterm"),
      action = function()
        -- Close all other open terminals
        for _, other in ipairs(terminal.get_all()) do
          if other.id ~= term.id and other:is_open() then
            other:close()
          end
        end
        -- Open the selected one (toggle will open it if hidden)
        term:toggle()
        vim.schedule(function()
          vim.cmd("startinsert")
        end)
      end,
    })
  end

  vim.ui.select(items, {
    prompt = "Select Terminal (only one will stay open):",
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice and choice.action then
      choice.action()
    end
  end)
end, { desc = "Select or create terminal (closes others)" })

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
