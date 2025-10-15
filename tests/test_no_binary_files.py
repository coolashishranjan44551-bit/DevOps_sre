
import os, pathlib

def test_no_binary_files():
    root = pathlib.Path('.')
    banned_ext = {'.exe', '.dll', '.bin'}
    for p in root.rglob('*'):
        if p.is_file() and p.suffix.lower() in banned_ext:
            raise AssertionError(f"Binary file not allowed: {p}")
