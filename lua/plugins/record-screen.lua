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

vim.api.nvim_create_user_command('RecordScreen', function(opt)
    local enable_microphone = false
    local enable_camera = false
    local enable_speaker = false
    for _, v in ipairs(opt.fargs) do
        if v == '-audio' then
            enable_microphone = true
        elseif v == '-camera' then
            enable_camera = true
        elseif v == 'stop' then
            require('record-screen').stop()
            return
        end
    end
    if not enable_camera and not enable_microphone then
        require('record-screen').setup({
            command = 'ffmpeg',
            argvs = { '-f', 'gdigrab', '-i', 'desktop', '-pix_fmt', 'yuv420p', '-f', 'mp4' },
        })
    elseif enable_microphone and not enable_camera then
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
    elseif enable_microphone and enable_camera then
        require('record-screen').setup({
            cmd = 'ffmpeg',
            -- 使用 ffmpeg -f dshow -list_devices true -i dummy 获取设备列表
            -- ffmpeg -f gdigrab -i desktop -i audio="麦克风阵列 (Realtek(R) Audio)" -pix_fmt yuv420p -f mp4
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
                'audio=立体声混音 (Realtek(R) Audio)',
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
    end
    require('record-screen').start()
end, {
    nargs = '*',
    complete = function(...)
        return { '-microphone', '-camera', '-speaker' }
    end,
})
