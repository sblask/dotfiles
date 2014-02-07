#!/usr/bin/env python
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


def main():
    '''
    Go through all files and directories in this directory and create symlinks
    in home directory (plus relative path if necessary) for everything that
    ends with SYMLINK_EXTENSION or DOTFILE_EXTENSION.
    '''
    for relative_path, directories, files in os.walk(BASE_DIRECTORY):
        if SYMLINK_EXTENSION in relative_path or \
           DOTFILE_EXTENSION in relative_path:
            # has been handled earlier
            continue
        for thing in directories + files:
            file_name, file_extension = os.path.splitext(thing)
            if file_extension == SYMLINK_EXTENSION:
                create_link(relative_path, file_name, thing)
            if file_extension == DOTFILE_EXTENSION:
                create_link(relative_path, '.' + file_name, thing)


if __name__ == '__main__':
    main()

