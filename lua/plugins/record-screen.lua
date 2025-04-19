
            require('record-screen').setup({
                cmd = 'ffmpeg',
                -- 使用 ffmpeg -f dshow -list_devices true -i dummy 获取设备列表
                -- ffmpeg -f gdigrab -i desktop -i audio="麦克风阵列 (Realtek(R) Audio)" -pix_fmt yuv420p -f mp4
                argvs = {
                    '-f',
                    'dshow',
                    '-i',
                    'audio=麦克风阵列 (Realtek(R) Audio)',
                    '-f',
                    'gdigrab',
                    '-i',
                    'desktop',
                    '-pix_fmt',
                    'yuv420p',
                    '-f',
                    'mp4',
                },
            })
            vim.keymap.set(
                'n',
                '<F8>',
                '<cmd>lua require("record-screen").start()<cr>',
                { silent = true }
            )
            vim.keymap.set(
                'n',
                '<F9>',
                '<cmd>lua require("record-screen").stop()<cr>',
                { silent = true }
            )
