# Generates help commands for Hubot.
#
# These commands are grabbed from comment blocks at the top of each file.
#
# help - Displays all of the help commands that Hubot knows about.
# help <query> - Displays all help commands that match <query>.

module.exports = (robot) ->
  robot.respond /help\s*(.*)?$/i, (msg) ->
    cmds = robot.helpCommands()
    if msg.match[1]
      cmds = cmds.filter (cmd) -> cmd.match(new RegExp(msg.match[1]))
    # User instances with rooms automatically go to the channel
    # Disabling this will stop the bot from flooding the channel every time
    # someone needs help.
    msg.message.user.room = false;
    msg.send cmds.join("\n")

