(function() {

  describe('Hose: ', function() {
    describe('constructor: ', function() {
      return it('should accept six parameters', function() {
        var h, v;
        v = new App.Valve();
        h = new App.Hose(150, 2.5, 25, 250, v, '15/16');
        expect(h.distance).toEqual(150);
        expect(h.diameter).toEqual(2.5);
        expect(h.elevation).toEqual(25);
        expect(h.max_pressure).toEqual(250);
        expect(h.valve).toEqual(v);
        expect(h.nozzle_str).toEqual('15/16');
        return expect(h.nozzle_float).toEqual(15 / 16);
      });
    });
    describe('friction loss: ', function() {
      it('should determine loss with 300 feet 2.5" 120 psi with 15/16" smooth bore tip', function() {
        var fl, h, v;
        v = new App.Valve(100, null, new App.Pump(120));
        h = new App.Hose(300, 2.5, 0, 300, v, '15/16');
        fl = h.friction_loss();
        return expect(fl).toEqual(20.314);
      });
      it('should determine loss with 200 feet 1.75" 100 psi with a 1" smooth bore tip', function() {
        var fl, h, v;
        v = new App.Valve(100, null, new App.Pump(100));
        h = new App.Hose(200, 1.75, 0, 300, v, '1');
        fl = h.friction_loss();
        return expect(fl).toEqual(135.411);
      });
      return it('should determine loss with 100 feet 1" 0 psi with 1/4" smooth bore tip', function() {
        var fl, h, v;
        v = new App.Valve(100, null, new App.Pump(0));
        h = new App.Hose(100, 1, 0, 300, v, '1/4');
        fl = h.friction_loss();
        return expect(fl).toEqual(2.535);
      });
    });
    describe('appliance loss: ', function() {
      return it('should be zero for now', function() {
        var al, h;
        h = new App.Hose();
        al = h.appliance_loss();
        return expect(al).toEqual(0);
      });
    });
    describe('elevation loss: ', function() {
      it('should lose 20psi for a elevation gain of 40\'', function() {
        var el, h;
        h = new App.Hose(0, 0, 40);
        el = h.elevation_loss();
        return expect(el).toEqual(17.36);
      });
      return it('should gain 20psi for a elevation loss of 30\'', function() {
        var el, h;
        h = new App.Hose(0, 0, -30);
        el = h.elevation_loss();
        return expect(el).toEqual(-13.02);
      });
    });
    describe('total pressure loss', function() {
      return it('should lose 178.811 pressure for 100 feet of 1.75" with 10 feet elevation gain at 100 psi with 100 feet elevation gain', function() {
        var h, v;
        v = new App.Valve(100, null, new App.Pump(100));
        h = new App.Hose(200, 1.75, 100, 300, v, '1');
        return expect(h.total_pressure_loss()).toEqual(178.811);
      });
    });
    describe('gallons per minute', function() {
      return it('should return 184 gpm for 100 feet of 1.75" hose with a 15/16 smooth bore tip', function() {
        var h, v;
        v = new App.Valve(100, null, new App.Pump(33.3333));
        h = new App.Hose(100, 1.75, 0, 300, v, '15/16');
        return expect(h.gallons_per_minute()).toEqual(179.95);
      });
    });
    describe('nozzle pressure', function() {
      return it('should return 50 psi for 0 feet of hose with 50 psi at pump', function() {
        var h, v;
        v = new App.Valve(100, null, new App.Pump(16.6667));
        h = new App.Hose(0, 1.75, 0, 300, v, '15/16');
        return expect(h.nozzle_pressure()).toEqual(50);
      });
    });
    describe('determine pressure needed for a given gallons per minute', function() {
      return it('should return 45.347 for 200gpm', function() {
        var h, np, v;
        v = new App.Valve(100, null, new App.Pump(0));
        h = new App.Hose(100, 1.75, 0, 300, v, '1');
        np = h.pressure_for_gpm(200);
        return expect(np).toEqual(45.347);
      });
    });
    return describe('desired nozzle pressure', function() {
      return it('should return 50 for a smooth bore nozzle', function() {
        var h;
        h = new App.Hose(100, 1.75, 0, 300, v, '15/16');
        return h.desiredNozzlePressure();
      });
    });
  });

}).call(this);
