var database = require('./database.js');
var con = database.con;
var moment = require('moment');

module.exports = {
	init: function(app) {
		//	Render Login Page
		app.get('/login', function(req, res) {
			res.render('login.html');
		});

		//	Actual Login
		app.post('/login', function(req, res) {
			var username = req.body.username;
			var password = req.body.password;

			con.query('SELECT * FROM users WHERE username = ?', [username], function(err, results) {
				if(!err) {
					if(results.length != 0) {
						//	FIGURE OUT HOW TO SALT AND HASH/UNSALT AND HASH
						if(password == results[0].password) {
							//	FIGURE OUT HOW TO KEEP THIS FROM REQUEST TO REQUEST
							req.user = results[0].uid_user;
							res.redirect('/');
						} else {
							//	IMPROVE FLASH ERRORS
							res.send('INVALID PASS');
						}
					} else {
						res.send('FIGURE OUT HOW TO SEND INVALID USERNAME');
					}
				} else {
					res.render('error.html');
				}
			});
		});
	},
	
	//	Checks if a user is logged in
	isLoggedIn: function(req, res, next){
	 	return next();
	}
}