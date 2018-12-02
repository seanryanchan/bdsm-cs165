from flask import Flask, render_template, request, redirect
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

def getCursor(conn, rowFactory=sqlite3.Row):
    conn.row_factory = rowFactory
    return conn.cursor()

def getAllRows(tableName):
    conn = getConnection()
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("select * from '%s'" % tableName)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return rows

def getRow(rowID, tableName):
    conn = getConnection()
    cursor = getCursor(conn)
    if(tableName.lower() == "movieinfo"):
        cursor.execute("select * from '%s' where movieID=?" % (tableName,), str(rowID))
        printSQLStmt("select * from '%s' where movieID=%s" % (tableName, str(rowID)))
    elif (tableName.lower() == "personinfo"):
        cursor.execute("select * from '%s' where personID=?" % (tableName,), str(rowID))
        printSQLStmt("select * from '%s' where personID=%s" % (tableName,str(rowID)))
    elif (tableName.lower() == "proreview"):
        cursor.execute("select * from '%s' where ProRevID=?" % (tableName,), str(rowID))
        printSQLStmt("select * from '%s' where ProRevID=%s" % (tableName,str(rowID)))
    elif (tableName.lower() == "userreview"):
        cursor.execute("select * from '%s' where UserRevID=?" % (tableName,), str(rowID))
        printSQLStmt("select * from '%s' where UserRevID=%s" % (tableName,str(rowID)))
    else:
        cursor.execute("select * from '%s' where %s=?" % (tableName,(tableName + "ID")), str(rowID))
        printSQLStmt("select * from '%s' where %s=%s" % (tableName,(tableName + "ID"),str(rowID)))
    row = cursor.fetchone()
    cursor.close()
    conn.close()
    return row;

def getRowsNatJoin(tableName, commonAttr, attrLookup, attrLookupValue):
    pass

def printSQLStmt(stmt):
    print("----- Executed SQL Statement -----")
    print(stmt)
    print("----------------------------------")


# FOR THE "SONG" PAGES

@app.route('/songs/')
def browseAllSongs():
    rows = getAllRows("Song")
    return render_template('songs.html',content=rows)

@app.route('/songs/<int:songID>/')
def browseSongSingle(songID):
    song = getRow(songID, "Song")
    conn = getConnection()
    cursor = getCursor(conn)
    cursor.execute("select * from PlayedIn p, ost o where p.ostid=o.ostid and p.songid=?", str(songID))
    printSQLStmt("select * from PlayedIn p, ost o where p.ostid=o.ostid and p.songid=%s" % str(songID))
    playedin = cursor.fetchall()
    cursor.close()
    conn.close()
    data = {"song": song, "playedin": playedin}
    return render_template('songSingle.html',content=data)

@app.route('/songs/<int:songID>/update/', methods=["POST"])
def updateSong(songID):
    newSongName = request.form["newSongName"]
    newArtist = request.form["newArtist"]
    conn = getConnection()
    cursor = getCursor(conn)
    cursor.execute("update Song set SongName='%s', Artist='%s' where SongID=?" % (newSongName, newArtist), str(songID))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect("/songs/%s/" %str(songID))

# For creating in PlayedIn
@app.route('/songs/<int:songID>/addOST/')
def song_addPlayedIn_view(songID):
    data={"song": getRow(songID,"Song"), "ost": getAllRows("OST")}
    return render_template('song_addPlayedIn_view.html', content=data)

@app.route('/songs/<int:songID>/addOST/<int:ostID>/', methods=["POST"])
def song_addPlayedIn_add(songID, ostID):
    conn = getConnection()
    cursor = getCursor(conn)
    try:
        cursor.execute("insert into PlayedIn values (?,?)", (str(ostID), str(songID)))
        printSQLStmt("insert into PlayedIn values (%s, %s)" % (str(ostID), str(songID)))
    except sqlite3.IntegrityError as e:
        cursor.close()
        conn.close()
        print("User has tried to input an existing entry in the table.")
        print(e)
        return redirect("/songs/%s/" % str(songID), code=302)
    conn.commit()
    cursor.close()
    conn.close()
    return redirect("/songs/%s/" % str(songID), code=302)

# FOR THE "OST" PAGES

@app.route('/OST/')
def browseAllOST():
    rows = getAllRows("OST")
    return render_template("OST.html", content=rows)

@app.route('/OST/<int:ostID>/')
def browseOSTSingle(ostID):
    ost = getRow(ostID, "OST")
    conn = getConnection()
    cursor = getCursor(conn)
    cursor.execute("select * from FeaturedIn f, MovieInfo m where f.movieid=m.movieid and f.ostid=?", str(ostID))
    printSQLStmt("select * from FeaturedIn f, MovieInfo m where f.movieid=m.movieid and f.ostid=%s"% str(ostID))
    featuredIn = cursor.fetchall()
    cursor.close()
    conn.close()
    data = {"ost": ost, "featuredIn": featuredIn}
    return render_template('OSTSingle.html',content=data)




if __name__ == '__main__':
    app.run(debug=True)
