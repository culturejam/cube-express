cube = require("cube")
logger = require("logfmt")

module.exports = (app) ->
  logger.log(at: "info", msg: "Enabling Cube evaluator HTTP routes.")
  db = app.get('db')
  endpoints = { ws: [], http: [] }
  handlers = cube.evaluator.register(db, endpoints)

  app.get '/1.0/event', handlers.eventGet
  app.get '/1.0/event/get', handlers.eventGet

  app.get '/1.0/metric', handlers.metricGet
  app.get '/1.0/metric/get', handlers.metricGet

  app.get '/1.0/types', handlers.typesGet
  app.get '/1.0/types/get', handlers.typesGet
