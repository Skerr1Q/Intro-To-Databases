import cx_Oracle
import csv

username = 'TESTDB'
password = 'oracle'
database = 'localhost/xe'

connection = cx_Oracle.connect(username, password, database)
cur = connection.cursor()

tables = ['Regions', 'Artists', 'Tracks', 'Popularity']

for table in tables:

    with open("{}.csv".format(table), 'w', newline="") as f:

        data_query = "SELECT * FROM {}".format(table)
        cur.execute(data_query)

        write_csv = csv.writer(f, delimiter = ',')
        row = cur.fetchall()

        for r in list(row):
            write_csv.writerow(r)


cur.close()
connection.close()