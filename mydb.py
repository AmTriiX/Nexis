import mysql.connector

dataBase = mysql.connector.connect(
    host = '<your_host>',
    user = '<your_username>',
    passwd = '<your_password>',
)

DATABASE_NAME = '<your_db_name>'

cursorObject = dataBase.cursor()

cursorObject.execute(f"CREATE DATABASE {DATABASE_NAME}")

print("All done")
