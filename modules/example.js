/**
 * Example module for Hoggle IRC bot for UtahJS User Group
 */

// All modules must export a function that accepts a bot instance
module.exports = function(bot) {

  // Define routes for hoggle based on text in the IRC channel
  bot.route('Hello hoggle', function(res) {
   this.say(res.channel, 'Well hello there ' + res.nick + '!');
  });

  bot.route('did you just auto deploy from travis ci', function(res) {
   this.say(res.channel, 'YES I DID! Because I am master of the univers...');
  });

};