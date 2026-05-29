local python = vim.fn.expand("~/.opt/pynvim/bin/python")

if vim.fn.executable(python) == 1 then
    vim.g.python3_host_prog = python
end

local config_dir = "~/.config/nvim/"

-- Load plugins first as other configs require parts of them
vim.cmd.source(config_dir .. "vim/plugins.lua")
vim.cmd.source(config_dir .. "vim/plugins.vim")

local vim_files = vim.fn.glob(config_dir .. "/vim/*.vim", true, true)
for _, fpath in ipairs(vim_files) do
    if not fpath:match("/plugins%.vim$") then
        vim.cmd.source(fpath)
    end
end

local lua_files = vim.fn.glob(config_dir .. "lua/*.lua", true, true)
for _, fpath in ipairs(lua_files) do
    if not fpath:match("/plugins%.lua$") then
        local module = vim.fs.basename(fpath):gsub("%.lua$", "")
        require(module)
    end
end

local function update_spellfile(add_file)
    local spl_file = add_file .. ".spl"

    if
        vim.fn.filereadable(spl_file) == 0
        or vim.fn.getftime(add_file) > vim.fn.getftime(spl_file)
    then
        vim.cmd("silent! mkspell! " .. vim.fn.fnameescape(add_file))
    end
end

for _, add_file in ipairs(vim.fn.glob(config_dir .. "/spell/*.add", true, true)) do
    update_spellfile(add_file)
end

require("vim._core.ui2").enable({})
