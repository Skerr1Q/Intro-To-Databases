import cx_Oracle

username = 'TESTDB'
password = 'oracle'
databaseName = 'localhost/xe'

connection = cx_Oracle.connect(username, password, databaseName)
cursor = connection.cursor()

'''
Запит 1 - Загальна кількість прослуховувань перших 5 позицій чартів у Spotify за 2017-01-01 у різних країнах. Країна - число
Візуалізація – стовпчикова діаграма.
'''

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

'''
Запит 2 - Відсоток від загальної кількості прослуховувань у певної пісні у топ 20 за 2017-01-01 у Еквадорі
Візуалізація – секторна діаграма.
'''

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

'''
Запит 3 - Динаміка прослуховуваня пісні Shakira-Chantaje за перший тиждень січня у Еквадорі (дані лише з топ 5 чартів)
Візуалізація – графік залежності.
'''

third_query = """
    SELECT
        streams,
        date_viewed
    FROM
        popularity
    WHERE
        track_url = 'https://open.spotify.com/track/6mICuAdrwEjh6Y6lroV2Kg'
"""

cursor = connection.cursor()

# Рeзультати першого запиту (список множин)

cursor.execute(first_query)

result_streams = cursor.fetchall()

print('''Запит 1 - Загальна кількість прослуховувань перших 5 позицій чартів у Spotify за 2017-01-01 у різних країнах. Країна - число
Візуалізація – стовпчикова діаграма.''')
print("\n{:<50} | {}".format('total_streams', 'popularity'))
print("{:-^51}|{:-^12}".format('-', '-'))
for row in result_streams:
    print("{:<50} | {}".format(*row))

# Рeзультати другого запиту

cursor.execute(second_query)

result_percentage = cursor.fetchall()

print("\n")
print('''Запит 2 - Відсоток від загальної кількості прослуховувань у певної пісні у топ 20 за 2017-01-01 у Еквадорі
Візуалізація – секторна діаграма.''')
print("\n{:<30} | {}".format('streams', 'track_name', ))
print("{:-^31}|{:-^11}".format('-', '-'))
for row in result_percentage:
    print("{:<30} | {}".format(*row))


# Рeзультати третього запиту

cursor.execute(third_query)

result_dynamic = cursor.fetchall()

print("\n")
print('''Запит 3 - Динаміка прослуховуваня пісні Shakira-Chantaje за перший тиждень січня у Еквадорі (дані лише з топ 5 чартів)
Візуалізація – графік залежності.''')
print("\n{:<16} | {}".format('streams', 'date_viewed'))
print("{:-^17}|{:-^12}".format('-', '-'))
for row in result_dynamic:
    print("{:<16} | {}".format(*row))


# Закрити підключення
cursor.close()
connection.close()
