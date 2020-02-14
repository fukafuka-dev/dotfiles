#! /usr/bin/env python

import sys
import subprocess
import argparse
from pathlib import Path

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("name", nargs="?")
    parser.add_argument("--config", nargs="?", const=False)
    parser.add_argument("-g", "--grep")
    return parser.parse_args()

def default_memo_dir():
    return Path.home().joinpath("doc/memo")

def memo_dir(current_path):
    return Path(current_path)

def agrep(word, work_dir):
    subprocess.call(["ag", word, work_dir])

def make_dir(work_dir):
    subprocess.call(["mkdir", "-p", work_dir])

def open_memo(filename):
    subprocess.call(["vim", filename])

def select_file_with_fzf(work_dir):
    proc = subprocess.run(f"ls {work_dir} | fzf --preview \"head -100 {work_dir}/{{}}\"", shell=True, stdout=subprocess.PIPE)
    return proc.stdout.decode("utf8").rstrip('\n')

def main():
    args = parse_args()

    if args.config == False:
        print(default_memo_dir())
        sys.exit()

    work_dir = memo_dir(args.config) if args.config else default_memo_dir()

    if args.grep:
        agrep(args.grep, work_dir)
        sys.exit()

    if args.name:
        make_dir(work_dir)
        open_memo(f"{str(work_dir.joinpath(args.name))}.txt")
    elif work_dir.is_dir():
        filename = select_file_with_fzf(work_dir)
        if filename:
            open_memo(f"{work_dir}/{filename}")

if __name__ == '__main__':
    main()
