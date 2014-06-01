import socket, datetime, io

now = datetime.datetime.now()

since_midnight = (
    now - 
    now.replace(hour=0, minute=0, second=0)
).seconds


with io.open('time.json', 'w', encoding='utf-8') as f:
   f.write(unicode(since_midnight))
   f.close()