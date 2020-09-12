from os import getcwd, path


def Settings(**kwargs):
    retval = {}
    retval["disable_signature_help"] = True
    cwd = lookup_path = getcwd()

    while not path.exists(path.join(lookup_path, ".git")):
        lookup_path = path.dirname(lookup_path)

    project_dir = lookup_path if lookup_path != "/" else cwd
    retval["project_directory"] = project_dir

    python_path = f"{project_dir}/.venv/bin/python"

    if path.exists(python_path):
        retval["interpreter_path"] = python_path

    return retval
