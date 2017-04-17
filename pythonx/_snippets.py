import inspect
import functools
import os.path

try:
    import slugify as python_slugify
    __has_slug = True
except ImportError:
    __has_slug = False

def __wrap_func(snip, f):
    """
    Helper functino for `load`.
    """
    @functools.wraps(f)
    def func(*args, **kwargs):
        return f(snip, *args, **kwargs)
    return func

def load(mod, snip):
    """
    Use like:
    
    >>> import _snippets
    >>> _snippets.load(globals(), snip)

    And optionally, add:
    >>> reload(_snippets)

    in between, in order to get updates to this module with out restarting
    vim.

    And then if you have a function in this module `foo(snip, bar, baz)`, you
    can call it just as `foo(bar, baz)`.
    """
    functions = [__wrap_func(snip, sym) for sym in globals().values() if inspect.isfunction(sym) and not sym.__name__.startswith("_") and sym.__name__ != "load"]
    for f in functions:
        mod[f.__name__] = f
        
def comma(snip, text):
    """
    If the specified text is blank, sets the replace text to blank.
    Otherwise, sets the replace text to a comma and a space.
    """
    if len(text):
        snip.rv = ', '
    else:
        snip.rv = ''

def space(snip, text):
    """
    If the specified text is blank, sets the replace text to blank.
    Otherwise, sets the replace text to a single space.
    """
    if len(text):
        snip.rv = ' '
    else:
        snip.rv = ''

def indent(snip, text=None):
    """
    Given a block of text, indents every line by one level.
    If text is none, uses the current `snip.c` value.
    """
    if text is None:
        text = snip.c
    snip.shift()
    snip.rv = "".join(snip.mkline(line) for line in text.splitlines(True))
    snip.unshift()

def block(snip, text=None):
    """
    Indents a block of text and a line at the end indented to the same
    level, but otherwise empty (useful for puttint `$0` directly after it).

    If `text` is None, uses the text of the VISUAL (i.e., `snip.v.text`).
    """
    if text is None:
        text = snip.v.text
    indent(snip, text)
    snip.shift()
    snip.rv += snip.mkline("")
    snip.unshift()

def slugify(snip, text=None):
    """
    Converts the text to lower-case, removes characters that are not
    alphanumeric, underscores, or dashes. This is NOT a one-to-one unambiguous
    (i.e., reversible) encoding.
    """
    if __has_slug:
        snip.rv = python_slugify.slugify(text)
    else:
        slug = ''
        for c in text.lower():
            if c.isalnum() or c in ('-', '_'):
                slug += c
            elif c.isspace():
                slug += '-'
        snip.rv = slug

def explodepath(path):
    """
    Explodes a path into all of it's parts.
    """
    parts=[]
    (path, tail)=os.path.split( path)
    while path and tail:
         parts.append( tail)
         (path,tail)=os.path.split(path)
    parts.append( os.path.join(path,tail) )
    return map( os.path.normpath, parts)[::-1]

