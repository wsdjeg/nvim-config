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

-- 参考 https://juejin.cn/post/7361684907809947658
-- https://www.sohu.com/a/273248325_100206743

vim.keymap.set('n', '<F10>', '<cmd>RecordScreen -speaker<Cr>', { silent = true })
vim.keymap.set('n', '<F12>', '<cmd>RecordScreen stop<Cr>', { silent = true })

vim.api.nvim_create_user_command('RecordScreen', function(opt)
    local enable_microphone = false
    local enable_camera = false
    local enable_speaker = false
    for _, v in ipairs(opt.fargs) do
        if v == '-microphone' then
            enable_microphone = true
        elseif v == '-camera' then
            enable_camera = true
        elseif v == '-speaker' then
            enable_speaker = true
        elseif v == 'stop' then
            require('record-screen').stop()
            return
        end
    end
    if not enable_camera and not enable_microphone and not enable_speaker then
        require('record-screen').setup({
            command = 'ffmpeg',
            argvs = { '-f', 'gdigrab', '-i', 'desktop', '-pix_fmt', 'yuv420p', '-f', 'mp4' },
        })
    elseif enable_speaker and not enable_camera and not enable_microphone then
        require('record-screen').setup({
            cmd = 'ffmpeg',
            argvs = {
                '-f',
                'dshow',
                '-i',
                'audio=立体声混音 (Realtek(R) Audio)',
                '-f',
                'gdigrab',
                '-itsoffset',
                '0.8',
                '-i',
                'desktop',
                '-pix_fmt',
                'yuv420p',
                '-f',
                'mp4',
            },
        })
    elseif enable_microphone and not enable_camera and not enable_speaker then
        require('record-screen').setup({
            cmd = 'ffmpeg',
            argvs = {
                '-f',
                'dshow',
                '-i',
                'audio=麦克风阵列 (Realtek(R) Audio)',
                '-f',
                'gdigrab',
                '-draw_mouse',
                '1',
                '-itsoffset',
                '1',
                '-i',
                'desktop',
                '-pix_fmt',
                'yuv420p',
                '-f',
                'mp4',
            },
        })
    elseif enable_microphone and enable_speaker and not enable_camera then
        require('record-screen').setup({
            cmd = 'ffmpeg',
            argvs = {
                '-rtbufsize',
                '1500M',
                '-f',
                'dshow',
                '-i',
                'audio=麦克风阵列 (Realtek(R) Audio)',
                '-f',
                'dshow',
                '-i',
                'audio=立体声混音 (Realtek(R) Audio)',
                '-filter_complex',
                'amix=inputs=2:duration=first:dropout_transition=2',
                '-f',
                'gdigrab',
                '-r',
                '60',
                '-draw_mouse',
                '1',
                '-itsoffset',
                '0.8',
                '-i',
                'desktop',
                '-pix_fmt',
                'yuv420p',
                '-f',
                'mp4',
            },
        })
    elseif enable_microphone and enable_camera and not enable_speaker then
        require('record-screen').setup({
            cmd = 'ffmpeg',
            argvs = {
                '-f',
                'gdigrab',
                '-r',
                '60',
                '-draw_mouse',
                '1',
                '-offset_x',
                '0',
                '-offset_y',
                '0', -- '-video_size', '2560x1440',
                '-i',
                'desktop',
                '-f',
                'dshow',
                '-i',
                'audio=麦克风阵列 (Realtek(R) Audio)',
                '-f',
                'dshow',
                '-s',
                '640x360',
                '-i',
                'video=Integrated Camera',
                '-filter_complex',
                'overlay=W-w-1:H-h-1',
                '-pix_fmt',
                'yuv420p',
                '-f',
                'mp4',
            },
        })
    elseif enable_microphone and enable_camera and enable_speaker then
        require('record-screen').setup({
            cmd = 'ffmpeg',
            argvs = {
                '-f',
                'dshow',
                '-rtbufsize',
                '15M',
                '-itsoffset',
                '-7',
                '-i',
                'audio=麦克风阵列 (Realtek(R) Audio)',
                '-f',
                'dshow',
                '-rtbufsize',
                '15M',
                '-itsoffset',
                '-9',
                '-i',
                'audio=virtual-audio-capturer',
                '-filter_complex',
                'amix=inputs=2:duration=first',
                '-f',
                'gdigrab',
                '-r',
                '30',
                '-draw_mouse',
                '1',
                '-offset_x',
                '0',
                '-offset_y',
                '0', -- '-video_size', '2560x1440',
                '-rtbufsize',
                '15M',
                '-i',
                'desktop',
                '-f',
                'dshow',
                '-r',
                '30',
                '-s',
                '640x360',
                '-rtbufsize',
                '100M',
                '-i',
                'video=Integrated Camera',
                '-filter_complex',
                'overlay=W-w-1:H-h-1',
                '-preset',
                'ultrafast',
                '-pix_fmt',
                'yuv420p',
                '-f',
                'mp4',
            },
        })
    end
    require('record-screen').start()
end, {
    nargs = '*',
    complete = function(...)
        return { '-microphone', '-camera', '-speaker' }
    end,
})
