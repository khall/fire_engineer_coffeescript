describe 'Pump: ', ->
  describe 'constructor: ', ->
    it 'should accept no hoses', ->
      p = new App.Pump(0, [])
      expect(p.discharge.length).toEqual 0

    it 'should accept 1 hose', ->
      p = new App.Pump(0, [new App.Valve(100, new App.Hose())])
      expect(p.discharge.length).toEqual 1
      expect(p.discharge[0].pump).toEqual p

    it 'should accept 3 hoses', ->
      p = new App.Pump(0, [new App.Valve(100, new App.Hose()),
                           new App.Valve(100, new App.Hose()),
                           new App.Valve(100, new App.Hose())])
      expect(p.discharge.length).toEqual 3
      expect(p.discharge[0].pump).toEqual p
      expect(p.discharge[1].pump).toEqual p
      expect(p.discharge[2].pump).toEqual p

    it 'should accept 6 parameters', ->
      dv = new App.Valve()
      iv = new App.Valve()
      p = new App.Pump(100, [dv], [iv], 500, 350, 145)
      expect(p.idle_percentage).toEqual 100
      expect(p.discharge[0]).toEqual dv
      expect(p.intake[0]).toEqual iv
      expect(p.tank).toEqual 500
      expect(p.max_pressure).toEqual 350
      expect(p.relief_valve).toEqual 145

  describe 'pressure: ', ->
    it 'should set pressure to 0 if idle percentage is 0 with no discharge', ->
      p = new App.Pump(0, [])
      expect(p.pressure()).toEqual 0

    it 'should set pressure to 300 if idle percentage is 100', ->
      p = new App.Pump(100, [], [], 1000, 300)
      expect(p.pressure()).toEqual 300

    it 'should set pressure to 150 if idle percentage is 50', ->
      p = new App.Pump(50, [], [], 1000, 300)
      expect(p.pressure()).toEqual 150

  describe 'totalIntakePressue: ', ->
    # TODO: ensure that these tests are actually correct

    it 'should add a single intake so it equals its own pressure', ->
      hydrant = new App.Hydrant(60, 100)
      p = new App.Pump(50, [], [hydrant])
      expect(p.totalIntakePressure()).toEqual 60

    it 'should add two intakes so it equals its own pressure', ->
      hydrant1 = new App.Hydrant(60, 100)
      hydrant2 = new App.Hydrant(55, 100)
      p = new App.Pump(50, [], [hydrant1, hydrant2])
      expect(p.totalIntakePressure()).toEqual 115

  describe 'process water loss', ->
    it 'should drain tank after a second', ->
      jasmine.Clock.useMock()
      p = new App.Pump(100, [new App.Valve(100, new App.Hose())], [], 1000)
      expect(p.tank).toEqual 1000
      p.driveToPump()
      p.tankToPump()
      jasmine.Clock.tick(1000)
      expect(p.tank).toBeLessThan 1000

  describe 'relief valve open', ->
    it 'should be true', ->
      p = new App.Pump(100, [new App.Valve(10)], [], 1000, 600, 59)
      expect(p.reliefValveOpen()).toEqual true

    it 'should be false', ->
      p = new App.Pump(100, [new App.Valve(10)], [], 1000, 600, 61)
      expect(p.reliefValveOpen()).toEqual false

    it 'should be false when at exact pressure', ->
      p = new App.Pump(100, [new App.Valve(10)], [], 1000, 600, 60)
      expect(p.reliefValveOpen()).toEqual false


#  describe 'adjust pressure: ', ->
#    p = null
#
#    beforeEach ->
#      p = new App.Pump(100, [], [], null)
#
#    it 'should raise pressure to 150', ->
#      expect(p.pressure).toEqual 100
#      p.adjustPressure(150)
#      expect(p.pressure).toEqual 150
#
#    it 'should lower pressure to 80', ->
#      expect(p.pressure).toEqual 100
#      p.adjustPressure(80)
#      expect(p.pressure).toEqual 80
#
#    it 'should raise pressure to 150 with 4 discharge lines open', ->
#      discharge = [new App.Valve(100, new App.Hose()),
#                   new App.Valve(100, new App.Hose()),
#                   new App.Valve(100, new App.Hose()),
#                   new App.Valve(100, new App.Hose())]
#      p = new App.Pump(0, discharge, [], null)
#      expect(valve.pressureOut()).toEqual(0) for valve in discharge
#      p.adjustPressure(150)
#      expect(p.pressure).toEqual 150
#      expect(valve.pressureOut()).toEqual(150) for valve in discharge
#
#    it 'should raise pressure to 75 with 4 discharge lines half open', ->
#      discharge = [new App.Valve(50, new App.Hose()),
#                   new App.Valve(50, new App.Hose()),
#                   new App.Valve(50, new App.Hose()),
#                   new App.Valve(50, new App.Hose())]
#      p = new App.Pump(0, discharge, [], null)
#      expect(valve.pressureOut()).toEqual(0) for valve in discharge
#      p.adjustPressure(150)
#      expect(p.pressure).toEqual 150
#      expect(valve.pressureOut()).toEqual(75) for valve in discharge