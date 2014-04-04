config = require('../config')

describe "config", ->

  describe "config.is", ->
    it "returns false for undefined values", ->
      config.is().should.be.false
    it "returns false for null", ->
      config.is(null).should.be.false
    it "returns false for false", ->
      config.is(false).should.be.false
    it "returns false for empty strings", ->
      config.is("").should.be.false
    it "returns false for falsey strings", ->
      config.is("false").should.be.false
      config.is("no").should.be.false
      config.is("off").should.be.false
      config.is("0").should.be.false
    it "returns true for true", ->
      config.is(true).should.be.true
    it "returns true for truthy strings", ->
      config.is("true").should.be.true
      config.is("1").should.be.true
      config.is("yes").should.be.true
      config.is("anything works").should.be.true

