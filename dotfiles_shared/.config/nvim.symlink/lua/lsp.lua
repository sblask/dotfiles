local diagnostic_format = function(diagnostic)
    return diagnostic.source
        .. ": "
        .. diagnostic.message
        .. " ["
        .. (diagnostic.code or "none")
        .. "/"
        .. (diagnostic.message_id or "none")
        .. "]"
end

vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
    virtual_lines = false,
    float = {
        format = diagnostic_format,
        suffix = "",
    },
})

local open_float = function()
    vim.diagnostic.open_float({ scope = "cursor" })
end

local toggle_virtual_lines = function()
    local config = {
        current_line = false,
        format = diagnostic_format,
    }
    local virtual_lines_disabled = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({
        virtual_lines = virtual_lines_disabled and config or false,
    })
end

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
    vim.keymap.set('n', "<leader>e",  open_float, opts)
    vim.keymap.set("n", "<leader>l",  toggle_virtual_lines, opts)
    vim.keymap.set('n', "[d",         vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', "]d",         vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', "<leader>f",  vim.lsp.buf.format, opts)
    vim.keymap.set('v', "<leader>ca", vim.lsp.buf.code_action, opts)
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
local lspconfig = require("lspconfig")

lspconfig["jsonls"].setup({})

lspconfig["pylsp"].setup({
    cmd_env = {
        VIRTUAL_ENV = ".venv",
    },
    on_attach = function(_client, buffer)
        setup_format_on_save(buffer)
    end,
})

local function organize_typescript_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = "",
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig["ts_ls"].setup({
    on_attach = function(client, buffer)
        local function goto_source_definition()
            local position_params = vim.lsp.util.make_position_params(0, "utf-8")
            client:exec_cmd({
                command = "_typescript.goToSourceDefinition",
                arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
            })
        end
        local opts = { buffer = buffer }
        vim.keymap.set("n", "<leader>ds", goto_source_definition, opts)
        -- disable formatting so prettier/null-ls can do it
        client.server_capabilities.documentFormattingProvider = false
    end,
    commands = {
        OrganizeImports = {
            organize_typescript_imports,
        },
    },
    handlers = {
        ["workspace/executeCommand"] = function(_err, result, ctx, _config)
            if ctx.params.command ~= "_typescript.goToSourceDefinition" then
                return
            end
            if result == nil or #result == 0 then
                return
            end
            vim.lsp.util.show_document(result[1], "utf-8")
        end,
    },
    init_options = {
        preferences = {
            disableSuggestions = true,
        },
    },
})

lspconfig["terraformls"].setup({
    on_attach = function(client, _buffer)
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
local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")

local FORMATTING = null_ls.methods.FORMATTING

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

local escape_lua_pattern = function(s)
    return (s:gsub("([%%%^%$%(%)%.%[%]%*%+%-%?])", "%%%1"))
end

local find_project_file = function(filename)
    local startpath = vim.api.nvim_buf_get_name(0) or vim.loop.cwd()
    local root_dir = lspconfig.util.root_pattern(filename)(startpath)
    if root_dir ~= nil then
        return root_dir .. "/" .. filename
    end
end

local no_pyproject_toml_or_has_line = function(required_line)
    local wrapped = function(_utils)
        local pyproject_toml = find_project_file("pyproject.toml")
        if not pyproject_toml then
            return true
        end

        for line in io.lines(pyproject_toml) do
            if line:match(escape_lua_pattern(required_line)) then
                return true
            end
        end
        return false
    end
    return wrapped
end

local null_ls_sources = {
    fixjson,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.markdownlint.with({
        condition = function(utils)
            return utils.root_has_file(".markdownlintrc")
        end,
    }),
    null_ls.builtins.diagnostics.mypy.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        prefer_local = ".venv/bin",
    }),
    null_ls.builtins.diagnostics.pylint.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        prefer_local = ".venv/bin",
    }),
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.diagnostics.trivy,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.black.with({
        condition = no_pyproject_toml_or_has_line("[tool.black]"),
    }),
    null_ls.builtins.formatting.isort.with({
        condition = no_pyproject_toml_or_has_line("[tool.black]"),
    }),
    null_ls.builtins.formatting.packer,
    null_ls.builtins.formatting.prettier.with({
        condition = function(_utils)
            return find_project_file(".prettierrc.*")
        end,
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
    require("none-ls-shellcheck.diagnostics"),
    require("none-ls.diagnostics.eslint").with({
        condition = function(_utils)
            return find_project_file("eslint.config.js")
        end,
    }),
    require("none-ls.diagnostics.flake8").with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        condition = function(utils)
            return utils.root_has_file(".flake8")
        end,
    }),
}

null_ls.setup({
    debug = false,
    on_attach = function(_client, buffer)
        setup_format_on_save(buffer)
        vim.api.nvim_buf_set_option(buffer, "formatexpr", "")
    end,
    should_attach = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if
            vim.fn.filereadable(fname) == 0 -- checks cannot be run when file does not exist
            or fname:match("/.venv/") -- do not check other people's code and prevent `".venv/lib/python3.13/site-packages/mypy_extensions.py" shadows library module "mypy_extensions"` error
            or fname:match("/lib/python") -- do not check files from standard library
            or fname:match("/node_modules/") -- do not check other people's code
            or fname:match("^fugitive://") --  do not check fugitive buffer
            or fname:match("git%-blob") -- do not check git difftool buffer (path contains "git-blob", - has to be escaped with %)
        then
            return false
        end
        return true
    end,
    sources = null_ls_sources,
    default_timeout = 10000,
})
