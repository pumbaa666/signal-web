const conf = require('../conf/app');

/*
 * Logger
 */
var log4js = require('log4js');
log4js.configure('./conf/log4js.json');
var logger = log4js.getLogger('app');

/*
 * Web
 */
const express = require('express');


var app = express();
app.use(express.static('scripts')); // Serves static files. Used in ./views/*.ejs files to include ./scripts/*.js
app.use(express.json()); // Parse json object and put them in the request.body : https://stackoverflow.com/questions/10005939/how-do-i-consume-the-json-post-data-in-an-express-application

function isUserAutenthicated(req, res) {
	if (res && !req.headers.authorization.success) {
		res.setHeader('Content-Type', 'application/json');
		res.status(401).json({ error: { message: 'You should be connected to do this operation', reason: req.headers.authorization.message } });
	}

	return req.headers.authorization.success;
}

/*
 * Create user if username and password are set in the body.
 * The payload is JSON.
 * No authentication required.
 */
app.post('/users', function (req, res, next) {
	var user = JSON.parse(req.body.user);
	if (!user || !user.username || !user.password)
		return next({ error: 'Missing username/password' });

	user.password = hash(user.password);

	UsersModel.create(user, function (error, user) {
		if (error)
			return next(error);
		logger.debug('new user created : ' + user);
		return res.status(201).json(user);
	});
});

function page404(req, res) {
	res.setHeader('Content-Type', 'application/json');
	res.status(404).send({ error: 'Unknown page !' });
}
app.use(page404);

function errorHandler(error, req, res, next) {
	logger.error(error);
	res.setHeader('Content-Type', 'application/json');
	res.status(400).send(error);
}
app.use(errorHandler);

async_series([
	(done) => {
//		logger.info('Connecting to Database : ' + mongoDbUrl);
//		mongoose.connect(mongoDbUrl, { useNewUrlParser: true, useCreateIndex: true }); // useCreateIndex : https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=2ahUKEwj01KKn4M_hAhUCKewKHZu3C_EQFjAAegQIBBAB&url=https%3A%2F%2Fgithub.com%2FAutomattic%2Fmongoose%2Fissues%2F6890&usg=AOvVaw1LQ5-k1g-Sr9xz0RQKIKlE
		done();
	},
	(done) => {
		logger.info('Listening on port ' + conf.app.port);
		app.listen(conf.app.port);
		done();
	}
]);
module.exports = app; // for testing