/**
 * Example module for Hoggle IRC bot for UtahJS User Group
 */

rw = require("random-words")

// All modules must export a function that accepts a bot instance
module.exports = function(bot) {
  bot.route('where is *?', function(res) {
    var name = res.splats[0].replace(/\W/g, '')
    this.say(res.channel, name + " is in the " + rw() + " " + rw() + ".");
  });
};
