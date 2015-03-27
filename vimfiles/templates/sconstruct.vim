import os

env = Environment(

    #Set up environment variables that will be available.
    ENV = {
        # 'PATH': os.environ['PATH'],
        # 'TEMP' : os.environ.get('TEMP', os.environ.get('TMPDIR', './temp')),
        # 'TMP' : os.environ.get('TMP', os.environ.get('TMPDIR', './temp')),
    },

    #Which scons tools to load.
    tools = [
        'default',

        # 'gcc',
        # 'gnulink',
    ],

)
env.Append(CCFLAGS = [
    # '-Wall',
    # '-g',
    # '-Wextra',
])

