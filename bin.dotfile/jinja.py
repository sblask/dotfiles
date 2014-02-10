#!/usr/bin/env python
'''
Script to quickly test a jinja template:

./jinja.py template_file --key_one value_one --key_two value_two

'''
import jinja2
import json
import sys


def from_json(thing):
    try:
        return json.loads(thing)
    except Exception:
        return json.loads('["%s"]' % thing)[0]


def main():
    file_name = sys.argv[1]
    arguments = sys.argv[2:]
    if len(arguments) % 2 != 0:
        raise Exception("Wrong number of arguments")
    if arguments:
        context_variables = {
            arguments[index][2:]: from_json(arguments[index + 1])
            for index in range(0, len(arguments) / 2 + 1, 2)
            if (arguments[index].startswith('--') and
                not arguments[index + 1].startswith('--'))
        }
    else:
        context_variables = {}
    print 'Context used: `%s`' % context_variables
    with open(file_name) as file_object:
        print 'Result:'
        print jinja2.Template(file_object.read()).render(**context_variables)


if __name__ == '__main__':
    main()

