-- ~/.config/nvim/lua/lsp_config.lua

-- 1. Initialize Mason & the bridge (this stays the same)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "bashls", "lua_ls" }
})

-- 2. Define your shared attach function (this stays the same)
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Docs", buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
    -- Add any other mappings here
end

-- 3. THE FIX: Use the new native Neovim 0.12 config system
-- Instead of require('lspconfig').pyright.setup(...)
vim.lsp.config('pyright', {
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
})

-- Configure Bash
vim.lsp.config('bashls', {
    on_attach = on_attach,
    filetypes = { "sh", "bash" }
})

-- Configure Lua
vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (Neovim uses LuaJIT)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognise the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomised but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Tell Neovim to actually start it
vim.lsp.enable('pyright')
vim.lsp.enable('bashls')
vim.lsp.enable('lua_ls')
