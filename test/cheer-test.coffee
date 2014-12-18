chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'cheer', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    cheer = require('../src/cheer')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/cheer me up/i)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/(i('m| (am|was))|(it|this|that)('s| (is|was|makes))).*(sad|depress(ed|ing)|emo|shame)/i)
