// xmas detector script
//
// hubot is it xmas ?  - returns whether is it christmas or not
// hubot is it christmas ?  - returns whether is it christmas or not
//

module.exports = function(robot) {
  robot.hear(/clintberry\s*(.*)?has joined #utahjs$/i, function(msg) {
    msg.send("Welcome back, master Clint.");
  });
}