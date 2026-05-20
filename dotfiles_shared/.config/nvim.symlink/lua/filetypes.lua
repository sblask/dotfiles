vim.filetype.add({
    extension = {
        jinja = "jinja",
        jsm = "javascript",
        sls = "yaml",
        template = "json",
    },
    filename = {
        [".ansible-lint"] = "yaml",
        [".common_env.symlink"] = "sh",
        [".gitconfig.symlink"] = "gitconfig",
        [".pylintrc"] = "dosini",
        [".pylintrc.symlink"] = "dosini",
        [".tmux.conf.symlink"] = "tmux",
        [vim.fn.expand("~/.aws/config")] = "dosini",
    },
    pattern = {
        [".*/ansible/.*"] = "ansible",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "css ",
        "html",
        "make",
        "sh  ",
        "yaml",
        "zsh ",
    },
    callback = function()
        vim.opt_local.iskeyword:append("-")
    end,
})
