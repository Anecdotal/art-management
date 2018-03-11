var moment = require('moment');
var middleware = require('./login.js');
var database = require('./database.js');
var rows = require('./rows.js');
var con = database.con;

module.exports = {
	init: function(app) {
		app.get('/add/:type', middleware.isLoggedIn, function(req, res) { 
			res.render('?.html', [req.params.type]);
		});
		app.get('/edit/:type/:uid', middleware.isLoggedIn, rows.getRow);
		app.post('/add/:type', middleware.isLoggedIn, function(req, res) { 
			//BECAUSE OF DIFFERENT DB COLUMNS THESE SHOULD PROBABLY BE SPECIFIC TO EACH TYPE
		});
		app.post('/edit/:type/:uid', middleware.isLoggedIn, function(req, res) { 
			
		});
	},

	sturf: function() {

	},
}