#!/usr/bin/env python3
import subprocess
import tomllib
import sys


def get_project_version():
    with open("pyproject.toml", "rb") as project:
        meta = tomllib.load(project)
        return meta['tool']['poetry']['version']


def create_github_release():
    version = get_project_version()
    print(f"Creating draft release for version {version}", file=sys.stderr)

    subprocess.check_call([
        "gh", "release",
        "create", f"v{version}",
        "--draft",
        "dist/*"
    ])


if __name__ == "__main__":
    try:
        create_github_release()
    except Exception as e:
        print(f"Could not create release: {e}", file=sys.stderr)
