require('coffee-script')
config    = require("./config")
cube      = require("cube")
express   = require('express')
http      = require('http')
logger    = require('logfmt')
pkg       = require('./package.json')
requestid = require('connect-requestid')
app       = express()

# CORS
allowCrossDomain = (req, res, next) ->
  res.header('Access-Control-Allow-Origin', "*")
  res.header('Access-Control-Allow-Headers', 'Content-Type')
  res.header('Access-Control-Allow-Headers', 'X-Requested-With')
  next()

app.set 'port', config.port
app.set 'version', pkg.version
app.use logger.requestLogger()
app.use express.json()
app.use express.methodOverride()
app.use express.responseTime()
app.use requestid
app.use allowCrossDomain

# Basic auth
if config.basicAuthUser && config.basicAuthPass
  app.use express.basicAuth(config.basicAuthUser, config.basicAuthPass)

# Connect to database and configure server.
start = (callback) ->
  cube.database.open {"mongo-url": config.mongoUrl}, (error, db) ->
    if error
      logger.error new Error("Error connecting to MongoDB database."), error
    else
      app.set('db', db)

      # Routing
      require('./routes/collector')(app) if config.is(config.enableCollector)
      require('./routes/evaluator')(app) if config.is(config.enableEvaluator)

      #404 - Catch all
      app.use (req, res) -> res.send 404, "Not found."

      # Error handling
      app.use (err, req, res, next) ->
        logger.error err
        res.send 500

      http.createServer(app).listen app.get('port'), ->
        logger.log
          msg: "Cube Express server started."
          at: "server_start"
          version: app.get('version')
          port: app.get('port')
          environment: app.get('env')

      callback() if callback

module.exports = {server: app, start: start}
