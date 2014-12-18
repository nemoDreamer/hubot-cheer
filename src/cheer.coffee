# Description:
#   Feeling depressed?
#
# Configuration:
#   None
#
# Commands:
#   hubot cheer me up - A little pick me up
#   sad/depressed/shame - Will react to triggers with some aww
#
# Author:
#   carllerche (original cheer)
#   eliperkins (original aww)
#   nemodreamer

url = require("url")

module.exports = (robot) ->

  comfort = [
    "There, there,... Let me cheer you up."
    "Oh no, what a shame...! I'm there for you, though..."
    "That's too bad. Let me change that:"
    "Oh really? Does this help?"
  ]

  robot.respond /cheer me up/i, (msg) ->
    aww msg

  robot.hear /(i('m| (am|was))|(it|this|that)('s| (is|was|makes))).*(sad|depress(ed|ing)|emo|shame)/i, (msg) ->
    msg.send msg.random comfort
    aww msg

  aww = (msg) ->
    msg
      .http('http://www.reddit.com/r/aww.json')
        .get() (err, res, body) ->
          response = JSON.parse(body).data.children
          raw_url  = msg.random(response).data.url

          # attempt to parse
          parsed_url = url.parse(raw_url)
          if parsed_url.host == "imgur.com"
            parsed_url.host = "i.imgur.com"
            parsed_url.pathname = parsed_url.pathname + ".jpg"
            raw_url = url.format(parsed_url)

          msg.send raw_url

  @yummy = 'yoyo'
