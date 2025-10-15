
"""Simple packager to zip the repo except common ignores."""
from __future__ import annotations
import os, zipfile, pathlib

EXCLUDES = {'.git', '.venv', '__pycache__', 'dist', 'build', '.terraform'}

def should_skip(path: pathlib.Path) -> bool:
    return any(part in EXCLUDES for part in path.parts)

def make_zip(zip_path: str = 'dist/devops-sre.zip') -> str:
    root = pathlib.Path('.').resolve()
    out = pathlib.Path(zip_path)
    out.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(out, 'w', compression=zipfile.ZIP_DEFLATED) as z:
        for p in root.rglob('*'):
            if p.is_file() and not should_skip(p.relative_to(root)):
                z.write(p, p.relative_to(root).as_posix())
    return str(out)

if __name__ == '__main__':
    print(make_zip())
