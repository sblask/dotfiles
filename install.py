#!/usr/bin/env python
import argparse
import os
import shutil
import sys

DOTFILE_EXTENSION = '.dotfile'
SYMLINK_EXTENSION = '.symlink'

BASE_DIRECTORY = os.path.abspath(os.path.dirname(__file__))
HOME_DIRECTORY = os.path.abspath(os.path.expanduser('~'))


def has_error(relative_path, from_path, to_path):
    subdirectory = os.path.abspath(os.path.join(HOME_DIRECTORY, relative_path))
    if os.path.islink(from_path):
        link_target = os.path.realpath(from_path)
        if link_target != to_path:
            message = 'Link `%s` exists, but points to `%s`, not `%s`' % \
                      (from_path, link_target, to_path)
            sys.stderr.write(message + '\n')
        return True
    if os.path.isfile(from_path):
        sys.stderr.write('File `%s` exists\n' % from_path)
        return True
    if os.path.isdir(from_path):
        sys.stderr.write('Directory `%s` exists\n' % from_path)
        return True
    if not os.path.isdir(subdirectory):
        sys.stderr.write('Directory `%s`  does not exists\n' % subdirectory)
        return True
    return False


def create_link(relative_path, from_file_name, to_file_name, arguments):
    from_path = os.path.join(HOME_DIRECTORY, relative_path, from_file_name)
    from_path = os.path.abspath(from_path)
    to_path = os.path.join(BASE_DIRECTORY, relative_path, to_file_name)
    to_path = os.path.abspath(to_path)
    if arguments.replace_existing:
        if os.path.isfile(from_path) or os.path.islink(from_path):
            os.remove(from_path)
        elif os.path.isdir(from_path):
            shutil.rmtree(from_path)
    if not has_error(relative_path, from_path, to_path):
        os.symlink(to_path, from_path)


def get_link_file_name(input_file_name):
    file_name, file_extension = os.path.splitext(input_file_name)
    if file_extension == SYMLINK_EXTENSION:
        return file_name
    if file_extension == DOTFILE_EXTENSION:
        return '.' + file_name


def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-r',
        '--replace-existing',
        action='store_true',
        help='Remove target path before creating a link in its place',
    )
    return parser.parse_args()


def main():
    '''
    Go through all files and directories in this directory and create symlinks
    in home directory (plus relative path if necessary) for everything that
    ends with SYMLINK_EXTENSION or DOTFILE_EXTENSION.
    Also make sure that given file is referenced in .bashrc
    '''
    arguments = get_arguments()
    for root, directories, files in os.walk(BASE_DIRECTORY):
        relative_path = os.path.relpath(root, BASE_DIRECTORY)
        if SYMLINK_EXTENSION in relative_path or \
           DOTFILE_EXTENSION in relative_path:
            # has been handled earlier (don't support nesting)
            continue
        if '.git' in relative_path:
            continue
        for thing in directories + files:
            link_file_name = get_link_file_name(thing)
            if link_file_name:
                create_link(relative_path, link_file_name, thing, arguments)


if __name__ == '__main__':
    main()

