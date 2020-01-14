#!/bin/bash

mkdir -p ~/.tags

ctags --extra=f -f ~/.tags/python$(python -c "from distutils import sysconfig; print(sysconfig.get_python_version())") -R $(python -c "import os; import site; package_directories = []; package_directories.append(os.path.dirname(os.__file__)); package_directories.extend(site.getsitepackages()); print(' '.join(package_directories))")

