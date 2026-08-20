local M = {}

function M.build_prompt(context, instruction)
	return string.format(
		"You are a code assistant embedded in an editor. Given the file context below, %s\n\n"
			.. "OUTPUT ONLY CODE. NO EXPLANATIONS EXCEPT AS CODE COMMENTS. NO MARKDOWN FENCES.\n\n"
			.. "--- FILE CONTEXT ---\n%s\n--- END CONTEXT ---",
		instruction,
		context
	)
end

function M.request(cfg, prompt, callback)
	local api_key = os.getenv(cfg.api_key_env)
	if not api_key or api_key == "" then
		callback(nil, cfg.api_key_env .. " not set in environment")
		return
	end

	local body = vim.json.encode({
		model = cfg.model,
		messages = { { role = "user", content = prompt } },
	})

	vim.system(
		{
			"curl", "-s", "--max-time", "60",
			"-X", "POST", cfg.url,
			"-H", "Authorization: Bearer " .. api_key,
			"-H", "Content-Type: application/json",
			"-d", body,
		},
		{ text = true },
		function(result)
			if result.code ~= 0 then
				callback(nil, "curl failed: " .. (result.stderr or ""))
				return
			end

			local ok, decoded = pcall(vim.json.decode, result.stdout)
			if not ok then
				callback(nil, "could not parse response")
				return
			end

			if decoded.error then
				callback(nil, "API error: " .. vim.inspect(decoded.error))
				return
			end

			local content = decoded.choices and decoded.choices[1]
				and decoded.choices[1].message and decoded.choices[1].message.content

			if not content then
				callback(nil, "no content in response")
				return
			end

			callback(content, nil)
		end
	)
end

return M
