/**
 * Example module for Hoggle IRC bot for UtahJS User Group
 */

rw = require("random-words")

// All modules must export a function that accepts a bot instance
module.exports = function(bot) {
  bot.route('where is :name?', function(res) {
    this.say(res.channel, res.params.name + " is in the " + rw() + " " + rw() + ".");
  });
};
