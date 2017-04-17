#! /usr/bin/env python
# vim: set fileencoding=utf-8: set encoding=utf-8:

import vim
import re
import subprocess
import time

_RE_CMD = re.compile(r'^(?P<bang>!)?>\s*(?P<cmd>\S+)\s*(?P<argstr>.*)')

_OUTPUT_LEADER = '    '
_META_LEADER = '** '
_ERROR_LEADER = '!! '


def findCommandLine(curr_line = None):
    """
    Finds a command line. If you're in an output block, finds the connected command line.
    If you're on a command line, finds itself. Otherwise, returns None.
    """
    if curr_line is None:
        curr_line = vim.current.window.cursor[0]
    curr_line -= 1
    curr_buff = vim.current.buffer
    lastline = len(curr_buff)
    for lineno in reversed(xrange(0, curr_line+1)):
        line = curr_buff[lineno]
        mobj = _RE_CMD.match(line)
        if mobj:
            return lineno+1, mobj.group('cmd'), mobj.group('argstr'), bool(mobj.group('bang'))
        elif line.startswith(_OUTPUT_LEADER) or line.startswith(_META_LEADER) or line.startswith(_ERROR_LEADER):
            pass
        else:
            break

    return None

#TODO: Try to return to same line. If starting line is included in the output, go to it.
def exeCommandLine(curr_line=None):
    """
    Finds the attached command line (using `findCommandLine`) and executes it, replacing
    any output with the new output.
    """
    cl = findCommandLine(curr_line)
    if cl is None:
        print "No command line found."
        return None

    cmdlineno, cmd, argstr, bang = cl[:4]
    clearOutput(cmdlineno+1)

    curr_buf = vim.current.buffer
    stamp = time.time()
    proc = subprocess.Popen(cmd + ' ' + argstr, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    lineno = cmdlineno
    for line in proc.stdout:
        curr_buf.append(_OUTPUT_LEADER + line.rstrip(), lineno)
        lineno += 1

    ret = proc.wait()

    if not bang:
        stamp = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(stamp))
        curr_buf.append(_META_LEADER + stamp, cmdlineno)

    if ret == 0:
        return True

    if not bang:
        curr_buf.append(_ERROR_LEADER + 'Error code: %d' % ret, cmdlineno+1)
    return proc.returncode


def clearOutput(curr_line=None):
    """
    Deletes all output lines in the current block.
    """
    cl = findCommandLine(curr_line)
    if cl is None:
        return

    curr_line = cl[0]
    curr_buff = vim.current.buffer
    lastline = len(curr_buff)
    for lineno in xrange(curr_line, lastline):
        line = curr_buff[lineno]
        if line.startswith(_OUTPUT_LEADER) or line.startswith(_META_LEADER) or line.startswith(_ERROR_LEADER):
            pass
        else:
            end = lineno
            break
    else:
        end = lastline+1

    print "Clear from %d:%d" % (curr_line, end)
    if end > curr_line:
        del curr_buff[curr_line:end]

    vim.current.window.cursor = (curr_line, 0)
            




