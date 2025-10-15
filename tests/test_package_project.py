
from scripts.package_project import make_zip
import pathlib, os, zipfile, shutil

def test_make_zip_creates_archive(tmp_path, monkeypatch):
    # make a fake repo
    (tmp_path / 'file.txt').write_text('ok')
    (tmp_path / 'scripts').mkdir()
    (tmp_path / 'scripts' / 'package_project.py').write_text('')
    monkeypatch.chdir(tmp_path)
    zip_path = make_zip('dist/test.zip')
    assert pathlib.Path(zip_path).exists()
    with zipfile.ZipFile(zip_path) as z:
        assert 'file.txt' in z.namelist()
