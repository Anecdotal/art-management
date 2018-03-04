//	MAKE THIS A CREDENTIALS THING
var con = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'mysql',
	database: 'my_writing'
});

module.exports = {
	con : con
}