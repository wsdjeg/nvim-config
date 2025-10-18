-- what the fuck
--
-- Windows: "E138: main.shada.tmp.X files exist, cannot write ShaDa" on close

vim.api.nvim_create_user_command('RemoveShadaTemp', function(opt)
    local status = 0
    for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('data') .. '/shada', '*tmp*', false, true)) do
        status = status + vim.fn.delete(f)
    end
    if status == 0 then
        vim.print('Successfully deleted all temporary shada files')
    end
end, {})
