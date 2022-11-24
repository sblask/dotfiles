vim.diagnostic.config({
    severity_sort = true,
    virtual_text = false,
})

--
-- Change sign column highlighting
--

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
    })
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "ⓘ" })

-- See https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
local map_keys = function(buffer)
    vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }

    -- stylua: ignore start
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>D",  "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>d",  "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>h",  "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>i",  "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>s",  "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>t",  "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>e",  "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "[d",         "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "]d",         "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>q",  "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>f",  "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    -- stylua: ignore end
end

local setup_format_on_save = function(buffer)
    local augroup_name = "lsp-format-on-save" .. buffer
    vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        callback = function()
            vim.lsp.buf.format()
        end,
        group = augroup_name,
    })
end

local setup_location_list_updates = function(buffer)
    local augroup_name = "lsp-location-list-updates" .. buffer
    vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        buffer = buffer,
        callback = function()
            vim.diagnostic.setloclist({ open = false })
        end,
        group = augroup_name,
    })
end

--
-- Configure LSP
--

local servers = {
    "pylsp",
}

local lspconfig = require("lspconfig")
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = function(_client, buffer)
            map_keys(buffer)
            setup_format_on_save(buffer)
            setup_location_list_updates(buffer)
        end,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

lspconfig["terraformls"].setup({
    on_attach = function(client, buffer)
        map_keys(buffer)
        setup_location_list_updates(buffer)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = function(_startpath)
        return vim.fn.getcwd()
    end,
})

--
-- Configure null-ls
--

local null_ls = require("null-ls")
local null_ls_sources = {
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.editorconfig_checker,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.packer,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.trim_newlines,
}

null_ls.setup({
    on_attach = function(_client, buffer)
        map_keys(buffer)
        setup_format_on_save(buffer)
        setup_location_list_updates(buffer)
        vim.api.nvim_buf_set_option(buffer, "formatexpr", "")
    end,
    sources = null_ls_sources,
})
