DROP DATABASE IF EXISTS art_management;
CREATE DATABASE art_management;

USE art_management;

CREATE TABLE users (
	uid_user INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(25),
	password TEXT,
	PRIMARY KEY (uid_user)
);

CREATE TABLE pieces (	#A piece can be a piece of art of any type, from photography to writing
	uid_piece INT NOT NULL AUTO_INCREMENT,
	uid_user INT,
	pieceTitle VARCHAR(128),
	link VARCHAR(256),
	createdDate DATE,
	medium_genre ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting'), #ENUM for the medium or genre of the piece
	width_wordsLines INT DEFAULT NULL, #Width (in.) for works of visual art; words for fiction and non-fiction; lines for poetry
	height_pages INT DEFAULT NULL, #Height (in.) for works of visual art; pages for creative writing
	#GENRE 	?? (ENUM) (DIFFERENT COLUMN FOR DIFF TYPES) (INC PORTFOLIO)
	FOREIGN KEY (uid_user) REFERENCES users(uid_user),
	PRIMARY KEY (uid_piece)
);

CREATE TABLE places (	#A place can be a contest, scholarship, or publication of any sort
	uid_place INT NOT NULL AUTO_INCREMENT,
	placeName VARCHAR(128),
	deadline DATE,		#Can be manually "renewed" to the same date on the next year by the user
	notificationDate DATE DEFAULT NULL,	#(Used mostly for contests) if the place provides a date at which it will reveal results for all submissions
	notificationTime INT DEFAULT NULL,	#(Used mostly for publications) An amount of weeks after a piece's submission when the place will release its results (the longest amount if it's a range)
	cost INT DEFAULT 0,	#Cost of submissions 
	submitLink VARCHAR(256),
	firstRights TINYINT(1),	#Boolean for whether or not the place accepts already published work
	comments TEXT, 		#A space to put extra rights required or other important information
	PRIMARY KEY (uid_place)
);

CREATE TABLE requirements (
	uid_requirement INT NOT NULL AUTO_INCREMENT,
	uid_place INT,
	medium_genre ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting'), #ENUM telling which medium/genre this requirement corresponds to
	min_width_wordsLines INT DEFAULT 1, #Minimum required width or words or lines
	min_height_pages INT, #Minimum required height or pages (will rarely be used in the case of pages)
	max_width_wordsLines INT, #Maximum possible width or words or lines
	max_height_pages INT, #Maximum possible height or pages (will rarely be used in the case of pages)
	max_submissions INT NOT NULL DEFAULT 1, #Maximum Number of submissions for this genre at this place
	PRIMARY KEY (uid_requirement),
    FOREIGN KEY (uid_place) REFERENCES places(uid_place)
);

CREATE TABLE results (
	uid_result INT NOT NULL AUTO_INCREMENT,
	uid_place INT, 
	resultName VARCHAR(64),
	resultDescription TEXT,
	resultMoney INT DEFAULT 0, #($)
	publication TINYINT(1) DEFAULT 0,
    PRIMARY KEY (uid_result),
	FOREIGN KEY (uid_place) REFERENCES places(uid_place)
);

CREATE TABLE submissions (
	uid_submission INT NOT NULL AUTO_INCREMENT,
	uid_user INT,
    uid_piece INT,
	uid_place INT,
	uid_result INT DEFAULT NULL, #Will be NULL if there isn't yet a result, '1' if declined/rejected
	dateSubmitted DATE,
	dateNotified DATE,
	PRIMARY KEY (uid_submission),
	FOREIGN KEY (uid_result) REFERENCES results(uid_result),
	FOREIGN KEY (uid_user) REFERENCES users(uid_user),
	FOREIGN KEY (uid_piece) REFERENCES pieces(uid_piece),
	FOREIGN KEY (uid_place) REFERENCES places(uid_place)
);

#DO NOT CHANGE: The first results row must be for rejection (from any place) for the schema to function as efficiently as possible
INSERT INTO results (uid_place, resultName, resultDescription) values (NULL, "Declined", "generic rejection.");

