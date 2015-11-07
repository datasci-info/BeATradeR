#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, subprocess
import argparse

def path(ps):
    return os.path.abspath(ps)

parser = argparse.ArgumentParser()
parser.add_argument('-p', '--path', dest = 'path', type = path, help = "path to the directory where the files rely in.", default = ".")
parser.add_argument('-f', '--from', dest = 'from_encode', help = "from encoding", default = 'big5')
parser.add_argument('-t', '--to', dest = 'to_encode', help = "to encoding", default = 'utf8')
parser.add_argument('-e', '--ext', dest = 'ext', help = 'target extension', default = 'R')

def main(args):
    dir_path = args.path
    from_encode = args.from_encode
    to_encode = args.to_encode
    ext = args.ext
    subprocess.call("mkdir -p {}_{}".format(dir_path, to_encode), shell = True)

    for current_dir, dirs, fnames in os.walk(dir_path):
        for fname in fnames:
            if fname.endswith("." + ext):
                fpath = os.path.join(current_dir, fname)
                base_name, _ = os.path.splitext(os.path.basename(fname))
                subprocess.call("iconv -f {} -t {} {} > temp.txt".format(from_encode, to_encode, fpath), shell = True)
                subprocess.call("cat temp.txt > {cd}_{to}/{bn}_{to}.{ext}".format(cd = current_dir,
                                                                                 to = to_encode,
                                                                                 bn = base_name,
                                                                                 ext = ext), shell = True)
                subprocess.call("rm temp.txt", shell = True)

if __name__ == "__main__":
    args = parser.parse_args()
    main(args)
