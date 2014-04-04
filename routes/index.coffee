cube = require("cube")
logger = require('winston')

module.exports = (app) ->

  postEvent = (req, res) ->
    try
      db = app.db
      putter = cube.event.putter(db)
      req.body.forEach(putter)
      res.send {}
    catch e
      logger.error "Error while putting event.", { error: e.toString() }
      res.send 400, { error: e.toString() }

  # Events
  app.post '/1.0/event', postEvent
  app.post '/1.0/event/put', postEvent

