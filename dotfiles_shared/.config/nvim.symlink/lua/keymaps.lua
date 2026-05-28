local function lnext_wrap()
  local ok = pcall(vim.cmd.lnext)
  if not ok then
    vim.cmd.lfirst()
  end
end

local function lprev_wrap()
  local ok = pcall(vim.cmd.lprev)
  if not ok then
    vim.cmd.llast()
  end
end

vim.keymap.set('n', ']l', lnext_wrap)
vim.keymap.set('n', '[l', lprev_wrap)
