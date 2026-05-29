local hooks = {
    ["https://github.com/junegunn/fzf"] = function(path)
        print("Install fzf")
        vim.system({ path .. "/install", "--all" }):wait()
    end,

    ["https://github.com/nvim-treesitter/nvim-treesitter"] = function()
        vim.schedule(function()
            vim.cmd.packadd("nvim-treesitter") -- TSUpdate is not available without this
            vim.cmd.TSUpdate()
        end)
    end,
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(args)
        local data = args.data
        if not data or (data.kind ~= "install" and data.kind ~= "update") then
            return
        end
        local hook = hooks[data.spec.src]
        if hook then
            hook(data.path)
        end
    end,
})

vim.pack.add({
    "https://github.com/AndrewRadev/inline_edit.vim",
    "https://github.com/AndrewRadev/linediff.vim",
    "https://github.com/chriskempson/base16-vim",
    "https://github.com/gbprod/none-ls-shellcheck.nvim",
    "https://github.com/junegunn/fzf",
    "https://github.com/junegunn/fzf.vim",
    "https://github.com/mg979/vim-visual-multi",
    "https://github.com/michaeljsmith/vim-indent-object",
    "https://github.com/mileszs/ack.vim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-lua/plenary.nvim", -- for none-ls
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/nvimtools/none-ls-extras.nvim",
    "https://github.com/nvimtools/none-ls.nvim",
    "https://github.com/pearofducks/ansible-vim",
    "https://github.com/powerman/vim-plugin-AnsiEsc",
    "https://github.com/shumphrey/fugitive-gitlab.vim",
    "https://github.com/tmux-plugins/vim-tmux",
    "https://github.com/tpope/vim-eunuch",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-repeat",
    "https://github.com/tpope/vim-rhubarb",
    "https://github.com/tpope/vim-surround",
    "https://github.com/vim-airline/vim-airline",
    "https://github.com/vim-airline/vim-airline-themes",
    "https://github.com/wsdjeg/vim-fetch",
})

local function pack_clean()
    for _, plugin in ipairs(vim.pack.get()) do
        if not plugin.active then
            vim.pack.del({ plugin.spec.name })
        end
    end
end

vim.api.nvim_create_autocmd("VimEnter", { callback = pack_clean })
