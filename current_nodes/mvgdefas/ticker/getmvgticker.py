import feedparser
import json
import io
import os

feed = feedparser.parse("http://www.mvg-mobil.de/Tickerrss/CreateRssClass")

BASEDIR = os.path.dirname(os.path.realpath(__file__))

jsonfeed = []

for item in feed['items']:
  if item['description']:
    jsonfeed.append(item['title'].replace(" ... [weiter]", "") + ": " + item['description'])
  else:
    jsonfeed.append(item['title'])

with io.open(BASEDIR + '/mvgticker.json', 'w', encoding='utf-8') as f:
  f.write(unicode(json.dumps(jsonfeed, ensure_ascii=False)))
