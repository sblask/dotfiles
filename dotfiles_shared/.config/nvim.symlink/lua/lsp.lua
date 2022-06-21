-- See https://github.com/neovim/nvim-lspconfig#keybindings-and-completion

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>D',   '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>d',   '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>h',   '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>i',   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>s',   '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa',  '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr',  '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl',  '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>t',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>rf',  '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e',   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d',          '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',          '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q',   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f',   '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local servers = {
    'pylsp',
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp['terraformls'].setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function(startpath)
    return vim.fn.getcwd()
  end
}

--
-- Send diagnostics to ALE
-- adapted from: https://github.com/nathanmsmith/nvim-ale-diagnostic
--
local ale_diagnostic_severity_map = {
  [vim.lsp.protocol.DiagnosticSeverity.Error] = "E";
  [vim.lsp.protocol.DiagnosticSeverity.Warning] = "W";
  [vim.lsp.protocol.DiagnosticSeverity.Information] = "I";
  [vim.lsp.protocol.DiagnosticSeverity.Hint] = "I";
}

vim.lsp.diagnostic.original_clear = vim.lsp.diagnostic.clear
vim.lsp.diagnostic.clear = function(bufnr, client_id, diagnostic_ns, sign_ns)
  vim.lsp.diagnostic.original_clear(bufnr, client_id, diagnostic_ns, sign_ns)
  -- Clear ALE
  vim.api.nvim_call_function('ale#other_source#ShowResults', {bufnr, "nvim-lsp", {}})
end

local function set_signs(bufnr)
    -- Get all diagnostics from the current buffer
    local diagnostics = vim.diagnostic.get(bufnr)
    local items = {}

    for _, item in ipairs(diagnostics) do
        local nr = ''
        if item.user_data and item.user_data.lsp and item.user_data.lsp.code then
            nr = item.user_data.lsp.code
        end
        table.insert(items, {
            nr = nr,
            text = item.message,
            lnum = item.lnum+1,
            end_lnum = item.end_lnum,
            col = item.col,
            end_col = item.end_col,
            type = ale_diagnostic_severity_map[item.severity],
        })
    end

    vim.api.nvim_call_function('ale#other_source#ShowResults', {bufnr, "nvim-lsp", items})
end

function vim.diagnostic.show(namespace, bufnr, ...)
    set_signs(bufnr)
end

-- configure how errors are displayed - ALE will take care of it, so disable everything
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = false,
        virtual_text = false,
        signs = false,
        update_in_insert = false,
    }
)
