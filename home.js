var moment = require('moment');
var middleware = require('./login.js');
var database = require('./database.js');
var con = database.con;

module.exports = function(app) {
	app.get('/', middleware.isLoggedIn, function(req, res) {
		//	DISUGSTING CONSTANTS, CHANGE WHEN LOGIN WORKS
		var uid_user = 1;
		var username = "Anecdotal";

		con.query('SELECT pieces.uid_piece, pieces.pieceTitle, submissions.dateSubmitted FROM submissions INNER JOIN pieces ON submissions.uid_piece = pieces.uid_piece', function(err, results) {
			console.log(err);
			console.log(results);
			console.log("BRUHS");
		})
		//	Query for upcoming deadlines
		con.query('SELECT * FROM places ORDER BY deadline ASC', function(err, resultsPlaces) {
			if(!err) {
				var places = [];
				var present = false;
				for (var i=0; i<resultsPlaces.length; i++) {
					var deadline = moment(resultsPlaces[i].deadline);
					if(present) {
						//	IS APPEND THE JS WAY???
						resultsPlaces[i].deadline = deadline.format('LLLL');
						places.push(resultsPlaces[i]);
					} else {
						if (deadline.isAfter(moment())) {
							resultsPlaces[i].deadline = deadline.format('LLLL');
							places.push(resultsPlaces[i]);
							present = true;
						}
					}
				}
				con.query('SELECT pieces.uid_piece, pieces.uid_user, pieces.pieceTitle, places.uid_place, places.placeName, places.notificationDate, places.notificationTime, places.notificationPlace, submissions.dateSubmitted, submissions.uid_result, submissions.uid_piece, submissions.uid_place FROM pieces JOIN submissions ON pieces.uid_piece = submissions.uid_piece JOIN places ON submissions.uid_place = places.uid_place WHERE pieces.uid_user = ? AND submissions.uid_result = 1 ORDER BY places.notificationDate DESC', [uid_user], function(err, resultsJoin) {
					if(!err) {
						console.log(resultsJoin);
						console.log("WHOA");
						for (var i=0; i<resultsJoin.length; i++) {
							resultsJoin[i].dateSubmitted = moment(resultsJoin[i].dateSubmitted).format('LLLL');
							if (resultsJoin[i].notificationDate == null) {
								resultsJoin[i].notificationDate = moment(moment(resultsJoin[i].dateSubmitted).add(resultsJoin[i].notificationTime,'w')).format('LLLL');
							} else {
								resultsJoin[i].notificationDate = moment(resultsJoin[i].notificationDate).format('LLLL');
							}
						}
						res.render('home.html', {username:username, places:places, subs:resultsJoin});
					} else {
						console.log("hiiii");
						res.render('error.html', {err:err});
					}
				});
			} else {
				console.log("BRUH");
				res.render('error.html', {err:err});
			}
		});
	});
}