from os import getcwd, path


def Settings(**kwargs):
    retval = {}

    cwd = getcwd()
    python_path = f'{cwd}/.venv/bin/python'

    if path.exists(python_path):
        retval["interpreter_path"] = python_path

    return retval
