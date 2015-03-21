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
    beforeEach ->
      jasmine.clock().install()

    afterEach ->
      jasmine.clock().uninstall()

    describe '#interval', ->
      it 'alters the frequency at which the script is invoked', ->
        spy = jasmine.createSpyObj('spy', ['fakeHandler'])
        options =
          always: spy.fakeHandler,
          interval: 200
        reference = jQuery.duringScroll options

        jasmine.clock().tick(1050)

        clearInterval(reference)
        expect( spy.fakeHandler.calls.count() ).toBe 5

    describe '#always', ->
      it 'gets invoked every interval no matter what', ->
        spy = jasmine.createSpyObj('spy', ['fakeHandler'])
        options =
          always: spy.fakeHandler,
          interval: 200
        reference = jQuery.duringScroll options

        jasmine.clock().tick(450)

        clearInterval(reference)
        expect( spy.fakeHandler.calls.count() ).toBe 2

    describe '#scrollStart', ->
      it 'only gets called when the user starts scrolling', ->
        spy = jasmine.createSpyObj('spy', ['fakeHandler'])
        options =
          scrollStart: spy.fakeHandler
        reference = jQuery.duringScroll options

        jasmine.clock().tick(450)

        expect( spy.fakeHandler.calls.count() ).toBe 0
        document.body.scrollTop = 150

        jasmine.clock().tick(200)

        clearInterval(reference)
        expect( spy.fakeHandler.calls.count() ).toBe 0

    describe '#duringScroll', ->
      it 'executes every interval while the user is scrolling', ->
        document.body.style.height = '5000px'

        spy = jasmine.createSpyObj('spy', ['fakeHandler'])
        options =
          duringScroll: spy.fakeHandler
        reference = jQuery.duringScroll options

        test_reference = setInterval ->
          document.body.scrollTop = document.body.scrollTop + 5
        , 5

        jasmine.clock().tick(290)

        clearInterval(test_reference)
        expect( spy.fakeHandler.calls.count() ).toBe 3

        # callback will get called one more time
        jasmine.clock().tick(100)

        spy.fakeHandler.calls.reset()

        jasmine.clock().tick(200)

        clearInterval(reference)
        expect( spy.fakeHandler.calls.count() ).toBe 0

    describe '#afterScroll', ->
      it 'executes only when the user has stopped scrolling', ->
        document.body.style.height = '5000px'

        spy = jasmine.createSpyObj('spy', ['fakeHandler'])
        options =
          afterScroll: spy.fakeHandler
        reference = jQuery.duringScroll options

        test_reference = setInterval ->
          document.body.scrollTop = document.body.scrollTop + 5
        , 5

        jasmine.clock().tick(290)

        expect( spy.fakeHandler.calls.count() ).toBe 0
        clearInterval(test_reference)

        jasmine.clock().tick(200)

        clearInterval(reference)
        expect( spy.fakeHandler.calls.count() ).toBe 1
