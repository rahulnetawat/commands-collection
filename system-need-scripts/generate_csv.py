#!/usr/share/python3

import os
path = os.path.dirname(os.path.realpath(__file__))
files = os.listdir(path)
for f in files:
	f1=f.replace("-","_")
	os.rename(f, f1)
print(os.listdir(path))
root@webdunia-OptiPlex-3010:/home/webdunia/task/nov_db# cat generate_csv.py 
import mysql.connector
import re, os
import pandas as pd
npath = os.path.dirname(os.path.realpath(__file__))

r_dbs=[]
conn = mysql.connector.connect (user='root', password='root', host='localhost', buffered=True)
cursor = conn.cursor()
databases = ("show databases;")
cursor.execute(databases)


for (databases) in cursor:
	if re.search("^ps_342_",databases[0]):
		r_dbs.append(databases[0])	

conn.close()
while True:
	print("1. Show the databases active for given user")
	print("2. Show the list of active/deactive users")
	print("3. Exit")

	opt = int(input("Enter 1-3 for choosing one option: "))

	if(opt == 1):
	
		for db in r_dbs:
			conn = mysql.connector.connect(host="127.0.0.1",user="root",passwd="root",db=db)
			cursor = conn.cursor()
			query = ("SELECT * FROM `ps_employees` WHERE `first_name` LIKE 'Doug' AND `active` = 1 LIMIT 500;")
			cursor.execute(query)	
			if cursor:
				print(db, "Active", cursor)
			else:
				print(db, "Deactive")
	elif(opt == 2):
		active_user = []
		deactive_user = []
		database_name = []
		for db in r_dbs:
			conn = mysql.connector.connect(host="127.0.0.1",user="root",passwd="root",db=db)
			cursor = conn.cursor()
			query = ("SELECT COUNT(*) FROM `ps_employees` WHERE `active` = 1 ;")
			cursor.execute(query)
			for u in cursor:
				active_user.append(u[0])
			query = ("SELECT COUNT(*) FROM `ps_employees` WHERE `active` = 0 ;")
			cursor.execute(query)
			for u in cursor:
                                deactive_user.append(u[0])
			date=db.split("_")
			database_name.append("{}-{}-{}".format(date[4],date[3],date[2]))
		df = pd.DataFrame({"DataBase Name": database_name, "User Active " : active_user, "User Deactive" : deactive_user})
		df.to_csv('Data.csv', index = False)	

	elif(opt == 3):
		exit()
