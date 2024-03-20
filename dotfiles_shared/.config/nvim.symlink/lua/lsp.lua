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


local map_keys = function(buffer)
    local opts = { buffer = buffer }

    -- stylua: ignore start
    vim.keymap.set('n', "<leader>D",  vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', "<leader>d",  vim.lsp.buf.definition, opts)
    vim.keymap.set('n', "<leader>h",  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', "<leader>i",  vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', "<leader>s",  vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', "<leader>t",  vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', "<leader>rf", vim.lsp.buf.references, opts)
    vim.keymap.set('n', "<leader>e",  vim.diagnostic.open_float, opts)
    vim.keymap.set('n', "[d",         vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', "]d",         vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', "<leader>f",  vim.lsp.buf.format, opts)
    -- stylua: ignore end

    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders))
    end, opts)
end

local setup_format_on_save = function(buffer)
    local augroup_name = "lsp-format-on-save-" .. buffer
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
    local augroup_name = "lsp-location-list-updates-" .. buffer
    vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        buffer = buffer,
        callback = function()
            vim.diagnostic.setloclist({ open = false })
        end,
        group = augroup_name,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
        buffer = buffer,
        callback = function()
            vim.diagnostic.setloclist({ open = false })
        end,
        group = augroup_name,
    })
end

-- See https://neovim.io/doc/user/lsp.html#LspAttach
-- and https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach-config", {}),
    callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.server_capabilities.completionProvider then
            vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
        end

        map_keys(buffer)
        setup_location_list_updates(buffer)
    end,
})

--
-- Configure LSP
--

local servers = {
    "jsonls",
    "pylsp",
    "tsserver",
}

local lspconfig = require("lspconfig")
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = function(_client, buffer)
            setup_format_on_save(buffer)
        end,
        },
    })
end

lspconfig["terraformls"].setup({
    on_attach = function(client, buffer)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    root_dir = function(_startpath)
        return vim.fn.getcwd()
    end,
})

lspconfig["tflint"].setup({
    root_dir = lspconfig.util.root_pattern(".git", ".tflint.hcl"),
})

--
-- Configure null-ls
--

local null_ls_helpers = require("null-ls.helpers")
local null_ls_methods = require("null-ls.methods")

local FORMATTING = null_ls_methods.internal.FORMATTING

local fixjson = null_ls_helpers.make_builtin({
    name = "fixjson",
    meta = {
        url = "https://github.com/rhysd/fixjson",
        description = "A JSON file fixer/formatter for humans using (relaxed) JSON5.",
    },
    method = FORMATTING,
    filetypes = { "json" },
    generator_opts = {
        command = "fixjson",
        to_stdin = true,
    },
    factory = null_ls_helpers.formatter_factory,
})

local null_ls = require("null-ls")
local null_ls_sources = {
    fixjson,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.diagnostics.trivy,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.packer,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
    require("none-ls-shellcheck.diagnostics"),
    require("none-ls.diagnostics.eslint"),
}

null_ls.setup({
    debug = false,
    on_attach = function(_client, buffer)
        setup_format_on_save(buffer)
        vim.api.nvim_buf_set_option(buffer, "formatexpr", "")
    end,
    sources = null_ls_sources,
})
