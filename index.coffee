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
# Author:
#   Phillip Campbell

module.exports = (robot) ->
  fs = require('fs')
  gm = require('gm').subClass({imageMagick: true})
  path = require('path')
  os = require('os')
  # tmpDir = path.join(os.tmpDir(), 'meme-cache')

  memeUrl = process.env.HUBOT_MEME_URL or process.env.HEROKU_URL
  if keepaliveUrl and not keepaliveUrl.match(/\/$/)
    keepaliveUrl = "#{keepaliveUrl}/"

  unless memeUrl?
    robot.logger.error "hubot-hosted-memes included, but missing HUBOT_MEME_URL."
    return

  # robot.logger.info "Tmpdir: #{tmpDir}"

  robot.router.get '/meme/:imageName', (req, res) ->
    upperText = req.query.upper_text
    lowerText = req.query.lower_text
    imageName = req.params.imageName

    robot.logger.info "request: #{imageName} - #{upperText} / #{lowerText}"

    image = gm(path.resolve(__dirname, "images", imageName))

    if upperText?
      image
        .font(path.resolve(__dirname, "fonts", "Impact.ttf"), 50)
        .out("+antialias")
        .stroke("black", 3)
        .fill("white")
        .gravity("North")
        .drawText(10, 50, upperText)
      # .fontSize(68)
      # .pointSize(50)

    if lowerText?
      image
        .font(path.resolve(__dirname, "fonts", "Impact.ttf"), 50)
        .out("+antialias")
        .stroke("black", 3)
        .fill("white")
        .gravity("South")
        .drawText(10, 50, lowerText)

    image
      .stream (err, stdout, stderr) ->
        console.log err if err
        stderr.pipe(process.stderr)
        stdout.pipe(res)

    # res.send "OK"


    # writeStream = fs.createWriteStream(path.join(tmpDir, )

    # stream.pipe(res)
    # stream.pipe(writeStream)


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
    callback "#{memeUrl}/meme/#{imageName}?upper_text=#{encodeURIComponent(text1)}&lower_text=#{encodeURIComponent(text2)}"

