-- what the fuck
--
-- Windows: "E138: main.shada.tmp.X files exist, cannot write ShaDa" on close

vim.api.nvim_create_user_command('RemoveShadaTemp', function(opt)

        for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('data') .. '/shada', '*tmp*', 0, 1)) do
                vim.fn.system({'rm', f})
        end


end, {})
