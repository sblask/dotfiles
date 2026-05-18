vim.filetype.add({
    extension = {
        jinja = "jinja",
        jsm = "javascript",
        sls = "yaml",
        template = "json",
        ["tf.j2"] = "terraform",
    },
    filename = {
        [".ansible-lint"] = "yaml",
        [".common_env.symlink"] = "sh",
        [".gitconfig.symlink"] = "gitconfig",
        [".pylintrc"] = "dosini",
        [".pylintrc.symlink"] = "dosini",
        [".tmux.conf.symlink"] = "tmux",
    },
    pattern = {
        [".*/%.aws/config"] = "dosini",
        [".*/ansible/.*"] = "ansible",
        ["~/%.aws/config"] = "dosini",
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
