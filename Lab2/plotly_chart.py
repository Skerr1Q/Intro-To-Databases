import cx_Oracle

import chart_studio
import chart_studio.plotly as py

import plotly.graph_objs as go

import re

import chart_studio.dashboard_objs as dashboard

def fileId_from_url(url):
    url_raw = url.split('/')
    cleared = [s.strip('~') for s in url_raw]
    nickname = cleared[3]
    id = cleared[4]
    fileId = nickname + ':' + id
    return fileId

chart_studio.tools.set_credentials_file(username='Skerr1Q', api_key='zkUhrgeaL7FUPlmY7r23')

username = 'TESTDB'
password = 'oracle'
databaseName = 'localhost/xe'

connection = cx_Oracle.connect(username, password, databaseName)
cursor = connection.cursor()

first_query = \
"""
    SELECT
        SUM(streams) as total_streams,
        region
    FROM
        popularity
    WHERE
        chart_position <= 5
    GROUP BY
        region
    ORDER BY
        SUM(streams)
"""

second_query = """
    SELECT
        popularity.streams,
        (tracks.artist||'-'||tracks.track) as track_name
    FROM
             popularity
        INNER JOIN tracks ON tracks.track_url = popularity.track_url
    WHERE
            popularity.region = 'ec'
        AND popularity.chart_position <= 20
        AND popularity.date_viewed = '01-JAN-17'
    ORDER BY
        popularity.streams DESC
"""

third_query = """
    SELECT
        streams,
        date_viewed
    FROM
        popularity
    WHERE
        track_url = 'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg'
"""
cursor.execute(first_query)
first_query_result = cursor.fetchall()
total_streams = []
region = []
for row in first_query_result:
    total_streams.append(row[0])
    region.append(row[1])

stream_bar = go.Bar(
    y = total_streams,
    x = region
)

stream_by_region = py.plot([stream_bar], filename='stream_bar')

cursor.execute(second_query)
query_tracks = cursor.fetchall()

tracks = []
streams_count = []

for row in query_tracks:
    tracks.append(row[1])
    streams_count.append(row[0])

track_pie = go.Pie(labels=tracks, values=streams_count)
tracks_streams_count = py.plot([track_pie], filename = "track_pie")

cursor.execute(third_query)
stream_by_date = cursor.fetchall()
streams = []
date_viewed = []
 
for row in stream_by_date:
    streams += [row[0]]
    date_viewed += [row[1]]

streams_date_data = go.Scatter(
    x=date_viewed,
    y=streams,
    mode='lines+markers'
)
streams_by_date = py.plot([streams_date_data], filename = "stream_scatter")

dboard = dashboard.Dashboard()

stream_barId = fileId_from_url(stream_by_region)
track_pieId = fileId_from_url(tracks_streams_count)
stream_scatterId = fileId_from_url(streams_by_date)

box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': stream_barId,
    'title': 'Загальна кількість прослуховувань перших 5 позицій чартів у Spotify за 2017-01-01 у різних країнах.'
}
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': track_pieId,
    'title': "Відсоток від загальної кількості прослуховувань у певної пісні у топ 20 за 2017-01-01 у Еквадорі"
}

box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': stream_scatterId,
    'title': "Динаміка прослуховуваня пісні Shakira-Chantaje за перший тиждень січня у Еквадорі",
}

dboard.insert(box_1)
dboard.insert(box_2, 'below', 1)
dboard.insert(box_3, 'left', 2)
py.dashboard_ops.upload(dboard, 'Oracle Dashboard with Python')

cursor.close()
connection.close()