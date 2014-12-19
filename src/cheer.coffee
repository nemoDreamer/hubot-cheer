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

  triggers = {
    actions: [
      /i('m| (am|was))/
      /(it|th(is|at))('s|.*(is|was|ma(kes|de)))/
    ]
    words: [
      /sad/
      /depress(ed|ing)/
      /\bemo/
      /\bshame/
    ]
  }

  trigger = new RegExp("(#{squash triggers.actions}).*(#{squash triggers.words})", 'i')

  robot.respond /cheer me up/i, (msg) ->
    aww msg

  robot.hear trigger, (msg) ->
    aww msg, true

  aww = (msg, lead = false) ->
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

          msg.send msg.random comfort if lead
          msg.send raw_url

# Helpers

squash = (array_of_regexps) ->
  (regexp.toString()[1...-1] for regexp in array_of_regexps).join '|'
