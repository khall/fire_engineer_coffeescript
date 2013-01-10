(function() {

  describe('Valve: ', function() {
    describe('constructor: ', function() {
      return it('should accept three parameters', function() {
        var h, p, v;
        p = new App.Pump();
        h = new App.Hose();
        v = new App.Valve(23, h, p);
        expect(v.open_percentage).toEqual(23);
        expect(v.hose).toEqual(h);
        return expect(v.pump).toEqual(p);
      });
    });
    return describe('pressure out', function() {
      var pump, v;
      pump = null;
      v = null;
      beforeEach(function() {
        pump = new App.Pump();
        v = new App.Valve(0, new App.Hose(), pump);
        return pump.idle_percentage = 40;
      });
      it('should return 0 when the valve is closed', function() {
        return expect(v.pressureOut()).toEqual(0);
      });
      it('should return 60 when the valve is half opened', function() {
        v.open_percentage = 50;
        return expect(v.pressureOut()).toEqual(60);
      });
      return it('should return 120 when the valve is fully opened', function() {
        v.open_percentage = 100;
        return expect(v.pressureOut()).toEqual(120);
      });
    });
  });

}).call(this);
