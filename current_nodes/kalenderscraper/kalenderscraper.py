# -*- coding: utf-8 -*-
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
        d_public= data[3].get_text().strip(' ')
        d_anzahl= data[4].get_text().strip(' ')
        d_keyholder = data[5].get_text().strip(' ')

        dates.append( (d_day, d_month, d_time, d_name, \
            d_public, d_anzahl, d_keyholder) )

    except:
        pass


for date in dates:
    testdate = datetime.datetime.strptime(date[0] + "." + date[1] + "." + \
                str(now.year) + " " + date[2], "%d.%m.%Y %H:%M")    

    if testdate > now:   
        eventname = date[3].replace(u'ü', 'ue').replace(u'ä','ae').replace(u'ö','oe')
        jsonstring = json.dumps({'date': date[0] + "." + date[1] + ".", \
                                 'time': date[2], \
                                 'weekday': DayL[testdate.weekday()], \
                                 'name': eventname, \
                                 'public': date[4]})

        path = os.path.dirname(os.path.realpath(__file__))
        fhandle = open(path + '/nextevent.json', "w+")
        print >> fhandle, jsonstring
        fhandle.close()
        break