vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
    desc = "Show LSP Info",
})

local function open_lsp_log(_)
    local state_path = vim.fn.stdpath("state")
    local log_path = vim.fs.joinpath(state_path, "lsp.log")

    vim.cmd(string.format("edit %s", log_path))
end

vim.api.nvim_create_user_command("LspLog", open_lsp_log, {
    desc = "Show LSP log",
})
