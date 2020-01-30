def apply_on_one_line_selection(function):
    # pylint: disable=import-error,import-outside-toplevel
    import vim

    # https://pynvim.readthedocs.io/en/latest/_modules/pynvim/api/buffer.html
    buffer_object = vim.current.buffer
    start_line, start_character = buffer_object.mark("<")
    _end_line, end_character = buffer_object.mark(">")

    range_object = buffer_object.range(start_line, start_line + 1)
    input_line = range_object[0]

    input_string = input_line[start_character : end_character + 1]
    output_string = function(input_string)

    output_line = (
        input_line[0:start_character]
        + output_string
        + input_line[end_character + 1 :]
    )

    buffer_object[start_line - 1] = output_line


def sort_comma_separated(input_string):
    return ",".join(sorted(input_string.split(",")))
