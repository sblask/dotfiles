debug_print("")
debug_print("Application: " .. get_application_name())
debug_print("Window Name: " .. get_window_name());
debug_print("Window Type: " .. get_window_type());

if (get_application_name() == "Document Viewer" and get_window_type() == "WINDOW_TYPE_NORMAL") then
    maximize();
    undecorate_window();
end

if (get_application_name() == "Firefox" and get_window_type() == "WINDOW_TYPE_NORMAL") then
    maximize();
    undecorate_window();
end

if (get_application_name() == "Meld" and get_window_type() == "WINDOW_TYPE_NORMAL") then
    maximize();
    undecorate_window();
end

if (get_application_name() == "xterm" and get_window_type() == "WINDOW_TYPE_NORMAL") then
    maximize();
    undecorate_window();
end
