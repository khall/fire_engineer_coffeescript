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
        expect(p.pressure).toEqual(100);
        expect(p.discharge[0]).toEqual(dv);
        expect(p.intake[0]).toEqual(iv);
        expect(p.tank).toEqual(500);
        expect(p.max_pressure).toEqual(350);
        return expect(p.release_valve).toEqual(145);
      });
    });
    return describe('adjust pressure: ', function() {
      var p;
      p = null;
      beforeEach(function() {
        return p = new App.Pump(100, [], [], null);
      });
      it('should raise pressure to 150', function() {
        expect(p.pressure).toEqual(100);
        p.adjustPressure(150);
        return expect(p.pressure).toEqual(150);
      });
      it('should lower pressure to 80', function() {
        expect(p.pressure).toEqual(100);
        p.adjustPressure(80);
        return expect(p.pressure).toEqual(80);
      });
      it('should raise pressure to 150 with 4 discharge lines open', function() {
        var discharge, valve, _i, _j, _len, _len1, _results;
        discharge = [new App.Valve(100, new App.Hose()), new App.Valve(100, new App.Hose()), new App.Valve(100, new App.Hose()), new App.Valve(100, new App.Hose())];
        p = new App.Pump(0, discharge, [], null);
        for (_i = 0, _len = discharge.length; _i < _len; _i++) {
          valve = discharge[_i];
          expect(valve.pressureOut()).toEqual(0);
        }
        p.adjustPressure(150);
        expect(p.pressure).toEqual(150);
        _results = [];
        for (_j = 0, _len1 = discharge.length; _j < _len1; _j++) {
          valve = discharge[_j];
          _results.push(expect(valve.pressureOut()).toEqual(150));
        }
        return _results;
      });
      return it('should raise pressure to 75 with 4 discharge lines half open', function() {
        var discharge, valve, _i, _j, _len, _len1, _results;
        discharge = [new App.Valve(50, new App.Hose()), new App.Valve(50, new App.Hose()), new App.Valve(50, new App.Hose()), new App.Valve(50, new App.Hose())];
        p = new App.Pump(0, discharge, [], null);
        for (_i = 0, _len = discharge.length; _i < _len; _i++) {
          valve = discharge[_i];
          expect(valve.pressureOut()).toEqual(0);
        }
        p.adjustPressure(150);
        expect(p.pressure).toEqual(150);
        _results = [];
        for (_j = 0, _len1 = discharge.length; _j < _len1; _j++) {
          valve = discharge[_j];
          _results.push(expect(valve.pressureOut()).toEqual(75));
        }
        return _results;
      });
    });
  });

}).call(this);
