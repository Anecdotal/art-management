//	MAKE THIS A CREDENTIALS THING
var con = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'mysql',
	database: 'art_management'
});

module.exports = {
	con : con
}