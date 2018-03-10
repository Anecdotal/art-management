var database = require('./database.js');
var con = database.con;
var moment = require('moment');

module.exports = {
	init: function(app) {
		app.get('/login', function(req, res) {
			//	Render Login Page
			res.render('login.html');
		});

		app.post('/login', function(req, res) {
			var username = req.body.username;
			var password = req.body.password;

			con.query('SELECT * FROM users WHERE username = ?', [username], function(err, results) {
				if(!err) {
					if(results[0].length != 0) {
						//FIGURE OUT HOW TO SALT AND HASH/UNSALT AND HASH
						if(password == results[0].password) {
							req.user = results[0].uid_user;
						} else {
							res.send('INVALID PASS');
						}
					} else {
						res.send('FIGURE OUT HOW TO SEND INVALID USERNAME')
					}
				} else {
					res.render('error.html');
				}
			});
		});
	},
	
	isLoggedIn: function(req, res, next){
	 	if (req.user != undefined) {
	 		return next();
	 	} else {
	 		res.redirect('/login');
	 	}
	}
}