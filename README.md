# hubot-hosted-memes

A hubot script that allows hubot to host memes

* hubot (SUCH|MUCH|VERY) <text> (MUCH|SO|MANY) <text> - Much doge. So meme.
* hubot <text> (SUCCESS|NAILED IT) - Generates success kid with the top caption of <text>
* hubot <text> ALL the <things> - Generates ALL THE THINGS
* hubot <text> TOO DAMN <high> - Generates THE RENT IS TOO DAMN HIGH guy
* hubot <text>, AND IT'S GONE - Bank Teller
* hubot <text>, BITCH PLEASE <text> - Generates Yao Ming
* hubot <text>, COURAGE <text> - Generates Courage Wolf
* hubot Aliens guy <text> - Aliens guy weighs in on something
* hubot All your <text> are belong to <text> - All your <text> are belong to <text>
* hubot Brace yourself <text> - Ned Stark braces for <text>
* hubot I don't always <something> but when i do <text> - Generates The Most Interesting man in the World
* hubot IF YOU <text> GONNA HAVE A BAD TIME - Ski Instructor
* hubot IF YOU <text> TROLLFACE <text> - Troll Face
* hubot If <text>, <word that can start a question> <text>? - Generates Philosoraptor
* hubot Iron Price <text> - To get <text>? Pay the iron price!
* hubot Not sure if <something> or <something else> - Generates a Futurama Fry meme
* hubot ONE DOES NOT SIMPLY <text> - Generates Boromir
* hubot WHAT IF I TOLD YOU <text> - Morpheus What if I told you
* hubot Y U NO <text> - Generates the Y U NO GUY with the bottom caption of <text>
* hubot Yo dawg <text> so <text> - Generates Yo Dawg

## Installation

In hubot project repository, run:

`npm install hubot-hosted-memes --save`

Then add **hubot-hosted-memes** to your `external-scripts.json`:

```json
[
  "hubot-hosted-memes"
]
```

## Configuring

hubot-hosted-memes is configured by one of two environment variables:

* HUBOT_MEME_URL or HEROKU_URL - the url of where hubot can be accessed

## Credits

hubot-hosted-memes wouldn't be possible without the original hubot script, meme_captain by bobanj
