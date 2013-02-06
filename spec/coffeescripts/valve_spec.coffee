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
      pump = new App.Pump(40, [], [], 1000, 300)
      v = new App.Valve(0, new App.Hose(), pump)

    it 'should return 0 when the valve is closed', ->
      expect(v.pressureOut()).toEqual 0

    it 'should return 60 when the valve is half opened', ->
      v.setOpenPercentage(50)
      expect(v.pressureOut()).toEqual 60

    it 'should return 120 when the valve is fully opened', ->
      v.setOpenPercentage(100)
      expect(v.pressureOut()).toEqual 120

  describe 'setOpenPercentage', ->
    pump = null
    v = null

    beforeEach ->
      pump = new App.Pump(40, [], [], 1000)
      v = new App.Valve(0, new App.Hose(), pump)

    it 'should open the valve 50 percent', ->
      v.setOpenPercentage(50)
      expect(v.open_percentage).toEqual 50

    it 'should open the valve 100 percent', ->
      v.setOpenPercentage(100)
      expect(v.open_percentage).toEqual 100

    it 'should open the valve 0 percent', ->
      v.setOpenPercentage(0)
      expect(v.open_percentage).toEqual 0

    it 'should not open the valve to 110 percent', ->
      v.setOpenPercentage(110)
      expect(v.open_percentage).toEqual 100

    it 'should not open the valve to -10 percent', ->
      v.setOpenPercentage(-10)
      expect(v.open_percentage).toEqual 0