
# Kalenderscraper
# c007, 02.06.14

import os
import datetime
import urllib2
from bs4 import BeautifulSoup
import json

DayL = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']

now = datetime.datetime.now()

soup = BeautifulSoup(urllib2.urlopen('http://wiki.muc.ccc.de/kalender').read())
rows = soup.find("table").find_all('tr')

dates = []
for row in rows:
    try:
        data = row.find_all("td")

        d_date  = data[0].get_text().strip(' ')
        d_day   = d_date.split('.')[0]
        d_month = d_date.split('.')[1]
        d_time  = data[1].get_text().strip(' ')
        d_name  = data[2].get_text().strip(' ')

        dates.append( (d_day, d_month, d_time, d_name) )


    except:
        pass


for date in dates:
    testdate = datetime.datetime.strptime(date[0] + "." + date[1] + "." + str(now.year), "%d.%m.%Y")
    
    if testdate > now:   
        jsonstring = json.dumps({'date': date[0] + "." + date[1] + ".", \
                                 'time': date[2], \
                                 'weekday': DayL[testdate.weekday()], \
                                 'name': date[3]})

        path = os.path.dirname(os.path.realpath(__file__))
        fhandle = open(path + '/nextevent.json', "w+")
        print >> fhandle, jsonstring
        break