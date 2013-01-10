describe 'Valve: ', ->
  describe 'constructor: ', ->
    it 'should accept three parameters', ->
      p = new App.Pump()
      h = new App.Hose()
      v = new App.Valve(23, h, p)
      expect(v.open_percentage).toEqual 23
      expect(v.hose).toEqual h
      expect(v.pump).toEqual p

  describe 'pressure out', ->
    pump = null
    v = null

    beforeEach ->
      pump = new App.Pump()
      v = new App.Valve(0, new App.Hose(), pump)
      pump.idle_percentage = 40

    it 'should return 0 when the valve is closed', ->
      expect(v.pressureOut()).toEqual 0

    it 'should return 60 when the valve is half opened', ->
      v.open_percentage = 50
      expect(v.pressureOut()).toEqual 60

    it 'should return 120 when the valve is fully opened', ->
      v.open_percentage = 100
      expect(v.pressureOut()).toEqual 120