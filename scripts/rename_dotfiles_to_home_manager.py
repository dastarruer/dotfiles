#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def replace_outside_quotes(text):
    out = []
    i = 0
    n = len(text)
    in_single = False
    in_double = False
    while i < n:
        ch = text[i]
        if ch == "'" and not in_double:
            out.append(ch)
            in_single = not in_single
            i += 1
            continue
        if ch == '"' and not in_single:
            out.append(ch)
            in_double = not in_double
            i += 1
            continue
        if in_single or in_double:
            out.append(ch)
            i += 1
            continue
        # outside quotes: attempt replacements
        if text.startswith('config.dotfiles', i):
            out.append('config.home-manager')
            i += len('config.dotfiles')
            continue
        # Replace dotfiles. -> home-manager. but avoid changing paths like '/.dotfiles' or '~/.'
        if text.startswith('dotfiles.', i):
            prev = text[i-1] if i-1 >= 0 else ''
            if prev not in ('/', '~'):
                out.append('home-manager.')
                i += len('dotfiles.')
                continue
        # also replace occurrences of 'config.dotfiles' even if inside strings in a later pass
        out.append(ch)
        i += 1
    return ''.join(out)

def process_file(p: Path):
    text = p.read_text(encoding='utf-8')
    if 'dotfiles' not in text:
        return False
    new = replace_outside_quotes(text)
    # Second pass: replace any remaining 'config.dotfiles' occurrences (including inside interpolation)
    new = new.replace('config.dotfiles', 'config.home-manager')
    # Replace dotfiles. occurrences that are not part of a path (avoid '/.dotfiles' and '~/')
    new = re.sub(r'(?<![~/])\bdotfiles\.', 'home-manager.', new)
    if new != text:
        p.write_text(new, encoding='utf-8')
        print(f'Updated {p}')
        return True
    return False

def main():
    nix_files = list((ROOT / 'modules' / 'home-manager').rglob('*.nix'))
    changed = 0
    for p in nix_files:
        try:
            if process_file(p):
                changed += 1
        except Exception as e:
            print(f'Error processing {p}: {e}')
    print(f'Done. Files changed: {changed}')

if __name__ == '__main__':
    main()
