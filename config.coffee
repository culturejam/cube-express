module.exports =
  basicAuthPass: process.env.BASIC_AUTH_PASS || false
  basicAuthUser: process.env.BASIC_AUTH_USER || false
  mongoUrl: process.env.MONGODB_URL
  port: process.env.PORT || 5000
