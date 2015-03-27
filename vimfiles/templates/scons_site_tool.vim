"""
File: `!p snip.rv = snip.fn`

The ${1:`!p snip.rv = snip.basename`} site-tool for Scons.

"""
import SCons
from SCons.Script import *
from SCons.Builder import *

def generate(env, **kw):
    """
    Add the $1 tool to the environment.
    """

    #Make sure it exists, and its path is stored in the $2 construction variable.

    #Add construction variables for the tool.
    env.SetDefault(${4:$2}_OPTS = ${5:'${6}'})


    ### The ${7:Foo} Builder

    #Add construction variables for the $7 builder
    env.SetDefault(${8:`!p snip.rv = t[4] + '_' + t[7].upper()`}_OPTS = '\$$4_OPTS')
    env.SetDefault($8_COM = '${9:\$$2 \$$8_OPTS $SOURCES > $TARGET}')

    #Add the builder
    env.Append(BUILDERS = {
        '${10:$1$7}' : Builder(
            action='$8_COM',
            suffix='${11:.output}',
            src_suffix='${12:.input}',
        )
    })

    $0

def find_program(env, varname, command_names):
    """
    Look for a program on the system path, and set the specified construction
    variable to its path.

    If the env var is already set, we assume that the user has set it to the
    name or location of the command they want to use for this program, and only
    try to resolve that. Otherwise, we will try to resolve any given in the
    `command_names` parameter.

    If the program is found, then the construction variable is set
    (if not already set) with the path to the program and the function returns
    True. Otherwise, we return False.

    :param env: The environment to update

    :param str varname: The name of the variable name at which the program
        will be stored.

    :param sequence command_names: A sequence of strings giving possible names
        of the program to search for. These are searched in order, and we
        choose the first one we find.
    """
    if varname in env:
        programs = [env.subst('$' + varname)]
    else:
        programs = command_names

    program = None
    for p in programs:
        program = env.WhereIs(p)
        if program:
            break

    if program is None:
        return False

    env.SetDefault(varname = program)
    return True


def exists(env)
    """
    Checks to see if this tool can exist on the current system.
    """
    return find_program(env, '${2:`!p snip.rv = t[1].upper()`}', ['${3:`!p snip.rv = t[2].lower()`}`,])

