#-*- coding: UTF-8 -*-
import commands
import io
import json

stations = {}
stations['Sandstraße'] = {"default_transports": ["tram"]}
stations['Josephsplatz'] = {"default_transports": ["u"]}
stations['Görresstraße'] = {"default_transports": ["bus"]}

alldepartures = []
departures = []
for station in stations:
  with io.open('.mvg', 'w', encoding='utf-8') as f:
    f.write(unicode(json.dumps(stations[station], ensure_ascii=False)))
  alldepartures.append(json.loads(commands.getoutput('mvg_json ' + station)))

commands.getoutput('rm .mvg')

collected = 0
currentdeparture = 0
while collected < 9:
  for departureset in alldepartures:
    for departure in departureset['result_display']:
      if departure['minutes'] == currentdeparture:
        departures.append(departure)
        collected += 1
  currentdeparture += 1

with io.open('departures.json', 'w', encoding='utf-8') as f:
   f.write(unicode(json.dumps(departures, ensure_ascii=False)))

