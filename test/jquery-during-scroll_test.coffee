'use strict'

describe 'module duringScroll', ->
  it 'sanity check', ->
    expect( true ).toBe true

  it 'returns an interval reference', ->
    reference = jQuery.duringScroll({})
    expect( typeof reference ).toBe 'number'
    clearInterval(reference)

  describe 'when AMD modules are present', ->
    it 'exposes itself as an AMD module', ->
      expect( window.define ).toHaveBeenCalled()

  describe 'when CommonJS modules are present', ->
    it 'exposes itself as a CommonJS module', ->
      expect( window.module.exports ).toBeDefined()

  describe 'when jQuery is defined', ->
    it 'exposes itself in the jQuery namespace', ->
      expect( jQuery.duringScroll ).toBeDefined()

  describe 'when any other module systems are detected', ->
    it 'does not expose itself globally', ->
      expect( typeof window.duringScroll ).toBe 'undefined'


  describe 'API options', ->
    describe '#interval', ->
      it 'alters the frequency at which the script is invoked', (done) ->
        spy = jasmine.createSpyObj('spy', ['fakeHandler'])
        options =
          always: spy.fakeHandler,
          interval: 200
        reference = jQuery.duringScroll options
        setTimeout ->
          clearInterval(reference)

          expect( spy.fakeHandler.calls.count() ).toBe 5

          done()
        , 1050

  #   describe '#always', ->
  #     it 'alters the frequency at which the script is invoked', ->
  #       expect( fakeHandler.calls.count ).toBe 5

  #   describe '#scrollStart', ->
  #     it 'alters the frequency at which the script is invoked', ->
  #       expect( fakeHandler.calls.count ).toBe 5

  #   describe '#duringScroll', ->
  #     it 'alters the frequency at which the script is invoked', ->
  #       expect( fakeHandler.calls.count ).toBe 5

  #   describe '#afterScroll', ->
  #     it 'alters the frequency at which the script is invoked', ->
  #       expect( fakeHandler.calls.count ).toBe 5
