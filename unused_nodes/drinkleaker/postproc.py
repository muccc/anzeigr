#!/usr/bin/env python

import sys
import json

rows = json.load(sys.stdin)['rows']
drinks = map(lambda x: (x['key'][1], x['value']), rows)

drinks_sums = {}
for (drink_name, value) in drinks:
    if drink_name in drinks_sums:
        drinks_sums[drink_name] += value
    else:
        drinks_sums[drink_name] = value

print json.dumps(drinks_sums.items())
