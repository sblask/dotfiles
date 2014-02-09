#!/usr/bin/env python
import argparse
import os
import sys

DOTFILE_EXTENSION = '.dotfile'
SYMLINK_EXTENSION = '.symlink'

BASE_DIRECTORY = os.path.dirname(__file__)
HOME_DIRECTORY = os.path.expanduser('~')


def create_link(relative_path, from_file_name, to_file_name):
    from_path = os.path.join(HOME_DIRECTORY, relative_path, from_file_name)
    from_path = os.path.abspath(from_path)
    to_path = os.path.join(BASE_DIRECTORY, relative_path, to_file_name)
    to_path = os.path.abspath(to_path)
    if os.path.islink(from_path):
        link_target = os.path.realpath(from_path)
        if link_target != to_path:
            message = 'Link `%s` exists, but points to `%s`, not `%s`' % \
                      (from_path, link_target, to_path)
            sys.stderr.write(message + '\n')
            return
    if os.path.isfile(from_path):
        sys.stderr.write('File `%s` exists\n' % from_path)
        return
    if os.path.isdir(from_path):
        sys.stderr.write('Directory `%s` exists\n' % from_path)
        return
    directory = os.path.abspath(os.path.join(HOME_DIRECTORY, relative_path))
    if not os.path.isdir(directory):
        sys.stderr.write('Directory `%s`  does not exists\n' % directory)
        return
    os.symlink(to_path, from_path)


def in_bashrc(line):
    with open(os.path.join(HOME_DIRECTORY, '.bashrc')) as file_object:
        if line in file_object.readlines():
            return True


def add_to_bashrc(line):
    with open(os.path.join(HOME_DIRECTORY, '.bashrc'), 'a') as file_object:
        file_object.write('\n' + line + '\n')


def ensure_reference(entry_file):
    inclusion = 'if [ -f ~/%s ]; then . ~/%s; fi\n' % (entry_file, entry_file)
    if not in_bashrc(inclusion):
        add_to_bashrc(inclusion)


def get_entry_file():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'entry_file',
        help='The file in this directory whose link should be referenced in'
             ' .bashrc',
        nargs='?',
        default='bashrc_custom.dotfile',
    )
    arguments = parser.parse_args()
    if not os.path.exists(os.path.join(BASE_DIRECTORY, arguments.entry_file)):
        raise Exception('No entry file given')
    return get_link_file_name(arguments.entry_file)


def get_link_file_name(input_file_name):
    file_name, file_extension = os.path.splitext(input_file_name)
    if file_extension == SYMLINK_EXTENSION:
        return file_name
    if file_extension == DOTFILE_EXTENSION:
        return '.' + file_name


def main():
    '''
    Go through all files and directories in this directory and create symlinks
    in home directory (plus relative path if necessary) for everything that
    ends with SYMLINK_EXTENSION or DOTFILE_EXTENSION.
    Also make sure that given file is referenced in .bashrc
    '''
    entry_file = get_entry_file()
    for relative_path, directories, files in os.walk(BASE_DIRECTORY):
        if SYMLINK_EXTENSION in relative_path or \
           DOTFILE_EXTENSION in relative_path:
            # has been handled earlier
            continue
        for thing in directories + files:
            link_file_name = get_link_file_name(thing)
            if link_file_name:
                create_link(relative_path, link_file_name, thing)
    ensure_reference(entry_file)


if __name__ == '__main__':
    main()

