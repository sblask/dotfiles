-- maximus does not handle undecoration on window creation correctly and
-- maximizes too many things, so use devilspie for undecoration and rely on
-- windows remembering their maximized state (there are exceptions where this
-- does not work)
-- Use `maxmius --no-maximize` so that it handles decoration/undecoration on
-- unmaximize/maximize

-- Use --debug to get debug printing
debug_print("")
debug_print("Application: " .. get_application_name())
debug_print("Window Name: " .. get_window_name());
debug_print("Window Type: " .. get_window_type());
debug_print("Maximized: " .. tostring(get_window_is_maximized()));
debug_print("Maximized Vertically: " .. tostring(get_window_is_maximized_vertically()));
debug_print("Maximized Horizontally: " .. tostring(get_window_is_maximized_horizontally()));

-- Handle the above mentioned exceptions
if (get_window_type() == "WINDOW_TYPE_NORMAL") then
    if (
        get_application_name() == "VLC media player" or
        get_application_name() == "xterm" or
        get_application_name() == "update-manager" or
        false
    ) then
        unmaximize(); -- make sure maximize works, sometimes it doesn't
        maximize();
        undecorate_window();
    end
end

if (get_window_is_maximized_horizontally() and get_window_is_maximized_vertically()) then
    undecorate_window();
end
