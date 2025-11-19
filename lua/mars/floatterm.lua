-- Floating terminal module
local M = {}

-- State
local state = {
	buf = nil,
	win = nil,
}

-- Check if buffer is valid and exists
local function is_buf_valid(buf)
	return buf and vim.api.nvim_buf_is_valid(buf)
end

-- Check if window is valid and exists
local function is_win_valid(win)
	return win and vim.api.nvim_win_is_valid(win)
end

-- Create floating window
local function create_window(buf)
	local ui = vim.api.nvim_list_uis()[1]
	local width = math.floor(ui.width * 0.8)
	local height = math.floor(ui.height * 0.8)

	local col = math.floor((ui.width - width) / 2)
	local row = math.floor((ui.height - height) / 2)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	return vim.api.nvim_open_win(buf, true, opts)
end

-- Toggle floating terminal
function M.toggle()
	-- If window is open, close it
	if is_win_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
		state.win = nil
		return
	end

	-- If buffer doesn't exist or is invalid, create new terminal
	if not is_buf_valid(state.buf) then
		state.buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(state.buf, "bufhidden", "hide")
	end

	-- Create window and show buffer
	state.win = create_window(state.buf)

	-- Start terminal if buffer is empty (first time or after terminal exit)
	local line_count = vim.api.nvim_buf_line_count(state.buf)
	if line_count == 1 then
		local first_line = vim.api.nvim_buf_get_lines(state.buf, 0, 1, false)[1]
		if first_line == "" then
			vim.fn.termopen(vim.o.shell)
		end
	end

	-- Enter insert mode
	vim.cmd("startinsert")
end

-- Setup keymaps
vim.keymap.set("n", "<leader>t", M.toggle, { desc = "Toggle floating terminal", silent = true })
vim.keymap.set("t", "<esc><esc>", M.toggle, { desc = "Toggle floating terminal", silent = true })
vim.keymap.set("i", "<leader>t", M.toggle, { desc = "Toggle floating terminal", silent = true })

return M
