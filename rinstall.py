#!/usr/bin/env python
"""Re-install package in current directory."""
import os

import pip


def reinstall():
    """Reinstall the package under the current directory."""
    path = os.getcwd()
    dirname = os.path.basename(path)
    print('reinstall the package: {p}'.format(p=dirname))
    cmd = ['uninstall', '-y', dirname]
    pip.main(cmd)
    cmd = ['install', '.']
    pip.main(cmd)


if __name__ == '__main__':
    reinstall()
