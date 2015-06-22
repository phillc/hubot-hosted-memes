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
  memeUrl = process.env.HUBOT_MEME_URL or process.env.HEROKU_URL
  if keepaliveUrl and not keepaliveUrl.match(/\/$/)
    keepaliveUrl = "#{keepaliveUrl}/"

  unless memeUrl?
    robot.logger.error "hubot-hosted-memes included, but missing HUBOT_MEME_URL."
    return

  memes = [
    {
      regex: /Y U NO (.+)/i,
      image: 'y-u-no.jpg'
    },
    {
      regex: /iron price (.+)/i,
      image: 'iron-price.jpg'
    },
    {
      regex: /aliens guy (.+)/i,
      image: 'aliens.jpg'
    },
    {
      regex: /brace yourself (.+)/i,
      image: 'brace-yourself.jpg'
    },
    {
      regex: /(.*) (ALL the .*)/i,
      image: 'all-the-things.jpg'
    },
    {
      regex: /(I DON'?T ALWAYS .*) (BUT WHEN I DO,? .*)/i,
      image: 'most-interesting.jpg'
    },
    {
      regex: /(.*)(SUCCESS|NAILED IT.*)/i,
      image: 'success-kid.jpg'
    },
    {
      regex: /(.*) (\w+\sTOO DAMN .*)/i,
      image: 'too-damn-high.jpg'
    },
    {
      regex: /(NOT SURE IF .*) (OR .*)/i,
      image: 'fry.png'
    },
    {
      regex: /(YO DAWG .*) (SO .*)/i,
      image: 'xzibit.jpg'
    },
    {
      regex: /(All your .*) (are belong to .*)/i,
      image: 'all-your-base.jpg'
    },
    {
      regex: /(.*)\s*BITCH PLEASE\s*(.*)/i,
      image: 'yao-ming.jpg'
    },
    {
      regex: /(.*)\s*COURAGE\s*(.*)/i,
      image: 'courage-wolf.jpg'
    },
    {
      regex: /ONE DOES NOT SIMPLY (.*)/i,
      image: 'boromir.jpg'
    },
    {
      regex: /(IF YOU .*\s)(.* GONNA HAVE A BAD TIME)/i,
      image: 'bad-time.jpg'
    },
    {
      regex: /(.*)TROLLFACE(.*)/i,
      image: 'troll-face.jpg'
    },
    {
      regex: /(IF .*), ((ARE|CAN|DO|DOES|HOW|IS|MAY|MIGHT|SHOULD|THEN|WHAT|WHEN|WHERE|WHICH|WHO|WHY|WILL|WON\'T|WOULD)[ \'N].*)/i,
      image: 'philosoraptor.jpg',
    },
    {
      regex: /(.*)(AND IT\'S GONE.*)/i,
      image: 'and-its-gone.jpg'
    },
    {
      regex: /WHAT IF I TOLD YOU (.*)/i,
      image: 'what-if-i-told-you.jpg'
    }
  ]


  # robot.logger.info "hubot-hosted-memes alive"
  # # robot.http("#{memUrl}/meme").post() (err, res, body) =>
  # #   if err?
  # #     robot.logger.info "keepalie pong: #{err}"
  # #     robot.emit 'error', err
  # #   else
  # #     robot.logger.info "keepalive pong: #{res.statusCode} #{body}"

  # # keepaliveCallback = (req, res) ->
  # #   res.set 'Content-Type', 'text/plain'
  # #   res.send 'OK'

  # # # keep this different from the legacy URL in httpd.coffee
  # # robot.router.post "/heroku/keepalive", keepaliveCallback
  # # robot.router.get "/heroku/keepalive", keepaliveCallback

  memeResponder = (robot, meme) ->
    robot.respond meme.regex, (msg) ->
      memeUrlGen msg, meme.image, msg.match[1], msg.match[2], (url) ->
        msg.send url

  memeUrlGen = (msg, image, text1, text2, callback) ->
    callback "#{memeUrl}/meme?image=#{image}&upper_text=#{encodeURIComponent(text1)}&lower_text=#{text2}"

  for meme in memes
    do (meme) ->
      memeResponder robot, meme

