Menu = require("nui.menu")
Event = require("nui.utils.autocmd").event
Popup = require("nui.popup")
Layout = require("nui.layout")

require("tree")

local Space = {}

local States = {
  file = {
    is_open = false,
    title = "File",
    options = Menu_options.file,
  },

}

function Space.open_files_menu()

end
