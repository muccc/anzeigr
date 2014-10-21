#-*- coding: UTF-8 -*-
import io
import os
import json
import MVGLive
import sys

stations = []
stations.append('Sandstraße')
stations.append('Theresienstraße')
stations.append('Görresstraße')

BASEDIR = os.path.dirname(os.path.realpath(__file__))

alldepartures = []
departures = []
maxdepartures = 0
for station in stations:
  departuredata = MVGLive.getlivedata(station)
  if len(departuredata) > 0:
    alldepartures.append(departuredata)
    maxdepartures += len(departuredata)

if maxdepartures > 9:
  maxdepartures = 9

collected = 0
currentdeparture = 0
while collected < maxdepartures:
  for departureset in alldepartures:
    for departure in departureset:
      if departure['time'] == currentdeparture:
        departures.append(departure)
        collected += 1
  currentdeparture += 1

for departure in departures:
  os.system('wget -nc -O ' + BASEDIR + '/' + departure['linesymbol'] + ' ' + departure['linesymbolurl'] + '; if [ $? -eq 0 ]; then convert ' + BASEDIR + '/' + departure['linesymbol'] + ' ' + BASEDIR + '/' + departure['linesymbol'] + '.png; fi')
  os.system('wget -nc -O ' + BASEDIR + '/' + departure['productsymbol'] + ' ' + departure['productsymbolurl'] + '; if [ $? -eq 0 ]; then convert ' + BASEDIR + '/' + departure['productsymbol'] + ' ' + BASEDIR + '/' + departure['productsymbol'] + '.png; fi')

with io.open(BASEDIR + '/departures.json', 'w', encoding='utf-8') as f:
   f.write(unicode(json.dumps(departures, ensure_ascii=False)))

