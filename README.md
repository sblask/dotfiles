<!-- markdownlint-disable-next-line -->
[![Pre-commit Status](https://github.com/sblask/dotfiles/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/sblask/dotfiles/actions/workflows/pre-commit.yml)
[![Ansible Status](https://github.com/sblask/dotfiles/actions/workflows/ansible-test.yml/badge.svg)](https://github.com/sblask/dotfiles/actions/workflows/ansible-test.yml)

My Dotfiles
===========

A collection of configuration files for my terminal environment and Linux
Desktop.

Run tests with `./run_tests.sh`

How to get started on Linux
---------------------------

- `ansible-playbook --ask-become-pass ansible/ansible-linux.yml`

How to get started on Mac
-------------------------

- export PATH=/opt/homebrew/bin/:$HOME/.bin/$HOME/.asdf/shims::$PATH
- install [brew](https://brew.sh/)
- make sure you have the right architecture in ansible/ansible-mac.yml (either
  amd64 or  arm64)
- `/usr/local/bin/brew install ansible`
- `/usr/local/bin/brew install gnu-tar`
- `/usr/local/bin/ansible-playbook ansible/ansible-mac.yml`

Improving keyboard shortcuts on Mac
-----------------------------------

- swap command and function key under:
  Keyboard -> Keyboard Shortcuts -> Modifier Keys
- configure Show Desktop shortcut under:
  Keyboard -> Keyboard Shortcuts -> Mission Control
- setup Keyboard -> Keyboard Shortcuts -> App Shortcuts
  - For chrome map `Forward` to `command+I` and `Back` to `command+O`
  - for iterm map `Copy` to `shift+command+C` and `Paste` to `shift+command+V`
- setup iterm Keys (Settings -> Keys) to send [hex
  codes](https://stackoverflow.com/questions/36321230/finding-the-hex-code-sequence-for-a-key-combination)
  to be able to use Command combinations instead of control combinations for more
  likeness to PC:

  - 0x01 -> command-B
  - 0x02 -> command-B
  - 0x03 -> command-C
  - 0x04 -> command-D
  - 0x05 -> command-E
  - 0x06 -> command-F
  - 0x07 -> command-G
  - 0x08 -> command-H
  - 0x09 -> command-I
  - 0x0a -> command-J
  - 0x0b -> command-K
  - 0x0c -> command-L
  - 0x0d -> command-M
  - 0x0e -> command-N
  - 0x0f -> command-O
  - 0x10 -> command-P
  - 0x11 -> command-Q
  - 0x12 -> command-R
  - 0x13 -> command-S
  - 0x14 -> command-T
  - 0x15 -> command-U
  - 0x16 -> command-V
  - 0x17 -> command-W
  - 0x18 -> command-X
  - 0x19 -> command-Y
  - 0x1a -> command-Z

The corresponding preset looks like this:

```json
{
    "Key Mappings":{
        "0x61-0x100000-0x0":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x01","Escaping":2},
        "0x62-0x100000-0xb":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x02","Escaping":2},
        "0x63-0x100000-0x8":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x03","Escaping":2},
        "0x64-0x100000-0x2":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x04","Escaping":2},
        "0x65-0x100000-0xe":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x05","Escaping":2},
        "0x66-0x100000-0x3":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x06","Escaping":2},
        "0x67-0x100000-0x5":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x07","Escaping":2},
        "0x68-0x100000-0x4":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x08","Escaping":2},
        "0x69-0x100000-0x22":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x09","Escaping":2},
        "0x6a-0x100000-0x26":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x0a","Escaping":2},
        "0x6b-0x100000-0x28":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x0b","Escaping":2},
        "0x6c-0x100000-0x25":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x0c","Escaping":2},
        "0x6d-0x100000-0x2e":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x0d","Escaping":2},
        "0x6e-0x100000-0x2d":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x0e","Escaping":2},
        "0x6f-0x100000-0x1f":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x0f","Escaping":2},
        "0x70-0x100000-0x23":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x10","Escaping":2},
        "0x71-0x100000-0xc":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x11","Escaping":2},
        "0x72-0x100000-0xf":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x12","Escaping":2},
        "0x73-0x100000-0x1":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x13","Escaping":2},
        "0x74-0x100000-0x11":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x14","Escaping":2},
        "0x75-0x100000-0x20":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x15","Escaping":2},
        "0x76-0x100000-0x9":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x16","Escaping":2},
        "0x77-0x100000-0xd":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x17","Escaping":2},
        "0x78-0x100000-0x7":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x18","Escaping":2},
        "0x79-0x100000-0x10":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x19","Escaping":2},
        "0x7a-0x100000-0x6":{"Version":2,"Apply Mode":0,"Action":11,"Text":"0x1a","Escaping":2}
    },
    "Touch Bar Items":{}
}

```
