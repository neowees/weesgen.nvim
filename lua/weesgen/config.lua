local M = {}

M.defaults = {
	model = "mammouth-recommended",
	url = "https://api.mammouth.ai/v1/chat/completions",
	trigger = "weesgen:",
	api_key_env = "MAMMOUTH_API_KEY",
}

function M.merge(opts)
	return vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
