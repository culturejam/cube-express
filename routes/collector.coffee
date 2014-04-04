cube = require("cube")
logger = require('winston')

module.exports = (app) ->
  db = app.get('db')
  postEvent = (req, res) ->
    try
      putter = cube.event.putter(db)
      req.body.forEach(putter)
      res.send {}
    catch e
      logger.error "Error while putting event.", { error: e.toString() }
      res.send 400, { error: e.toString() }

  app.post '/1.0/event', postEvent
  app.post '/1.0/event/put', postEvent
