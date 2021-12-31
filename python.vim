"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    #execfile(activate_this, dict(__file__=activate_this))
    with open(activate_this) as f:
        exec(f.read(), {'__file__': activate_this})
EOF
