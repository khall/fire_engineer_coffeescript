(function() {

  describe('Pump: ', function() {
    describe('constructor: ', function() {
      it('should accept no hoses', function() {
        var p;
        p = new App.Pump(0, []);
        return expect(p.discharge.length).toEqual(0);
      });
      it('should accept 1 hose', function() {
        var p;
        p = new App.Pump(0, [new App.Valve(100, new App.Hose())]);
        expect(p.discharge.length).toEqual(1);
        return expect(p.discharge[0].pump).toEqual(p);
      });
      it('should accept 3 hoses', function() {
        var p;
        p = new App.Pump(0, [new App.Valve(100, new App.Hose()), new App.Valve(100, new App.Hose()), new App.Valve(100, new App.Hose())]);
        expect(p.discharge.length).toEqual(3);
        expect(p.discharge[0].pump).toEqual(p);
        expect(p.discharge[1].pump).toEqual(p);
        return expect(p.discharge[2].pump).toEqual(p);
      });
      return it('should accept 6 parameters', function() {
        var dv, iv, p;
        dv = new App.Valve();
        iv = new App.Valve();
        p = new App.Pump(100, [dv], [iv], 500, 350, 145);
        expect(p.idle_percentage).toEqual(100);
        expect(p.discharge[0]).toEqual(dv);
        expect(p.intake[0]).toEqual(iv);
        expect(p.tank).toEqual(500);
        expect(p.max_pressure).toEqual(350);
        return expect(p.relief_valve).toEqual(145);
      });
    });
    describe('pressure: ', function() {
      it('should set pressure to 0 if idle percentage is 0 with no discharge', function() {
        var p;
        p = new App.Pump(0, []);
        return expect(p.pressure()).toEqual(0);
      });
      it('should set pressure to 300 if idle percentage is 100', function() {
        var p;
        p = new App.Pump(100, [], [], 1000, 300);
        return expect(p.pressure()).toEqual(300);
      });
      return it('should set pressure to 150 if idle percentage is 50', function() {
        var p;
        p = new App.Pump(50, [], [], 1000, 300);
        return expect(p.pressure()).toEqual(150);
      });
    });
    describe('totalIntakePressue: ', function() {
      it('should add a single intake so it equals its own pressure', function() {
        var hydrant, p;
        hydrant = new App.Hydrant(60, 100);
        p = new App.Pump(50, [], [hydrant]);
        return expect(p.totalIntakePressure()).toEqual(60);
      });
      return it('should add two intakes so it equals its own pressure', function() {
        var hydrant1, hydrant2, p;
        hydrant1 = new App.Hydrant(60, 100);
        hydrant2 = new App.Hydrant(55, 100);
        p = new App.Pump(50, [], [hydrant1, hydrant2]);
        return expect(p.totalIntakePressure()).toEqual(115);
      });
    });
    return describe('process water loss', function() {
      return it('should drain tank after a second', function() {
        var p;
        jasmine.Clock.useMock();
        p = new App.Pump(100, [new App.Valve(100, new App.Hose())], [], 1000);
        expect(p.tank).toEqual(1000);
        p.driveToPump();
        p.tankToPump();
        jasmine.Clock.tick(1000);
        return expect(p.tank).toBeLessThan(1000);
      });
    });
  });

}).call(this);
