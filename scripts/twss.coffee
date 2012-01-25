twss = require('twss')

module.exports = (robot) ->
  robot.respond /twss\s*(.*)?$/i, (msg)->
   query = msg.message.text.split(" ")
   shesaid = ""
   for said in query
     if said not in query[0..1] 
       shesaid += said + " "
   username = msg.message.user.name
   if twss.is shesaid
     msg.send "@" + username + ": That's what she said."
   else
     msg.send "@" + username + ": That's not what she said."
