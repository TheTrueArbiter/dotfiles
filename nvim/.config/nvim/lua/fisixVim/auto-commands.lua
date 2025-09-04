-- Setup our JDTLS server any time we open up a java file
print("auto commands file called(does not confirm working, just called)")
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require('fisixVim.jdtls').setup_jdtls()
    augroup end
]]
