#!/usr/bin/env python
import argparse
import os
import shutil
import sys

COPY_EXTENSION = '.copy'
DOTFILE_EXTENSION = '.dotfile'
SYMLINK_EXTENSION = '.symlink'

BASE_DIRECTORY = os.path.abspath(os.path.dirname(__file__))
HOME_DIRECTORY = os.path.abspath(os.path.expanduser('~'))


def is_wrong_link(from_path, to_path):
    # need abspath as string comparison on paths including ./ fails otherwise
    from_path = os.path.abspath(from_path)
    to_path = os.path.abspath(to_path)
    if os.path.islink(from_path):
        link_target = os.path.realpath(from_path)
        if link_target != to_path:
            message = 'Link `%s` exists, but points to `%s`, not `%s`' % \
                      (from_path, link_target, to_path)
            sys.stderr.write(message + '\n')
        return True


def has_error(relative_path, path_to_be_written):
    if os.path.isfile(path_to_be_written):
        sys.stderr.write('File `%s` exists\n' % path_to_be_written)
        return True
    if os.path.isdir(path_to_be_written):
        sys.stderr.write('Directory `%s` exists\n' % path_to_be_written)
        return True
    subdirectory = os.path.abspath(os.path.join(HOME_DIRECTORY, relative_path))
    if not os.path.isdir(subdirectory):
        sys.stderr.write('Directory `%s` does not exist\n' % subdirectory)
        return True
    return False


def maybe_remove(path, arguments):
    if arguments.replace_existing:
        if os.path.isfile(path) or os.path.islink(path):
            os.remove(path)
        elif os.path.isdir(path):
            shutil.rmtree(path)


def create_link(relative_path, from_file_name, to_file_name, arguments):
    from_path = os.path.join(HOME_DIRECTORY, relative_path, from_file_name)
    to_path = os.path.join(BASE_DIRECTORY, relative_path, to_file_name)
    maybe_remove(from_path, arguments)
    if not is_wrong_link(from_path, to_path) and \
       not has_error(relative_path, from_path):
        os.symlink(to_path, from_path)


def copy(relative_path, source_file_name, target_file_name, arguments):
    source_path = os.path.join(BASE_DIRECTORY, relative_path, source_file_name)
    target_path = os.path.join(HOME_DIRECTORY, relative_path, target_file_name)
    maybe_remove(target_path, arguments)
    if not has_error(relative_path, target_path):
        if os.path.isdir(source_path):
            shutil.copytree(source_path, target_path)
        else:
            shutil.copy(source_path, target_path)


def get_link_file_name(file_name, file_extension):
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
    Go through all files and directories in this directory, create symlinks in
    home directory (plus relative path if necessary) for everything that ends
    with SYMLINK_EXTENSION or DOTFILE_EXTENSION and copy everything that ends
    with COPY_EXTENSION.
    '''
    arguments = get_arguments()
    for root, directories, files in os.walk(BASE_DIRECTORY):
        relative_path = os.path.relpath(root, BASE_DIRECTORY)
        if SYMLINK_EXTENSION in relative_path or \
           DOTFILE_EXTENSION in relative_path or \
           COPY_EXTENSION in relative_path:
            # has been handled earlier (don't support nesting)
            continue
        if '.git' in relative_path:
            continue
        for thing in directories + files:
            file_name, file_extension = os.path.splitext(thing)
            if file_extension in (DOTFILE_EXTENSION, SYMLINK_EXTENSION):
                link_file_name = get_link_file_name(file_name, file_extension)
                create_link(relative_path, link_file_name, thing, arguments)
            elif file_extension == COPY_EXTENSION:
                copy(relative_path, thing, file_name, arguments)


if __name__ == '__main__':
    main()
