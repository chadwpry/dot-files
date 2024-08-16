require("nvchad.mappings")

-- add yours here
local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("v", "<Leader>sa", ":sort<enter>")
map("v", "<Leader>sd", ":sort!<enter>")
map("v", "<Leader>su", ":sort u<enter>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local dap = require("dap")
local dapui = require("dapui")

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<Leader>dc", dap.continue, {})
