import datetime
import sqlite3
import subprocess

who = subprocess.check_output("who") 
users = set([x.split()[0] for x in who.splitlines()])

print(users)

con = sqlite3.connect('logins.db')
cur = con.cursor()

cur.execute('''CREATE TABLE IF NOT EXISTS logins
                (date text, user text, minutes integer)''')

today = datetime.date.today().strftime('%Y-%m-%d')
existing_login_rows = cur.execute('SELECT * FROM logins WHERE date = ?', (today,))
db_logins = { row[1]: row[2] for row in existing_login_rows }

for user in users:
    if (user) in db_logins:
        cur.execute('''UPDATE logins SET minutes = minutes + 1
                        WHERE date = ? AND user = ?''', (today, user))
    else:
        cur.execute('''INSERT INTO logins (date, user, minutes)
                        VALUES (?, ?, 1)''', (today, user))

con.commit()



