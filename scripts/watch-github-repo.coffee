# HUBOT_GITHUB_URL environment variable for github api url.
# HUBOT_GITHUB_USERNAME Username or organization to which the repo belongs.
# HUBOT_GITHUB_WATCH_REPO Repository to watch events for.

HUBOT_GITHUB_URL = process.env.HUBOT_GITHUB_URL
HUBOT_GITHUB_USERNAME = process.env.HUBOT_GITHUB_USERNAME
HUBOT_GITHUB_WATCH_REPO = process.env.HUBOT_GITHUB_WATCH_REPO
# Path for use in https.request
HUBOT_GITHUB_ORG_URL = "/repos/#{HUBOT_GITHUB_USERNAME}/#{HUBOT_GITHUB_WATCH_REPO}"

# Use Node's http library for making requests.
https = require 'https'
# Use Node's FileSystem library for working with files.
fs = require 'fs'
path = require 'path'
# Create a handler for our file that keeps track of the last update Date
# from Github's API.
updateLogPath = __dirname + '/update.json'
# Room to announce updates to
announceRoom = "#utahjs"

# Parameters: None
# Sends a request to Github's repo api.
# Calls askGithub to parse the response and act upon it.
# Returns nothing.
checkUp = (robot)->
  options =
    host: HUBOT_GITHUB_URL
    path: HUBOT_GITHUB_ORG_URL
  https.get options, (res) ->
    data = ''
    res.on 'data', (chunk)->
      data += chunk
    res.on 'end', ->
      askGithub(JSON.parse(data), robot)

# Parameters: Data sent from a request to the Github repo api parsed
# from Json
# Opens a file that keeps track of the last update Date on the repo.
# if the "update date" in data is newer than the last update in the file
# The Contents of the file is overwritten with the latest update contained in
# the data object.
askGithub = (data, robot) ->
  if data.message == "not found"
    throw Error "Invalid Response from Github API, check your URL settings"
  exists = path.existsSync updateLogPath    
  if not exists
    console.log "Attempting to create the update.json file for github repository watching..."
    fs.writeFileSync updateLogPath , JSON.stringify(data), 'utf8'
  oldChangeDate = fs.readFileSync updateLogPath, 'utf8'
  latestChangeDate = data.updated_at.toString()
  oldChangeDate = new Date JSON.parse(oldChangeDate).updated_at
  latestChangeDate = new Date latestChangeDate
  if latestChangeDate > oldChangeDate
    message = "HUBOT_GITHUB: A new commit was pushed to #{HUBOT_GITHUB_USERNAME}/#{HUBOT_GITHUB_WATCH_REPO}"
    robot.send {room : announceRoom}, message
    fs.writeFile updateLogPath, JSON.stringify(data), (err)->
      if err
        console.log err



module.exports = (robot) ->
  # Must be self executing and anonymous
  do f = () ->
    # Check every 3 seconds for an update.
    setInterval ->
      checkUp robot
    , 3000


