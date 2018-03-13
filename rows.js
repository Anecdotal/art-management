var moment = require('moment');
var middleware = require('./login.js');
var database = require('./database.js');
var con = database.con;

module.exports = {
	init: function(app) {
		app.get('/pieces/:uid', middleware.isLoggedIn, canUserAccessPiece, function(req, res) {
			//	Get uid from url
			var uid_piece = req.params.uid;

			//	Gets data for the specified db row
			con.query('SELECT * FROM pieces WHERE uid_piece = ?', [uid_piece], function(err, results) {
				if(!err && results.length != 0) {
					
					//	Query to get all of the piece's submissions
					con.query('SELECT submissions.uid_piece, submissions.uid_place, submissions.uid_result, submissions.dateSubmitted, places.placeName, places.notificationDate, places.notificationDate, places.notificationTime, places.notificationPlace, results.resultName, results.resultDescription, result.resultMoney, result.publication FROM submissions INNER JOIN places ON submissions.uid_place = places.uid_place JOIN results ON submissions.uid_result = results.uid_result WHERE submissions.uid_piece = ? ORDER BY submissions.dateSubmitted ASC', [uid], function(err, resultsSubs) {
						if(!err && resultsSubs.length != 0)  {
							for (var i=0; i<resultsSubs.length; i++) {
								// If the submission has had a result (//isn't pending), 
								if (resultsSubs[i].uid_result != 1) {
									//notifChange
									//prize = ???
								} else {
									//
									//prize = !!!
								}
							}

							//	Gets all Eligible Places for this piece
							module.exports.getEligiblePlaces(uid_piece, function(eligibleArray) {
								//	Renders the page at last
								res.render('piece.html', {rowData:results, subs:resultsSubs, eligible:eligibleArray});
							});
						} else {
							res.render('error.html' {err:err});
						}
					});
				} else {
					res.render('error.html', {err:err});
				}
			});
		});
		
		app.get('/places/:uid' middleware.isLoggedIn, function(req, res) {
			//	Get uid from url
			var uid_place = req.params.uid;

			//	Gets data for the specified db row
			con.query('SELECT * FROM places WHERE uid_place = ?', [uid_place], function(err, results) {
				if(!err && results.length != 0) {
					
					//	Query to get all of the piece's submissions
					con.query('SELECT submissions.uid_piece, submissions.uid_place, submissions.uid_result, submissions.dateSubmitted, places.placeName, places.notificationDate, places.notificationDate, places.notificationTime, places.notificationPlace, results.resultName, results.resultDescription, result.resultMoney, result.publication FROM submissions INNER JOIN places ON submissions.uid_place = places.uid_place JOIN results ON submissions.uid_result = results.uid_result WHERE submissions.uid_piece = ? ORDER BY submissions.dateSubmitted ASC', [uid], function(err, resultsSubs) {
						if(!err && resultsSubs.length != 0)  {
							for (var i=0; i<resultsSubs.length; i++) {
								// If the submission has had a result (//isn't pending), 
								if (resultsSubs[i].uid_result != 1) {

								} else {

								}
							}

							//	Gets all Eligible Places for this piece
							module.exports.getEligiblePieces(uid_place, resultsReqs, function(eligibleArray) {
								//	Renders the page at last
								res.render('place.html', {rowData:results, reqs:resultsReqs, prizes:resultsResults, subs:resultsSubs, eligible:eligibleArray});
							});
						} else {
							res.render('error.html' {err:err});
						}
					});
				} else {
					res.render('error.html', {err:err});
				}
			});
		});
	}, 

	//	A middleware for determining whether a user can access a given piece
	canUserAccessPiece: function(req, res, next) {
		con.query('SELECT uid_user FROM pieces WHERE uid_piece = ?', [req.params.uid], function(err, results) {
			if(!err) {
				//	Checks if the uid_piece is a valid uid
				if(results.length == 0) {
					//	Checks if the user for this piece matches the current uid_user
					//	CHANGE CONSTANT '1' WHEN LOGIN WORKS
					if(results[0].uid_user == 1) {
						return next();
					} else {
						res.redirect('/');
					}
				} else {
					res.redirect('/');
				}
			} else {
				res.render('error.html', {err:err});
			}
		});
	},

	//Gets an array of eligible pieces for a place (uid_place) with the requirements (reqs)
	getEligiblePieces: function(uid_place, reqs, callback) {

	},
	//Gets an array of eligible places for a piece
	getEligiblePlaces: function(uid_piece, callback) {
		con.query('SELECT _ FROM _ JOIN _ ON _ = _ WHERE _ = _', [uid], function(err, resultsPlaces) {
			if(!err && results.length != 0)  {
				for (var i=0; i<resultsPlaces.length; i++) {
					// If the submission has had a result (//isn't pending), 
					if (resultsSubs[i].uid_result != 1) {
						
					} else {

					}
				}
				res.render();
			} else {
				res.render('error.html' {err:err});
			}
		});
	}
}