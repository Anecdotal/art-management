var moment = require('moment');
var middleware = require('./login.js');
var database = require('./database.js');
var con = database.con;

module.exports = function(app) {
	app.get('/tables/:type', middleware.isLoggedIn, function(req, res) {
		//	Generic Variable Definitions
		var table = req.params.type;
		var uid = req.params.uid;
		var uid_user = req.user;

		//	Gets data for the specified db row
		con.query('SELECT * FROM ?', [table, uid_type, uid], function(err, results) {
			if(!err) {
				res.render('?.html', [req.params.type], {data:results});
			} else {
				res.render('error.html', {err:err});
			}
		});
	});
}