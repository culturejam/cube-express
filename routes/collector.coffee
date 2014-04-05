cube = require("cube")
logger = require("logfmt")

module.exports = (app) ->
  logger.log(at: "info", msg: "Enabling Cube evaluator HTTP routes.")
  db = app.get('db')
  postEvent = (req, res) ->
    try
      putter = cube.event.putter(db)
      req.body.forEach(putter)
      res.send {}
    catch e
      logger.log msg: "Couldn't put events. Most likely user input error.", error: e
      res.send 400, { error: e.toString() }

  app.post '/1.0/event', postEvent
  app.post '/1.0/event/put', postEvent
