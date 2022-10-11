from distutils.core import setup

setup(
    name="python-package-name",
    version="0.1",
    author="Author Name",
    author_email="author@something.com",
    description="Short description",
    packages=[
        "package_directory",
        "package_directory.sub_package_directory",
    ],
    install_requires=[
        "dependency==X.Y.Z",
    ],
    entry_points={
        "console_scripts": [
            "name=path:function",
        ]
    },
)
