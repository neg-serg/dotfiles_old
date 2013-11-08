#!/usr/bin/env python

import sys
import os
from lxml import etree

def fix_fontconfig(xml):
    root = xml.getroot()
    for test in root.findall('.//test'):
        p = test.getparent()
        for child in test:
            test_new = etree.Element('test', attrib=test.attrib)
            test_new.append(child)
            p.append(test_new)
        p.remove(test)
    return xml

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: ./fix.py /etc/fonts/infinality/conf.src')
        sys.exit(0)

    parser = etree.XMLParser(remove_blank_text=True, remove_comments=True)

    for fname in os.listdir(sys.argv[1]):
        fname = os.path.join(sys.argv[1], fname)
        if fname.endswith('.conf'):
            fixed = fix_fontconfig(etree.parse(fname, parser))
            with open(fname, 'w') as f:
                f.write(etree.tostring(fixed, pretty_print=True).decode())
            print('fixed '+fname)
