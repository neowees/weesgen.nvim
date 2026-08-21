
### INSTALL:

```sh
echo 'export MAMMOUTH_API_KEY="your-key-here"' >> ~/.bashrc
source ~/.bashrc
:lua print(vim.inspect(os.getenv("MAMMOUTH_API_KEY")))
```

#### CONFIG (init.lua - Neovim)

```lua
vim.pack.add({ "https://github.com/neowees/weesgen.nvim" })
require("weesgen").setup({
    model = "mammouth-recommended",
})
```
#### USAGE INSIDE ANY FILE
weesgen: write sample function (<leader>wg)

* Currently working only with Mammouth API
(https://info.mammouth.ai/docs/api-quick-start/)