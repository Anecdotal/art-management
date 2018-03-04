var mysql = require('mysql');
var moment = require('moment');
var express = require('express');
var app = express();
var mustacheExpress = require('mustache-express');
app.engine('html', mustacheExpress());
app.set('views', __dirname + '/views');
var database = require('./database.js');
var con = database.con;

//	Separated Code Pulled In
var add_edit = require("./add_edit.js").init(app);
var home = require('./home.js').init(app);
var login = require("./login.js").init(app);
var rows = require("./rows.js").init(app);
var tables = require("./tables.js").init(app);

//	OUTDATED ENDPOINTS BEGIN:
//	DO NOT RUN!!!!
app.get('/', function(request, response){
	con.query('SELECT * FROM places', function(err, places) {
		if(!err) {
			var futurePlaces = [];
			for(var i=0; i<places.length; i++) {
				if(moment(places[i].deadline).isSameOrAfter(moment())) {
					futurePlaces.push(places[i]);
				}
			}
			con.query('SELECT * FROM submissions WHERE result = "Pending"', function(err, subs) {
				if(!err) {
					if(subs.length != 0) {
						for(var i=0; i<subs.length; i++) {
							for (var j=0; j<places.length; j++){
								if(subs[i].placeName == places[j].placeName){
									subs[i].notification = places[j].notification;
								}
							}
						}
						response.render('home.html', {places:futurePlaces, subs:subs})
					} else {
						response.render('home.html', {places:futurePlaces, submitted:true});
					}
				} else {
					response.send("Se produjo un error. Tratalo Otra Vez!");
				}
			});
		} else {
			response.send("Se produjo un error. Tratalo Otra Vez!");
		}
	});
})

app.get('/pieces-places', function(request, response) {
	con.query('SELECT * FROM places', function(err, places) {
		if(!err) {
			con.query('SELECT * FROM pieces', function(err, pieces) {
				if(!err) {
					response.render('sortingtable.html', {places:places, pieces:pieces});
				} else {
					response.send("Se produjo un error. Tratalo Otra Vez!");
				}
			});
		} else {
			response.send("Se produjo un error. Tratalo Otra Vez!");
		}
	});
})

/*app.get('/stories/:pieceTitle', function(request, response) {
	con.query('SELECT * FROM pieces WHERE pieceTitle = ?', [request.params.pieceTitle], function(err, res) {
		if(!err) {

		} else {
			response.send("Se produjo un error. Tratalo Otra Vez!");
		}
	});
})*/

app.get('/places/:placeName', function(request, response) {
	con.query('SELECT * FROM places WHERE placeName = ?', [request.params.placeName], function(err, place) {
		if(!err) {
			if(place.length != 0) {
				con.query('SELECT * FROM submissions WHERE placeName = ?', [request.params.placeName], function(err, subs) {
					if(!err) {
						if(subs.length != 0) {
							response.render('place.html', {place:place, subs:subs});
						} else {
							response.render('place.html', {place:place, submitted:true});
						}
					} else {
						response.send("Se produjo un error. Tratalo Otra Vez!");
					}
				});
			} else {
				response.send("Nombre Invalido. Tratalo Otra Vez!");
			}
		} else {
			response.send("Se produjo un error. Tratalo Otra Vez!");
		}
	});
})

var server = app.listen(8000, function() {
	console.log('Writing server listening on port %s', server.address().port);
});
