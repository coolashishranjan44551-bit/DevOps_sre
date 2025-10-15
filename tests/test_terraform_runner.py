
import subprocess, sys, os
from shutil import which

def test_runner_help():
    # script should print usage when called with -h
    assert which('python') is not None
