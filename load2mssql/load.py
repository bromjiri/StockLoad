import csv
import pyodbc

# cnxn = pyodbc.connect(r'Driver={SQL Server};Server=.\SQLEXPRESS;Database=tempdb;Trusted_Connection=yes;')

cnxn = pyodbc.connect(
    r'Driver={SQL Server};'
    r'Server=.\SQLEXPRESS;'
    r'Database=jiridb;'
    r'UID=jiri;'
    r'PWD=password')

cursor = cnxn.cursor()

cursor.execute("SELECT * FROM persons")
while 1:
    row = cursor.fetchone()
    if not row:
        break
    print(row.FirstName)

cnxn.close()