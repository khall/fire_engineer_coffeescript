describe 'Hose: ', ->
  describe 'constructor: ', ->
    it 'should accept six parameters', ->
      v = new App.Valve()
      h = new App.Hose(150, 2.5, 25, 250, v, '15/16')
      expect(h.distance).toEqual 150
      expect(h.diameter).toEqual 2.5
      expect(h.elevation).toEqual 25
      expect(h.max_pressure).toEqual 250
      expect(h.valve).toEqual v
      expect(h.nozzle_str).toEqual '15/16'
      expect(h.nozzle_float).toEqual (15 / 16)

  describe 'friction loss: ', ->
    it 'should determine loss with 300 feet 2.5" 120 psi with 15/16" smooth bore tip', ->
      v = new App.Valve(100, null, new App.Pump(120))
      h = new App.Hose(300, 2.5, 0, 300, v, '15/16')
      fl = h.friction_loss()
      expect(fl).toEqual 20.314 # 20.3136

    it 'should determine loss with 200 feet 1.75" 100 psi with a 1" smooth bore tip', ->
      v = new App.Valve(100, null, new App.Pump(100))
      h = new App.Hose(200, 1.75, 0, 300, v, '1')
      fl = h.friction_loss()
      expect(fl).toEqual 135.411

    it 'should determine loss with 100 feet 1" 0 psi with 1/4" smooth bore tip', ->
      v = new App.Valve(100, null, new App.Pump(0))
      h = new App.Hose(100, 1, 0, 300, v, '1/4')
      fl = h.friction_loss()
      expect(fl).toEqual 2.535

  describe 'appliance loss: ', ->
    it 'should be zero for now', ->
      h = new App.Hose()
      al = h.appliance_loss()
      expect(al).toEqual(0)

  describe 'elevation loss: ', ->
    it 'should lose 20psi for a elevation gain of 40\'', ->
      h = new App.Hose(0, 0, 40)
      el = h.elevation_loss()
      expect(el).toEqual(17.36)

    it 'should gain 20psi for a elevation loss of 30\'', ->
      h = new App.Hose(0, 0, -30)
      el = h.elevation_loss()
      expect(el).toEqual(-13.02)

  describe 'total pressure loss', ->
    it 'should lose 178.811 pressure for 100 feet of 1.75" with 10 feet elevation gain at 100 psi with 100 feet elevation gain', ->
      v = new App.Valve(100, null, new App.Pump(100))
      h = new App.Hose(200, 1.75, 100, 300, v, '1')
      expect(h.total_pressure_loss()).toEqual 178.811

  describe 'gallons per minute', ->
    it 'should return 184 gpm for 100 feet of 1.75" hose with a 15/16 smooth bore tip', ->
      v = new App.Valve(100, null, new App.Pump(100))
      h = new App.Hose(100, 1.75, 0, 300, v, '15/16')
      expect(h.gallons_per_minute()).toEqual 179.95

  describe 'nozzle pressure', ->
    it 'should return 50 psi for 0 feet of hose with 50 psi at pump', ->
      v = new App.Valve(100, null, new App.Pump(50))
      h = new App.Hose(0, 1.75, 0, 300, v, '15/16')
      expect(h.nozzle_pressure()).toEqual 50

  describe 'determine pressure needed for a given gallons per minute', ->
    it 'should return 45.347 for 200gpm', ->
      v = new App.Valve(100, null, new App.Pump(0))
      h = new App.Hose(100, 1.75, 0, 300, v, '1')
      np = h.pressure_for_gpm(200)
      expect(np).toEqual 45.347