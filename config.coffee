module.exports =
  basicAuthPass: process.env.BASIC_AUTH_PASS || false
  basicAuthUser: process.env.BASIC_AUTH_USER || false
  enableCollector: process.env.ENABLE_COLLECTOR
  enableEvaluator: process.env.ENABLE_EVALUATOR
  mongoUrl: process.env.MONGODB_URL
  port: process.env.PORT || 5000


  # Truthiness.
  is: (value) ->
    return false if !value?
    return false if !value
    switch value
      when "false", "FALSE", "0", "off", "OFF", "no", "NO" then false
      else true

