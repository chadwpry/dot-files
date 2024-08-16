local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()
require("dap-go").setup()

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

vim.keymap.set("n", "<Leader>ds", function()
  dap.continue()
  dapui.toggle({})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
end)
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<Leader>dc", dap.continue, {})
vim.keymap.set("n", "<Leader>de", function()
  dap.terminate()
  dapui.toggle({})
end)
vim.keymap.set("n", "<Leader>dsd", dap.step_into, {})
vim.keymap.set("n", "<Leader>dso", dap.step_over, {})
vim.keymap.set("n", "<Leader>dsu", dap.step_out, {})
vim.keymap.set("n", "<Leader>dr", function()
  dap.repl.toggle()
end)
vim.keymap.set("n", "<Leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end)

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", numhl = "" })
