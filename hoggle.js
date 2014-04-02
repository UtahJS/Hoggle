var Domo = require('domo-kun');
var nconf = require('nconf');
var http = require('http');

nconf.argv()
     .env()
     .file('config.json');


var config = {
   nick: 'hoggle',
   userName: 'hoggle',
   realName: 'Hoggle',
   address: 'irc.freenode.org',
   channels: ['#utahjs'],
   users: [
     {
       username: nconf.get('botadminuser'),
       password: nconf.get('botadminpass')
     }
   ],
   debug: true
};

var bot = new Domo(config);


// **** MODULES ****

var mod_example = require('./modules/example')(bot);


bot.connect();


// Webserver required for heroku
http.createServer(function (req, res) {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.write('Hi. I\'m Hoggle');
  res.end();
}).listen( process.env.PORT || 5000);