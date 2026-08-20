local M = {}

function M.get_buffer_context()
	return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
end

function M.extract_instruction(line, trigger)
	return line:match(vim.pesc(trigger) .. "%s*(.*)")
end

return M
