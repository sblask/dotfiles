require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "phpdoc" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gss",
            node_incremental = "gsi",
            node_decremental = "gsd",
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>p"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>P"] = "@parameter.inner",
            },
        },
    },
})

require("treesitter-context").setup({
    enable = true,
    patterns = {
        default = {
            "class",
            "function",
            "method",
        },
        terraform = {
            "block",
        },
    },
    mode = "topline",
})

-- supposedly this can be done with custom_captures under highlight in the
-- treesitter config setup, but I couldn't get it to work
vim.cmd([[highlight def link @text.diff.add DiffAdded]])
vim.cmd([[highlight def link @text.diff.delete DiffRemoved]])
