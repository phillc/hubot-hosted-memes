# Description
#   A hubot script that generates memes
#
# Notes:
#
# Configuration:
#   HUBOT_MEME_URL or HEROKU_URL: required
#
# URLs:
#
# Commands:
#   hubot Iron Price <text> - To get <text>? Pay the iron price!
#   hubot Brace yourself <text> - Ned Stark braces for <text>
#   hubot All your <text> are belong to <text> - All your <text> are belong to <text>
#
# Author:
#   phillc - Phillip Campbell

module.exports = (robot) ->
  fs = require('fs')
  gm = require('gm').subClass({imageMagick: true})
  path = require('path')
  os = require('os')
  util = require('util')
  # tmpDir = path.join(os.tmpDir(), 'meme-cache')

  memeUrl = process.env.HUBOT_MEME_URL or process.env.HEROKU_URL
  if memeUrl and not memeUrl.match(/\/$/)
    memeUrl = "#{memeUrl}/"

  unless memeUrl?
    robot.logger.error "hubot-hosted-memes included, but missing HUBOT_MEME_URL."
    return

  wordWrap = (str, col=10) ->
    regex = ".{1,#{col}}(\\s|$)|\\S+?(\\s|$)"
    str.match(RegExp(regex, 'g')).join("\n")

  robot.router.get '/meme/:imageName', (req, res) ->
    upperText = req.query.upper_text
    lowerText = req.query.lower_text
    imageName = req.params.imageName

    image = gm(path.resolve(__dirname, "images", imageName))

    drawText = ({image, text, size, gravity}) ->
      [scale, wrap] = switch
        when text.length < 10 then [1.0, 10]
        when text.length < 24 then [0.7, 15]
        when text.length < 48 then [0.5, 20]
        else [0.4, 25]

      image
        .font(path.resolve(__dirname, "fonts", "Impact.ttf"))
        .pointSize(scale * size.width / 5.0)
        .stroke("black", scale * size.width / 150.0)
        .fill("white")
        .gravity(gravity)
        .drawText(0, 0, wordWrap(text, wrap))

    image.size (err, size) ->
      if upperText?
        drawText
          image: this
          size: size
          gravity: "North"
          text: upperText

      if lowerText?
        drawText
          image: this
          size: size
          gravity: "South"
          text: lowerText

      this
        .stream (err, stdout, stderr) ->
          console.log err if err
          stderr.pipe(process.stderr)
          stdout.pipe(res)

    # writeStream = fs.createWriteStream(path.join(tmpDir, )

    # stream.pipe(res)
    # stream.pipe(writeStream)

  #   hubot Y U NO <text> - Generates the Y U NO GUY with the bottom caption of <text>
  #   hubot I don't always <something> but when i do <text> - Generates The Most Interesting man in the World
  #   hubot <text> (SUCCESS|NAILED IT) - Generates success kid with the top caption of <text>
  #   hubot <text> ALL the <things> - Generates ALL THE THINGS
  #   hubot <text> TOO DAMN <high> - Generates THE RENT IS TOO DAMN HIGH guy
  #   hubot Yo dawg <text> so <text> - Generates Yo Dawg
  #   hubot If <text>, <word that can start a question> <text>? - Generates Philosoraptor
  #   hubot <text>, BITCH PLEASE <text> - Generates Yao Ming
  #   hubot <text>, COURAGE <text> - Generates Courage Wolf
  #   hubot ONE DOES NOT SIMPLY <text> - Generates Boromir
  #   hubot IF YOU <text> GONNA HAVE A BAD TIME - Ski Instructor
  #   hubot IF YOU <text> TROLLFACE <text> - Troll Face
  #   hubot Aliens guy <text> - Aliens guy weighs in on something
  #   hubot Not sure if <something> or <something else> - Generates a Futurama Fry meme
  #   hubot <text>, AND IT'S GONE - Bank Teller
  #   hubot WHAT IF I TOLD YOU <text> - Morpheus What if I told you

  # robot.respond /Y U NO (.+)/i, (msg) ->
  #   memeGenerator msg, 'y-u-no.jpg', 'Y U NO', msg.match[1], (url) ->
  #     msg.send url

  robot.respond /iron price (.+)/i, (msg) ->
    memeGenerator msg, 'iron-price.jpg', msg.match[1], 'Pay the iron price', (url) ->
      msg.send url

  # robot.respond /aliens guy (.+)/i, (msg) ->
  #   memeGenerator msg, 'aliens.jpg', msg.match[1], '', (url) ->
  #     msg.send url

  robot.respond /brace yourself (.+)/i, (msg) ->
    memeGenerator msg, 'brace-yourself.jpg', 'Brace Yourself', msg.match[1], (url) ->
      msg.send url

  # robot.respond /(.*) (ALL the .*)/i, (msg) ->
  #   memeGenerator msg, 'all-the-things.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(I DON'?T ALWAYS .*) (BUT WHEN I DO,? .*)/i, (msg) ->
  #   memeGenerator msg, 'most-interesting.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(.*)(SUCCESS|NAILED IT.*)/i, (msg) ->
  #   memeGenerator msg, 'success-kid.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(.*) (\\w+\\sTOO DAMN .*)/i, (msg) ->
  #   memeGenerator msg, 'too-damn-high.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(NOT SURE IF .*) (OR .*)/i, (msg) ->
  #   memeGenerator msg, 'fry.png', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(YO DAWG .*) (SO .*)/i, (msg) ->
  #   memeGenerator msg, 'xzibit.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  robot.respond /(All your .*) (are belong to .*)/i, (msg) ->
    memeGenerator msg, 'all-your-base.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  # robot.respond /(.*)\\s*BITCH PLEASE\\s*(.*)/i, (msg) ->
  #   memeGenerator msg, 'yao-ming.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(.*)\\s*COURAGE\\s*(.*)/i, (msg) ->
  #   memeGenerator msg, 'courage-wolf.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /ONE DOES NOT SIMPLY (.*)/i, (msg) ->
  #   memeGenerator msg, 'boromir.jpg', 'ONE DOES NOT SIMPLY', msg.match[1], (url) ->
  #     msg.send url

  # robot.respond /(IF YOU .*\\s)(.* GONNA HAVE A BAD TIME)/i, (msg) ->
  #   memeGenerator msg, 'bad-time.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(.*)TROLLFACE(.*)/i, (msg) ->
  #   memeGenerator msg, 'troll-face.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /(IF .*), ((ARE|CAN|DO|DOES|HOW|IS|MAY|MIGHT|SHOULD|THEN|WHAT|WHEN|WHERE|WHICH|WHO|WHY|WILL|WON\\'T|WOULD)[ \\'N].*)/i, (msg) ->
  #   memeGenerator msg, 'philosoraptor.jpg', msg.match[1], msg.match[2] + (if msg.match[2].search(/\\?$/)==(-1) then '?' else ''), (url) ->
  #     msg.send url

  # robot.respond /(.*)(AND IT\\'S GONE.*)/i, (msg) ->
  #   memeGenerator msg, 'and-its-gone.jpg', msg.match[1], msg.match[2], (url) ->
  #     msg.send url

  # robot.respond /WHAT IF I TOLD YOU (.*)/i, (msg) ->
  #   memeGenerator msg, 'what-if-i-told-you', 'WHAT IF I TOLD YOU', msg.match[1], (url) ->
  #     msg.send url

  memeGenerator = (msg, imageName, text1, text2, callback) ->
    callback "#{memeUrl}meme/#{imageName}?upper_text=#{encodeURIComponent(text1)}&lower_text=#{encodeURIComponent(text2)}"

