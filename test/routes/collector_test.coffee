request = require('supertest')
app = require('../../app')
server = app.server

describe "Collector route", ->

  before (done) -> app.start(done)

  describe "POST /1.0/event/put", ->
    it "returns 400 status when provided invalid JSON", (done) ->
      request(server).post('/1.0/event')
        .send("This ain't JSON.\n")
        .expect(400, done)

    it "returns 400 status when provided with JSON object", (done) ->
      request(server).post('/1.0/event')
        .send(type: "test", time: new Date())
        .expect(400, done)

    it "returns 400 status when provided a number", (done) ->
      request(server).post('/1.0/event')
        .send(JSON.stringify(42))
        .expect(400, done)

    it "returns 200 status when provided a JSON array", (done) ->
      request(server).post('/1.0/event')
        .send([{type: "test", time: new Date()}])
        .expect(200, done)

    it "returns 200 status when provided without a time", (done) ->
      request(server).post('/1.0/event')
        .send([{type: "test"}])
        .expect(200, done)
