local config = require("weesgen.config")
local context = require("weesgen.context")
local api = require("weesgen.api")

local M = {}
M.config = config.defaults

function M.trigger_generate()
	local line = vim.api.nvim_get_current_line()
	local lnum = vim.api.nvim_win_get_cursor(0)[1]

	local instruction = context.extract_instruction(line, M.config.trigger)
	if not instruction or instruction == "" then
		vim.notify("weesgen: no instruction found after trigger", vim.log.levels.WARN)
		return
	end

	local buf_context = context.get_buffer_context()
	local prompt = api.build_prompt(buf_context, instruction)

	vim.notify("weesgen: generating...", vim.log.levels.INFO)

	api.request(M.config, prompt, function(content, err)
		vim.schedule(function()
			if err then
				vim.notify("weesgen: " .. err, vim.log.levels.ERROR)
				return
			end
			local lines = vim.split(content, "\n", { plain = true })
			vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, lines)
		end)
	end)
end

function M.setup(opts)
	M.config = config.merge(opts)
	vim.api.nvim_create_user_command("Weesgen", M.trigger_generate, {})
	vim.keymap.set("n", "<leader>wg", M.trigger_generate, { desc = "weesgen: generate from context" })
end

return M
