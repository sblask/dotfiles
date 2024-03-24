<!-- markdownlint-disable-next-line -->
[![Pre-commit Status](https://github.com/sblask/dotfiles/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/sblask/dotfiles/actions/workflows/pre-commit.yml)
[![Ansible Status](https://github.com/sblask/dotfiles/actions/workflows/ansible-test.yml/badge.svg)](https://github.com/sblask/dotfiles/actions/workflows/ansible-test.yml)

My Dotfiles
===========

A collection of configuration files for my terminal environment and Linux
Desktop.

Run tests with `./run_tests.sh`

How to get started on Linux:

- `ansible-playbook --ask-become-pass ansible/ansible-linux.yml`

How to get started on Mac:

- install [brew](https://brew.sh/)
- make sure you have the right architecture in ansible/ansible-mac.yml
- `/usr/local/bin/brew install ansible`
- `/usr/local/bin/ansible-playbook ansible/ansible-mac.yml`

Improving keyboard shortcuts on Mac:

- swap command and function key under:
  Keyboard -> Keyboard Shortcuts -> Modifier Keys
- setup Keyboard -> Keyboard Shortcuts -> App Shortcuts
  - For chrome map `Forward` to `command+I` and `Back` to `command+O`
  - for iterm map `Copy` to `shift+command+C` and `Paste` to `shift+command+V`
- setup iterm Keys to send [hex codes](https://stackoverflow.com/questions/36321230/finding-the-hex-code-sequence-for-a-key-combination):

  - 0x02 -> command-B
  - 0x03 -> command-C
  - 0x04 -> command-D
  - 0x07 -> command-G
  - 0x0a -> command-J
  - 0x0b -> command-K
  - 0x0e -> command-N
  - 0x10 -> command-P
  - 0x12 -> command-R
  - 0x16 -> command-V
  - 0x17 -> command-W
  - 0x1a -> command-Z
