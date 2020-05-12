import cx_Oracle
import csv

username = 'TESTDB'
password = 'oracle'
database = 'localhost/xe'

connection = cx_Oracle.connect(username, password, database)
cur = connection.cursor()
file_name = "C:\\Users\\Vlad Kostenko\\Desktop\Folders\\Labs\\IntroDatabase\\Lab3\\data.csv"

regions_query = \
    '''INSERT INTO Regions ( region )
        VALUES ( :region )'''

artists_query = \
    '''INSERT INTO Artists ( artist )
        VALUES ( :artist )'''

tracks_query = \
    '''INSERT INTO Tracks ( track_url, track, artist )
        VALUES ( :track_url, :track, :artist )'''

popularity_query = \
    '''INSERT INTO Popularity ( track_url, date_viewed, region, chart_position, streams )
        VALUES (:track_url, TO_DATE(:date_viewed, 'YYYY-MM-DD') , :region, :chart_position, :streams)'''

with open(file_name, 'r', encoding='utf-8') as csv_file:
    reader = csv.reader(csv_file)
    for f in list(reader)[1:20]:

        chart_position = f[0].encode("cp1251", "replace").decode("cp1251", "ignore").strip()
        track = f[1].encode("cp1251", "replace").decode("cp1251", "ignore").strip()
        artist = f[2].encode("cp1251", "replace").decode("cp1251", "ignore").strip()
        streams = f[3].encode("cp1251", "replace").decode("cp1251", "ignore").strip()
        track_url = f[4].encode("cp1251", "replace").decode("cp1251", "ignore").strip()
        date_viewed = f[5].encode("cp1251", "replace").decode("cp1251", "ignore").strip()
        region = f[6].encode("cp1251", "replace").decode("cp1251", "ignore").strip()

        try:
            cur.execute(regions_query, region=region)
        except cx_Oracle.IntegrityError:
            pass

        try:
            cur.execute(artists_query, artist=artist)
        except cx_Oracle.IntegrityError:
            pass

        try:
            cur.execute(tracks_query, track_url=track_url, track=track, artist=artist)
        except cx_Oracle.IntegrityError:
            pass

        try:
            cur.execute(popularity_query, track_url=track_url, date_viewed=date_viewed,
                        region=region, chart_position=int(chart_position),
                        streams=int(streams))
        except cx_Oracle.IntegrityError:
            pass

connection.commit()
cur.close()
connection.close()
