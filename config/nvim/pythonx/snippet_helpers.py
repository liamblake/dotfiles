"""Helper functions for Ultisnips. Many of these are taken from
https://github.com/honza/vim-snippets

"""

import re


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
