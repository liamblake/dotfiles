"""Helper functions for Ultisnips. Many of these are taken from
https://github.com/honza/vim-snippets

"""

import re

import vim


def complete(tab, opts):
    """
    get options that match with tab
    :param tab: query string
    :param opts: list that needs to be completed
    :return: a string that match with tab
    """
    el = [x for x in tab]
    pat = "".join(list(map(lambda x: x + "\w*" if re.match("\w", x) else x, el)))
    try:
        opts = [x for x in opts if re.search(pat, x, re.IGNORECASE)]
    except:
        opts = [x for x in opts if x.startswith(tab)]
    if not len(opts) or str.lower(tab) in list(map(str.lower, opts)):
        return ""
    cads = "|".join(opts[:5])
    if len(opts) > 5:
        cads += "|..."
    return "({0})".format(cads)


# Tests for the existence of a variable declared by Vim's filetype detection
# suggesting the type of shell script of the current file
def test_shell(scope, shell):
    return vim.eval("exists('" + scope + ":is_" + shell + "')")


# Loops over the possible variables, checking for global variables
# first since they indicate an override by the user.
def get_shell():
    for scope in ["g", "b"]:
        for shell in ["bash", "sh", "zsh"]:
            if test_shell(scope, shell) == "1":
                if shell == "kornshell":
                    return "ksh"
                if shell == "posix":
                    return "sh"
                return shell
    return "sh"
