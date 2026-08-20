
### INSTALL:

```sh
echo 'export MAMMOUTH_API_KEY="your-key-here"' >> ~/.bashrc
source ~/.bashrc

:lua print(vim.inspect(os.getenv("MAMMOUTH_API_KEY")))

mkdir -p ~/.local/share/nvim/site/pack/dev/opt
ln -s ~/__Project/weesgen.nvim ~/.local/share/nvim/site/pack/dev/opt/weesgen.nvim
```

#### Then in your init.lua:

```txt
-- ============================================================
-- SECTION 8.5: WEESGEN (local dev plugin, unmanaged by vim.pack)
-- Inline code generation via Mammouth API
-- ============================================================
do
	vim.cmd.packadd("weesgen.nvim")
	require("weesgen").setup({
		model = "mammouth-recommended",
	})
end
```
#### USAGE INSIDE FILE
weesgen: write sample function
