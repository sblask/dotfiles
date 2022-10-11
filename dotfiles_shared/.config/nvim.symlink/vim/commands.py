# pylint: disable=import-outside-toplevel

# https://jvanz.com/hacking-your-vim-with-python.html
def apply_on_one_line_selection(function):
    import vim  # pylint: disable=import-error

    # https://pynvim.readthedocs.io/en/latest/_modules/pynvim/api/buffer.html
    buffer_object = vim.current.buffer
    start_line, start_character = buffer_object.mark("<")
    _end_line, end_character = buffer_object.mark(">")

    range_object = buffer_object.range(start_line, start_line + 1)
    input_line = range_object[0]

    input_string = input_line[start_character : end_character + 1]
    output_string = function(input_string)

    output_line = "".join(
        [
            input_line[0:start_character],
            output_string,
            input_line[end_character + 1 :],
        ]
    )

    buffer_object[start_line - 1] = output_line


def sort_comma_separated(input_string):
    return ",".join(sorted(input_string.split(",")))


def sort_whitespace_separated(input_string):
    return " ".join(sorted(input_string.split(" ")))


def base64_encode():
    import base64

    import vim  # pylint: disable=import-error

    input_string = "\n".join(vim.current.buffer[:])

    input_bytes = input_string.encode("utf8")
    base64_bytes = base64.b64encode(input_bytes)
    base64_string = base64_bytes.decode("utf8")

    vim.current.buffer[:] = [base64_string]


BASE64URL_TO_BASE64 = {
    ord("-"): "+",
    ord("_"): "/",
}


def base64_decode():
    import base64

    import vim  # pylint: disable=import-error

    base64url_string = "".join(vim.current.buffer[:])

    # sometimes padding is stripped away in base64url
    padding = "=" * (4 - len(base64url_string) % 4)
    base64_string = base64url_string.translate(BASE64URL_TO_BASE64) + padding
    output_bytes = base64.b64decode(base64_string)
    output_string = output_bytes.decode("utf8")

    vim.current.buffer[:] = output_string.splitlines()


def dict_to_json():
    # some import are used by eval
    # pylint: disable=unused-import
    import datetime
    import json
    import sys

    import vim  # pylint: disable=import-error
    from dateutil.tz import tzlocal, tzutc

    as_dict = eval("".join(vim.current.buffer[:]))  # pylint: disable=eval-used
    as_json = json.dumps(
        as_dict, default=lambda something: something.isoformat()
    )
    vim.current.buffer[:] = [as_json]
