return require('bufferline').setup {
    options = {
        mode = 'tabs',
        separator_style = 'thin',
        show_buffer_close_icons = false,
        -- show_close_icon = false,
        show_tab_indicators = true,
        indicator = {
            style = 'icon'
        }
    }
}
