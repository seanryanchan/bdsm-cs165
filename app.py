from flask import Flask, render_template
from data import Content
from flask import url_for
import sqlite3

app = Flask(__name__)

Content = Content()

@app.route('/')
def index():
    return render_template('home.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/content')
def content():
    return render_template('content.html', content = Content)

# Sean: This is the database handler.
# This establishes a connection to the database.
# Connection failure would if our web-app was hosted online or other hardware mishaps.
def getConnection():
    conn = sqlite3.connect('database.db')
    if (conn == None):
        return render_template('errorConnectionDatabase.html')
    else:
        return conn

def getAllRows(tableName):
    conn = getConnection()
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("select * from '%s'" % tableName)
    rows = cursor.fetchall()
    cursor.close()
    return rows

def getRow(rowID, tableName):
    conn = getConnection()
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    if(tableName.lower() == "movieinfo"):
        cursor.execute("select * from '%s' where movieID=?" % (tableName,), str(rowID))
    elif (tableName.lower() == "personinfo"):
        cursor.execute("select * from '%s' where personID=?" % (tableName,), str(rowID))
    elif (tableName.lower() == "proreview"):
        cursor.execute("select * from '%s' where ProRevID=?" % (tableName,), str(rowID))
    elif (tableName.lower() == "userreview"):
        cursor.execute("select * from '%s' where UserRevID=?" % (tableName,), str(rowID))
    else:
        cursor.execute("select * from '%s' where %s=?" % (tableName,(tableName + "ID")), str(rowID))
    row = cursor.fetchone()
    cursor.close()
    return row;

@app.route('/songs/')
def browseAllSongs():
    rows = getAllRows("Song")
    return render_template('songs.html',content=rows)

@app.route('/songs/<int:songID>/')
def browseSongSingle(songID):
    row = getRow(songID, "Song")
    return render_template('songSingle.html',content=row)

# todo: show natural joins of Song & OST & Movies
# implement edit commit changes function

@app.route('/OST/')
def browseAllOST():
    rows = getAllRows("OST")
    return render_template("OST.html", content=rows)

@app.route('/OST/<int:ostID>/')
def browseOSTSingle(ostID):
    row = getRow(ostID, "OST")
    return render_template('OSTSingle.html',content=row)




if __name__ == '__main__':
    app.run(debug=True)
