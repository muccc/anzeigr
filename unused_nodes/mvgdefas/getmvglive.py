#-*- coding: UTF-8 -*-
import io
import os
import json
import MVGLive

stations = []
stations.append('Sandstraße')
stations.append('Theresienstraße')
stations.append('Görresstraße')

BASEDIR = os.path.dirname(os.path.realpath(__file__))

alldepartures = []
departures = []
for station in stations:
  alldepartures.append(MVGLive.getlivedata(station))


collected = 0
currentdeparture = 0
while collected < 9:
  for departureset in alldepartures:
    for departure in departureset:
      if departure['time'] == currentdeparture:
        departures.append(departure)
        collected += 1
  currentdeparture += 1


with io.open(BASEDIR + '/departures.json', 'w', encoding='utf-8') as f:
   f.write(unicode(json.dumps(departures, ensure_ascii=False)))

