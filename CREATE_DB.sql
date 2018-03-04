DROP DATABASE IF EXISTS my_writing;
CREATE DATABASE my_writing;

USE my_writing;

CREATE TABLE pieces (
	pieceTitle VARCHAR(128) PRIMARY KEY UNIQUE,
	genre VARCHAR(16),
	wordCount INT,
	link TEXT,
	createdDate DATE
);
CREATE TABLE places (
	placeName VARCHAR(128) PRIMARY KEY UNIQUE,
	deadline DATE,
	notification VARCHAR(64),
	cost INT,
	genre VARCHAR(16),
	requirements VARCHAR(512), #Including Number of Submissions
	rights VARCHAR(16),
	publication BOOLEAN,
	prize VARCHAR(256),
	submitLink VARCHAR(128)
);

CREATE TABLE submissions (
	pieceTitle VARCHAR(128),
	placeName VARCHAR(128),
	dateSubmitted DATE,
	result VARCHAR(32),
	FOREIGN KEY (pieceTitle) REFERENCES pieces(pieceTitle),
	FOREIGN KEY (placeName) REFERENCES places(placeName)
);

INSERT into pieces (pieceTitle, genre, wordCount, link, createdDate) values ("Golden Dreams", "Flash-Fiction", 779, "https://drive.google.com/open?id=1aPRDlYQk3aF24OXkPcCtku0QcPpkn69BW8Ksr8FZKQE", '2016-04-20');
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


INSERT into places (placeName, deadline, notification, cost, genre, requirements, rights, publication, prize, submitLink) values ("the Claremont Review", '2018-03-15', "May", 25, "All", "Fiction: <2kw; Poetry: 3 poems; Art: 3 photographs; no submission limit.", "First", 1, "~$750/500/250 for contest winners; ~$10 for publication; Subscription for all.", "https://theclaremontreview.submittable.com/Submit");
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

