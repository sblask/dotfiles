require("ansible").setup()
require("nvim-treesitter").setup({})
require("nvim-treesitter").install({
    "bash",
    "c",
    "cpp",
    "css",
    "diff",
    "go",
    "html",
    "javascript",
    "jinja",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "terraform",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "ansible",
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "go",
        "html",
        "javascript",
        "jinja",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "terraform",
        "typescript",
        "typescriptreact",
        "vim",
        "yaml",
        "yaml.ansible",
    },
    callback = function()
        vim.treesitter.start()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "typescript",
        "typescriptreact",
    },
    callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        selection_modes = {
            ["@class.outer"] = "V",
            ["@class.inner"] = "V",
            ["@function.outer"] = "V",
            ["@function.inner"] = "V",
            ["@parameter.outer"] = "v",
            ["@parameter.inner"] = "v",
        },
        include_surrounding_whitespace = true,
    },
})

local textobjects_select = require("nvim-treesitter-textobjects.select")
local function select_textobject(query_string)
    return function()
        textobjects_select.select_textobject(query_string, "textobjects")
    end
end
vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"))
vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"))
vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"))
vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"))
vim.keymap.set({ "x", "o" }, "aa", select_textobject("@parameter.outer"))
vim.keymap.set({ "x", "o" }, "ia", select_textobject("@parameter.inner"))

local textobjects_swap = require("nvim-treesitter-textobjects.swap")
local function swap(direction)
    return function()
        textobjects_swap["swap_" .. direction]("@parameter.inner")
    end
end
vim.keymap.set("n", "<leader>p", swap("next"))
vim.keymap.set("n", "<leader>P", swap("previous"))

require("treesitter-context").setup({
    enable = true,
    mode = "topline",
})

vim.api.nvim_set_hl(0, "@text.diff.add", { link = "DiffAdded" })
vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "DiffRemoved" })
