#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Ville Korhonen <ville@xd.fi>

import os
import sys

TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Directory listing for %(dir)s</title>
    <style>
        body {
            font-family: Helvetica, Arial, sans-serif;
        }
        .dir a {
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>Directory listing for %(dir)s</h1>
<ul>
%(content)s
</ul>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-420043-36', 'auto');
  ga('send', 'pageview');

</script>
</body>
</html>
<!-- Generated using https://github.com/ypcs/repository/blob/master/dirlist.py -->
"""


def main(args):
    path = args.path
    if not os.path.exists(path):
        print "Path not found: %s" % path
        return 1
    
    for root, dirs, files in os.walk(path):
        outfile = '%s/index.html' % root
        content = ""
        for d in dirs:
            content += '<li class="dir"><a href="%s/index.html">%s</a></li>' % (d, d)
        for f in files:
            if f == 'index.html' or f.startswith('.'):
                continue
            fs = os.path.getsize(os.path.join(root, f)) / 1024
            
            content += '<li class="file"><a href="%s">%s</a> (%d kbytes)</li>' % (f, f, fs)
        
        src = TEMPLATE % {
            'dir': os.path.basename(root),
            'content': content,
        }
        with open(outfile, 'w') as ofile:
            ofile.write(src)
        print "Wrote dir %s to file %s." % (root, outfile)

    return 0

def run():
    from argparse import ArgumentParser
    parser = ArgumentParser()
    parser.add_argument('path')
    args = parser.parse_args()
    sys.exit(main(args))

if __name__ == "__main__":
    run()
