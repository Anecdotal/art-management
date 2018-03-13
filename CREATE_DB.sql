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
	FOREIGN KEY (uid_user) REFERENCES users(uid_user),
	PRIMARY KEY (uid_piece)
);

CREATE TABLE places (	#A place can be a contest, scholarship, or publication of any sort
	uid_place INT NOT NULL AUTO_INCREMENT,
	placeName VARCHAR(128),
	deadline DATE,		#Can be manually "renewed" to the same date on the next year by the user
	notificationDate DATE DEFAULT NULL,	#(Used mostly for contests) if the place provides a date at which it will reveal results for all submissions
	notificationTime INT DEFAULT NULL,	#(Used mostly for publications) An amount of weeks after a piece's submission when the place will release its results (the longest amount if it's a range)
	notificationPlace ENUM('Website', 'Email', 'Submittable'), #The way the place will notify a user
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
	min_height_pages INT DEFAULT NULL, #Minimum required height or pages (will rarely be used in the case of pages)
	max_width_wordsLines INT DEFAULT 1, #Maximum possible width or words or lines
	max_height_pages INT DEFAULT NULL, #Maximum possible height or pages (will rarely be used in the case of pages)
	max_submissions INT DEFAULT 1, #Maximum Number of submissions for this genre at this place (NULL if no submission limit)
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
	uid_result INT DEFAULT 1, #Will be NULL if there isn't yet a result, '1' if declined/rejected
	dateSubmitted DATE,
	dateNotified DATE DEFAULT NULL,
	PRIMARY KEY (uid_submission),
	FOREIGN KEY (uid_result) REFERENCES results(uid_result),
	FOREIGN KEY (uid_user) REFERENCES users(uid_user),
	FOREIGN KEY (uid_piece) REFERENCES pieces(uid_piece),
	FOREIGN KEY (uid_place) REFERENCES places(uid_place)
);

#DO NOT CHANGE: The first two results rows must be for pending (no results) and rejection (from any place) for the schema to function as efficiently as possible
INSERT INTO results (uid_place, resultName, resultDescription) values (NULL, "Pending", "No result yet.");
INSERT INTO results (uid_place, resultName, resultDescription) values (NULL, "Declined", "generic rejection.");


#My Data TO BE FIXED FOR CURRENT SCHEMA
INSERT INTO users (username, password) VALUES ("Anecdotal", "pass");

#INSERT INTO places (placeName, deadline, notificationDate/Time, notificationPlace, cost, submitLink, firstRights, comments) VALUES (placeName, deadline, notificationDate/Time, notificationPlace, cost, submitLink, firstRights, comments);
INSERT INTO places (placeName, deadline, notificationDate, notificationPlace, cost, submitLink, firstRights, comments) VALUES ("the Claremont Review", '2018-03-15', '2018-05-31', "Email", 25, "https://theclaremontreview.submittable.com/Submit", 1, "All entries get a subscription!");
INSERT INTO places (placeName, deadline, notificationTime, notificationPlace, cost, submitLink, firstRights, comments) VALUES ("Polyphony HS", '2018-05-31', 8, "Website", 0, "http://polyphonyhs.com/submissions/index.php", 0, "Receive Comments on every submission. In depth!");


/*
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Polyphony HS", '2018-05-31', "6-8 Weeks After Submission", 0, "All", "Prose: <1.5kw; Poetry: <80l; 3 submissions per issue.", "One-Time", 1, "$200 for winners of contest; One Contributor's Copy for publication", "http://polyphonyhs.com/submissions/index.php");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("One Teen Story", '2018-01-14', "Unclear", 0, "Fiction", "In between 2kw and 4.5kw; Limit of one submission.", "First", 1, "$500 and 25 contributor's copies for publication", "https://www.one-story.com/submissions_ots/");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Icarus Anthology", '2017-12-31', "Supposedly One Week", 0, "All", "Fiction: <3kw; Poetry: <2p; Limit of 2 and 3 fiction and poetry submissions per issue.", "First", 1, "None", "https://icarusanthology.org/submit/");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("YoungArts", '2018-10-13', "December 2018", 35, "All", "Fiction: 2 Pieces <20 p. total (2-2.5kW each); Poetry: 1-4 poems <10p. total; Other Categories: Similar; no submission limit.", "None", 0, "Merit: Invitation to regional programs; HM: Merit + $250; Finalist: Merit + $1-10,000 and National Youngarts Week.", "https://app.getacceptd.com/youngarts");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Scholastic Art & Writing Awards", '2017-12-07', "January 30, 2018", 5, "All", "Flash Fiction: <1kw; Poetry: >20l; Generally <3kw; no submission limit", "None", 0, "Regional: Gold or Silver Keys or Honorable Mentions; National: Gold or Silver Medals, $500 for Best in Grade Award.", "https://www.artandwriting.org/Login");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Mirabella Contest", '2018-01-15', "March 2018", 0, "All", "Fiction: <1kw; Poetry: <2p; Limit of 1 entry.", "None", 1, "$500 for winner; Reading for publication", "https://tupelopress-twc.submittable.com/submit");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Aerie International", '2018-02-01', "March-June 2018", 0, "All", "Fiction: <1.5kw; Poetry: <1.5kw; Limit of 5 submissions (inc. photos) per year.", "One-Time", 1, "$100 for award winners; One contributor´s copy for publiction.", "https://aerieinternational.submittable.com/submit");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Glass Kite Anthology", '2018-12-31', "1-2 Months", 0, "All", "Fiction: <5kw; Poetry: ?; Limit of 3 submissions (inc. photos) per issue.", "First", 1, "None", "https://www.glasskiteanthology.com/submit.html");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Adventure Write Contest", '2018-12-31', "March", 0, "Fiction", "<1.5kw; no subimssion limit", "First?", 1, "$20 for age group winners + publication", "http://adventurewrite.com/blog1/contest/");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Crashtest", '2018-06-01', "1-2 Months", 0, "All", "Fiction: 1 sub; Poetry: 3-5 subs; Art: .jpeg", "First (unless school pub)", 1, "None", "http://www.crashtestmag.com/2/");
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Interlochen Review", '2018-03-02', "May 15, 2018", 0, "All", "Prose: <5kw; Poetry: No Limit; Art: .jpeg; Limit of 6 submissions.", "Online", 0, "None", "https://interlochen.submittable.com/submit");
/*INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Apprehension Magazine", NULL, "1-2 Months", 0, "All", requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Rattle Young Poets Anthology", '2018-06-15', notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Adroit Journal", deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("Parallax Online", deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink);
*/

#Claremont Review Reqs
INSERT INTO requirements (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, min_width_wordsLines, min_height_pages, max_width_wordsLines, max_submissions) VALUES (1, "Fiction", 1, NULL, 2000, NULL);
INSERT INTO requirements (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, min_width_wordsLines, min_height_pages, max_submissions) VALUES (1, "Poetry", 1, NULL, 3);
INSERT INTO requirements (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, max_submissions) VALUES (1, "Photography", 3);
INSERT INTO requirements (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, max_submissions) VALUES (1, "Drawing", NULL);
INSERT INTO requirements (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, max_submissions) VALUES (1, "Painting", NULL);
#INSERT INTO requirements (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, min_width_wordsLines, min_height_pages, max_width_wordsLines, max_submissions) VALUES (uid_place, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, min_width_wordsLines, min_height_pages, max_width_wordsLines, max_submissions);

#INSERT INTO results (uid_place, resultName, resultDescription, resultMoney, publication) VALUES (uid_place, resultName, resultDescription, resultMoney, publication);
INSERT INTO results (uid_place, resultName, resultDescription, resultMoney, publication) VALUES (1, "First Place", "Winning the contest. Contributor's Copy.", 750, 1);
INSERT INTO results (uid_place, resultName, resultDescription, resultMoney, publication) VALUES (1, "Second Place", "Winning the contest. Contributor's Copy.", 250, 1);
INSERT INTO results (uid_place, resultName, resultDescription, resultMoney, publication) VALUES (1, "Third Place", "Winning the contest. Contributor's Copy.", 100, 1);
INSERT INTO results (uid_place, resultName, resultDescription, resultMoney, publication) VALUES (1, "Publication", "Winning publication. Contributor's Copy.", 10, 1);

#INSERT INTO pieces (uid_user, pieceTitle, link, createdDate, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, width_wordsLines, height_pages) VALUES (uid_user, pieceTitle, link, createdDate, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, width_wordsLines, height_pages);
INSERT INTO pieces (uid_user, pieceTitle, link, createdDate, medium_genre/*ENUM('Portfolio', 'Fiction', 'Non-Fiction', 'Poetry', 'Drawing', 'Photography', 'Painting')*/, width_wordsLines, height_pages) VALUES (1, "Silence Rises", "https://docs.google.com/document/d/1Vc5IhjmZHI66QPbnzA0kciquRYYI1MQEzHYJGATcmQ8/edit?usp=sharing", '2017-07-15', "Fiction", 546, 2);

/*INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Golden Dreams", "Flash-Fiction", 779, "https://drive.google.com/open?id=1aPRDlYQk3aF24OXkPcCtku0QcPpkn69BW8Ksr8FZKQE", '2016-04-20');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Silence Rises", "Flash-Fiction", 553, "https://drive.google.com/open?id=1x9Lqons8yESL8U12yeGgrpLhBktb5OAdLsKOCqxMtMs", '2017-07-12');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Prodigal", "Fiction", 1744, "https://drive.google.com/open?id=1miCDK8i7nO1Iv-KyhN19Gmh_Apu46Vr93MhFZ-PJ9zo", '2016-12-20');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("shiver", "Poetry", 106, "https://drive.google.com/open?id=1r3LpTkpTiNyYXLHeKUruW-ysE-1sXQIFjRYqUcwXYcU", '2016-12-20');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("How to Build a Sky", "Poetry", 304, "https://drive.google.com/open?id=1O38A95xidYu3qmrqo0e-q_BFKJTxF3gv3vOshFlcOqQ", '2017-08-07');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Labyrinthine", "Poetry", 127, "https://drive.google.com/open?id=1D-Y2QGxfhIkLyEZSWWn-87o-pJdwl-J_K2Qd3dA0vPE", '2017-01-04');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("The Comet's Countdown", "Poetry", 593, "https://drive.google.com/open?id=1VZCxPx7KDGTdW8e77t3R42G-uRHNpNEXTUqBrIQG3fc", '2016-07-28');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("The Rattle", "Fiction", 0, "https://drive.google.com/open?id=17q4W83Ka4Rnz_iZIewtKGOlseNcUlBpnZTIdXKygbVQ", '2017-12-07');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Claustrophobia", "Flash-Fiction", 0, "https://drive.google.com/open?id=10Zttn_hGfsg9Ei9lc3cgKWm8CvVKiFcWqGum60e6WG0", '2017-05-09');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Neoclassical Narcissist", "Poetry", 402, "https://drive.google.com/open?id=1oTUL-X0dD9NqdaFgK6V4PDsliinCL-hoh5fy139HZag", '2016-02-07');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("The Dragon and the Swarm", "Fiction", 0, "https://drive.google.com/open?id=1X_EGGbU9audVVkF9cRQE_Or5-Hr0WBwF0ccAqa9_5TQ", '2017-07-04');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("American Nightmare", "Photography", 0, "https://youngarts.org", '2017-06-11');
INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Silence Rises 2nd Person", "Flash-Fiction", 546, "https://docs.google.com/document/d/1Vc5IhjmZHI66QPbnzA0kciquRYYI1MQEzHYJGATcmQ8/edit?usp=sharing", '2017-11-14');
*/

#INSERT INTO submissions (uid_user, uid_piece, uid_place, uid_result, dateSubmitted, dateNotified) VALUES (uid_user, uid_piece, uid_place, uid_result, dateSubmitted, dateNotified);
#INSERT INTO submissions (uid_user, uid_piece, uid_place, uid_result, dateSubmitted, dateNotified) VALUES (uid_user, uid_piece, uid_place, uid_result, dateSubmitted, dateNotified);
INSERT INTO submissions (uid_user, uid_piece, uid_place, uid_result, dateSubmitted) VALUES (1, 1, 2, 1, '2018-03-01');


/*
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Silence Rises", "Icarus Anthology", '2017-12-09', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Silence Rises", "Aerie International", '2018-01-30', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Silence Rises", "Scholastic Art & Writing Awards", '2017-12-07', "Honorable Mention");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Labyrinthine", "Icarus Anthology", '2017-12-09', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Labyrinthine", "Scholastic Art & Writing Awards", '2017-12-07', "Declined");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("How to Build a Sky", "Icarus Anthology", '2017-12-09', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("How to Build a Sky", "Aerie International", '2018-01-30', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("How to Build a Sky", "Scholastic Art & Writing Awards", '2017-12-07',"Honorable Mention");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Golden Dreams", "Adventure Write Contest", '2017-12-31', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Golden Dreams", "Mirabella Contest", '2017-01-15', "Declined");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Golden Dreams", "Scholastic Art & Writing Awards", '2016-12-07', "Silver Key");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Neoclassical Narcissist", "Scholastic Art & Writing Awards", '2016-12-07', "Honorable Mention");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Prodigal", "Scholastic Art & Writing Awards", '2016-12-07', "Honorable Mention");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Prodigal", "Polyphony HS", '2016-12-20', "Declined");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("shiver", "Polyphony HS", '2016-12-20', "Accepted");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("shiver", "Mirabella Contest", '2017-01-15', "Accepted");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("American Nightmare", "Aerie International", '2018-01-30', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Silence Rises 2nd Person", "Interlochen Review", '2018-03-01', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values ("Silence Rises 2nd Person", "Polyphony HS", '2018-03-01', "Pending");
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values (pieceTitle, placeName, dateSubmitted, result);
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values (pieceTitle, placeName, dateSubmitted, result);
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values (pieceTitle, placeName, dateSubmitted, result);
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values (pieceTitle, placeName, dateSubmitted, result);
INSERT into submissions (pieceTitle, placeName, dateSubmitted, result) values (pieceTitle, placeName, dateSubmitted, result);
*/
