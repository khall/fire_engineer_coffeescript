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
    describe('pressure out', function() {
      var pump, v;
      pump = null;
      v = null;
      beforeEach(function() {
        pump = new App.Pump(40, [], [], 1000, 300);
        return v = new App.Valve(0, new App.Hose(), pump);
      });
      it('should return 0 when the valve is closed', function() {
        return expect(v.pressureOut()).toEqual(0);
      });
      it('should return 60 when the valve is half opened', function() {
        v.setOpenPercentage(50);
        return expect(v.pressureOut()).toEqual(60);
      });
      return it('should return 120 when the valve is fully opened', function() {
        v.setOpenPercentage(100);
        return expect(v.pressureOut()).toEqual(120);
      });
    });
    return describe('setOpenPercentage', function() {
      var pump, v;
      pump = null;
      v = null;
      beforeEach(function() {
        pump = new App.Pump(40, [], [], 1000);
        return v = new App.Valve(0, new App.Hose(), pump);
      });
      it('should open the valve 50 percent', function() {
        v.setOpenPercentage(50);
        return expect(v.open_percentage).toEqual(50);
      });
      it('should open the valve 100 percent', function() {
        v.setOpenPercentage(100);
        return expect(v.open_percentage).toEqual(100);
      });
      it('should open the valve 0 percent', function() {
        v.setOpenPercentage(0);
        return expect(v.open_percentage).toEqual(0);
      });
      it('should not open the valve to 110 percent', function() {
        v.setOpenPercentage(110);
        return expect(v.open_percentage).toEqual(100);
      });
      return it('should not open the valve to -10 percent', function() {
        v.setOpenPercentage(-10);
        return expect(v.open_percentage).toEqual(0);
      });
    });
  });

}).call(this);
