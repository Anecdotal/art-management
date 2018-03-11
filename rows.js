var moment = require('moment');
var middleware = require('./login.js');
var database = require('./database.js');
var con = database.con;

module.exports = {
	init: function(app) {
		app.get('/rows/:type/:uid', middleware.isLoggedIn, module.exports.getRow);
	},
	getRow: function(req, res) {
		//	Generic Variable Definitions
		var table = req.params.type + "s";
		var uid_type = "uid_" + req.params.type;
		var uid = req.params.uid;
			
		//	Gets data for the specified db row
		con.query('SELECT * FROM ? WHERE ? = ?', [table, uid_type, uid], function(err, results) {
			if(!err && results.length != 0) {
				//	Makes sure the correct user is submitting the post request if necessary
				var able = true;
				if (table = "pieces") {
					able = false; 
					if (req.user == results[0].uid_user) {
						able = true;
					}
				} 
				if (able) {
					//	PUT ADD IN URL???
					res.render('?.html', [req.add + req.params.type], {data:results});
				} else {
					res.redirect('/');
				}
			} else {
				res.render('error.html', {err:err});
			}
		});
	}
}