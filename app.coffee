require('coffee-script')
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

# App Configuration
app.configure ->
  app.set 'port', (process.env.PORT || 5000)
  app.set 'version', pkg.version
  app.use express.logger logFormat
  app.use express.json()
  app.use express.methodOverride()
  app.use express.responseTime()
  app.use requestid

#
# Routes
#
app.get '/', (req, res) -> res.send "Hello world."

#404 - Catch all
app.use (req, res) -> res.send 404, "Not found."

# Error handling
app.use (err, req, res, next) ->
  logger.error err.stack
  res.send 500


http.createServer(app).listen app.get('port'), () ->
  logger.info "at=server_start msg=\"Cube Express started.\" " +
              "version=#{app.get('version')} " +
              "port=#{app.get('port')} " +
              "environment=#{app.get('env')}"

module.exports = app
