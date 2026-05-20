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

vim.keymap.set({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aa", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ia", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
end)

vim.keymap.set("n", "<leader>p", function()
    require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end)

vim.keymap.set("n", "<leader>P", function()
    require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end)

require("treesitter-context").setup({
    enable = true,
    mode = "topline",
})

vim.api.nvim_set_hl(0, "@text.diff.add", { link = "DiffAdded" })
vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "DiffRemoved" })
