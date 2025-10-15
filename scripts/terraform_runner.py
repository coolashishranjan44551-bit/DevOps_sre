
"""Tiny Terraform runner to standardize commands."""
import argparse, subprocess, sys, os

def run(cmd, cwd=None):
    print("$", " ".join(cmd))
    p = subprocess.run(cmd, cwd=cwd)
    return p.returncode

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--dir', required=True, help='Working dir (aws/terraform or azure/terraform)')
    ap.add_argument('action', choices=['fmt','init','validate','plan','apply'])
    ap.add_argument('--var-file', help='Path to tfvars/yaml var-file for plan/apply')
    ap.add_argument('--auto-approve', action='store_true')
    args = ap.parse_args()

    if args.action == 'fmt':
        return run(['terraform','fmt','-recursive'], cwd=args.dir)
    if args.action == 'init':
        return run(['terraform','init','-input=false'], cwd=args.dir)
    if args.action == 'validate':
        return run(['terraform','validate'], cwd=args.dir)

    if args.action == 'plan':
        cmd = ['terraform','plan','-input=false']
        if args.var_file: cmd += ['-var-file', args.var_file]
        return run(cmd, cwd=args.dir)

    if args.action == 'apply':
        cmd = ['terraform','apply','-input=false']
        if args.auto_approve: cmd += ['-auto-approve']
        if args.var_file: cmd += ['-var-file', args.var_file]
        return run(cmd, cwd=args.dir)

if __name__ == '__main__':
    sys.exit(main())
