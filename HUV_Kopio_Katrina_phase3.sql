-- NOTE: This runs on sqlite3
-- Some changes were made to the previous phase:
	-- ID numbers were changed from integers to varchar(5)
	-- The PersonInfo entity's attributes were decreased (removed birthday and nationality)

.mode column
.headers on
PRAGMA foreign_keys = ON;

DROP TABLE MovieInfo;
DROP TABLE PersonInfo;
DROP TABLE OST;
DROP TABLE Song;
DROP TABLE UserReview;
DROP TABLE ProReview;
DROP TABLE ActedIn;
DROP TABLE Directed;
DROP TABLE FeaturedIn;
DROP TABLE PlayedIn;
DROP TABLE ProReviewed;
DROP TABLE UserReviewed;

CREATE TABLE MovieInfo(
	MovieID		varchar(5),
	Title 		varchar(20),
	Premise		varchar(300),
	Genre 		varchar(20),
	Year		int,
	Length		int,
	primary key (MovieID)
);

CREATE TABLE PersonInfo(
	PersonID	varchar(5),
	Name 		varchar(20),
	Gender		varchar(10),
	primary key (PersonID)
);

CREATE TABLE OST(
	OSTID		varchar(5),
	AlbumName	varchar(20),
	Genre 		varchar(20),
	Year 		varchar(5),
	primary key (OSTID)
);

CREATE TABLE Song(
	SongID		varchar(5),
	SongName 	varchar(20),
	Artist		varchar (20),
	primary key (SongID)
);

CREATE TABLE UserReview(
	UserRevID 	varchar(5),
	UserName	varchar(20),
	Review 		varchar(300),
	Rating		varchar(4),
	primary key (UserRevID)
);

CREATE TABLE ProReview (
	ProRevID 		varchar(5),
	RottenTomatoes 	varchar(3),
	MetaCritic 		varchar(3),
	IMDB			varchar(3),
	primary key (ProRevID)
);

CREATE TABLE ActedIn (
	MovieID		varchar(5),
	PersonID	varchar(5),
	primary key (MovieID, PersonID),
	foreign key (MovieID) references MovieInfo
		on delete set null,
	foreign key (PersonID) references PersonInfo
		on delete set null
);

CREATE TABLE Directed (
	MovieID 	varchar(5),
	PersonID 	varchar(5),
	primary key (MovieID, PersonID),
	foreign key (MovieID) references MovieInfo
		on delete set null,
	foreign key (PersonID) references PersonInfo
		on delete set null
);

CREATE TABLE FeaturedIn (
	MovieID 	varchar(5),
	OSTID 		varchar(5),
	primary key (MovieID, OSTID),
	foreign key (MovieID) references MovieInfo
		on delete set null,
	foreign key (OSTID) references OST
		on delete set null
);

CREATE TABLE PlayedIn (
	OSTID 		varchar(5),
	SongID 		varchar(5),
	primary key (OSTID, SongID),
	foreign key (OSTID) references OST
		on delete set null,
	foreign key (SongID) references Song
		on delete set null
);

CREATE TABLE ProReviewed (
	ProRevID 	varchar(5),
	MovieID 	varchar(5),
	primary key (ProRevID, MovieID),
	foreign key (ProRevID) references ProReview
		on delete set null,
	foreign key (MovieID) references MovieInfo
		on delete set null
);

CREATE TABLE UserReviewed (
	UserRevID 	varchar(5),
	MovieID 	varchar(5),
	primary key (UserRevID, MovieID),
	foreign key (UserRevID) references UserReview
		on delete set null,
	foreign key (MovieID) references MovieInfo
		on delete set null
);

-- (MovieID, Title, Premise, Genre, Year, Length)
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00001, "Spirited Away", "During her family's move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.", "Animation", 2001, 125);
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00002, "The Godfather", "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.", "Crime", 1972, 175);
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00003, "High School Musical", "A popular high school athlete and an academically gifted girl get roles in the school musical and develop a friendship that threatens East High's social order.", "Comedy", 2006, 98);
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00004, "La La Land", "While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.", "Music", 2016, 128);
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00005, "The Little Mermaid", "A mermaid princess makes a Faustian bargain with an unscrupulous sea-witch in order to meet a human prince on land.", "Animation", 1989, 83);
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00006, "Monty Python and the Holy Grail", "King Arthur and his Knights of the Round Table embark on a surreal, low-budget search for the Holy Grail, encountering many, very silly obstacles.", "Comedy", 1975, 91);
INSERT INTO MovieInfo (MovieID, Title, Premise, Genre, Year, Length) VALUES (00007, "Wonder Woman", "When a pilot crashes and tells of conflict in the outside world, Diana, an Amazonian warrior in training, leaves home to fight a war, discovering her full powers and true destiny.", "Comedy", 2017, 141);

-- (PersonID, Name, Gender)
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00001, "Zac Efron", "Male");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00002, "Hayao Miyazaki", "Male");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00003, "Diane Keaton", "Female");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00004, "Gal Gadot", "Female");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00005, "Emma Stone", "Female");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00006, "John Cleese", "Male");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00007, "Ashley Tisdale", "Female");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00008, "Patty Jenkins", "Female");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00009, "Kenny Ortega", "Male");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00010, "Damien Chazelle", "Male");
INSERT INTO PersonInfo (PersonID, Name, Gender) VALUES (00011, "Francis Ford Coppola", "Male");

-- (OSTID, AlbumName, Genre, Year)
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00001, "High School Musical (Soundtrack)", "Teen Pop", 2005);
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00002, "Spirited Away Original Soundtrack", "Instrumental", 2001);
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00003, "The Greatest Showman: Original Motion Picture Soundtrack", "Pop", 2017);
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00004, "La La Land: Original Motion Picture Soundtrack", "Pop", 2016);
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00005, "The Little Mermaid: Original Walt Disney Records Soundtrack", "Broadway", 2014);
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00006, "Wonder Woman", "Soundtrack", 2017);
INSERT INTO OST (OSTID, AlbumName, Genre, Year) VALUES (00007, "The Godfather", "Soundtrack", 1972);

-- (SongID, SongName, Artist)
INSERT INTO Song (SongID, SongName, Artist) VALUES (00001, "Start of Something New", "Zac Efron, Vanessa Hudgens");
INSERT INTO Song (SongID, SongName, Artist) VALUES (00002, "One Summer's Day", "Joe Hisaishi");
INSERT INTO Song (SongID, SongName, Artist) VALUES (00003, "From Now On", "Hugh Jackman");
INSERT INTO Song (SongID, SongName, Artist) VALUES (00004, "City of Stars", "Ryan Gosling");
INSERT INTO Song (SongID, SongName, Artist) VALUES (00005, "Amazons of Themyscira", "Rupert Gregson-Williams");
INSERT INTO Song (SongID, SongName, Artist) VALUES (00006, "This is Me", "Keala Settle");
INSERT INTO Song (SongID, SongName, Artist) VALUES (00007, "Another Day of Sun", "Cast of La La Land");

-- (UserRevID, UserName, Review, Rating)
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (01510, "Katrina", "Fun movie to remember your childhood and feel young again.", "7");
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (00231, "Karl", "A classic. Two thumbs up", "10");
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (00130, "Sean", "I'm inspired.", "9.5");
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (00180, "Luis", "Overrated movie. :/", "7");
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (00165, "Jian", "How can you not love this movie?", "10");
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (00145, "Rheeca", "One of the coolest movies ever.", "8");
INSERT INTO UserReview (UserRevID, UserName, Review, Rating) VALUES (00021, "Rianna", "Meh", "6");

-- (ProRevID, RottenTomatoes, MetaCritic, IMDB)
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00001, "97", "96", "8.6"); -- Spirited Away
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00002, "56", "57", "5.3"); -- High School Musical
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00003, "56", "48", "7.7"); -- Greatest Showman
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00004, "98", "100", "9.2"); -- The Godfather
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00005, "91", "93", "8.1"); -- La La Land
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00006, "92", "88", "7.6"); -- Little Mermaid
INSERT INTO ProReview (ProRevID, RottenTomatoes, MetaCritic, IMDB) VALUES (00007, "93", "76", "7.5"); -- Wonder Woman

-- (MovieID, PersonID)
INSERT INTO ActedIn VALUES (00003, 00001);
INSERT INTO ActedIn VALUES (00002, 00003);
INSERT INTO ActedIn VALUES (00007, 00004);
INSERT INTO ActedIn VALUES (00004, 00005);
INSERT INTO ActedIn VALUES (00006, 00006);
INSERT INTO ActedIn VALUES (00003, 00007);

-- (MovieID, PersonID)
INSERT INTO Directed VALUES (00001, 00002);
INSERT INTO Directed VALUES (00007, 00008);
INSERT INTO Directed VALUES (00003, 00009);
INSERT INTO Directed VALUES (00004, 00010);
INSERT INTO Directed VALUES (00002, 00011);

-- (MovieID, OSTID)
INSERT INTO FeaturedIn VALUES (00001, 00002);
INSERT INTO FeaturedIn VALUES (00003, 00001);
INSERT INTO FeaturedIn VALUES (00002, 00007);
INSERT INTO FeaturedIn VALUES (00004, 00004);
INSERT INTO FeaturedIn VALUES (00007, 00006);

-- (OSTID, SongID)
INSERT INTO PlayedIn VALUES (00001, 00001);
INSERT INTO PlayedIn VALUES (00002, 00002);
INSERT INTO PlayedIn VALUES (00003, 00003);
INSERT INTO PlayedIn VALUES (00004, 00004);
INSERT INTO PlayedIn VALUES (00006, 00005);
INSERT INTO PlayedIn VALUES (00003, 00006);
INSERT INTO PlayedIn VALUES (00004, 00007);

-- (ProRevID, MovieID)
INSERT INTO ProReviewed VALUES (00001, 00001);
INSERT INTO ProReviewed VALUES (00002, 00003);
INSERT INTO ProReviewed VALUES (00004, 00002);
INSERT INTO ProReviewed VALUES (00005, 00004);
INSERT INTO ProReviewed VALUES (00006, 00005);
INSERT INTO ProReviewed VALUES (00007, 00007);

-- (UserRevID, MovieID)
INSERT INTO UserReviewed VALUES (01510, 00003);
INSERT INTO UserReviewed VALUES (00231, 00001);
INSERT INTO UserReviewed VALUES (00130, 00004);
INSERT INTO UserReviewed VALUES (00180, 00002);
INSERT INTO UserReviewed VALUES (00165, 00006);
INSERT INTO UserReviewed VALUES (00145, 00007);
INSERT INTO UserReviewed VALUES (00021, 00005);


SELECT * FROM MovieInfo;
SELECT * FROM PersonInfo;
SELECT * FROM OST;
SELECT * FROM Song;
SELECT * FROM UserReview;
SELECT * FROM ProReview;
SELECT * FROM ActedIn;
SELECT * FROM Directed;
SELECT * FROM FeaturedIn;
SELECT * FROM PlayedIn;
SELECT * FROM ProReviewed;
SELECT * FROM UserReviewed;
