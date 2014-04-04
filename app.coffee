require('coffee-script')
cube      = require("cube")
express   = require('express')
http      = require('http')
logger    = require('winston')
pkg       = require('./package.json')
requestid = require('connect-requestid')
app       = express()

# Logger Configuration
express.logger.token 'request-id', (req, res) -> req.id
logFormat = 'at=request status=:status method=:method path=:url ' +
            'request-id=:request-id http-version=:http-version ' +
            'response-time=:response-time remote-addr=:remote-addr ' +
            'referrer=:referrer user-agent=":user-agent" ' +
            'bytes=:res[Content-Length]'

# CORS
allowCrossDomain = (req, res, next) ->
  res.header('Access-Control-Allow-Origin', "*")
  res.header('Access-Control-Allow-Headers', 'Content-Type')
  res.header('Access-Control-Allow-Headers', 'X-Requested-With')
  next()

# Connect to database and configure server.
options = "mongo-url": process.env.MONGODB_URL
cube.database.open options, (error, db) ->
  if error
    logger.error "Error connecting to MongoDB database.", error
  else
    # App Configuration
    app.configure ->
      app.set('db', db)
      app.set 'port', (process.env.PORT || 5000)
      app.set 'version', pkg.version
      app.use express.logger logFormat
      app.use express.json()
      app.use express.methodOverride()
      app.use express.responseTime()
      app.use requestid
      app.use allowCrossDomain

    # Routing
    require('./routes/collector')(app)
    require('./routes/evaluator')(app)

    #404 - Catch all
    app.use (req, res) -> res.send 404, "Not found."

    # Error handling
    app.use (err, req, res, next) ->
      logger.error err.stack
      res.send 500

    http.createServer(app).listen app.get('port'), () ->
      logger.info "Cube Express server started.",
        at: "server_start"
        version: app.get('version')
        port: app.get('port')
        environment: app.get('env')

module.exports = app
