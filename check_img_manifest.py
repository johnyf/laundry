#!/usr/bin/env python
"""Report `img/*.pdf` files not generated from SVG."""
import os

import git


IMG_DIR = 'img/'


def print_untracked_pdf_files():
    img_path = IMG_DIR
    repo = git.Repo()
    tracked_files = repo.git.ls_files(img_path).splitlines()
    for fname in pdf_files(img_path):
        base, _ = os.path.splitext(fname)
        svg_fname = os.path.join(img_path, base + '.svg')
        if os.path.isfile(svg_fname):
            continue
        # PDF `fname` isn't generated from any SVG file
        path = os.path.join(img_path, fname)
        if path in tracked_files:
            continue
        # untracked PDF not generated from SVG
        print((
            'The untracked PDF file "{f}" is not '
            'generated from any SVG.').format(
                f=fname))


def pdf_files(path):
    for fname in os.listdir(path):
        _, ext = os.path.splitext(fname)
        if ext != '.pdf':
            continue
        yield fname


if __name__ == '__main__':
    print_untracked_pdf_files()
