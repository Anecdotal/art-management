var database = require('./database.js');
var con = database.con;
var moment = require('moment');

module.exports = {
	init: function(app) {
		app.get('/login', function(req, res) {
			//	Render Login Page
			res.render('login.html');
		});

		app.post('/login', function(app, res) {
			//	Checks username + password
		});
	},
	
	isLoggedIn:function(req, res, next){
	 	//Checks if logged in
	 	return next();
	}
}