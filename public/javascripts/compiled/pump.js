(function() {

  App.Pump = (function() {

    function Pump(pressure, discharge, intake, tank, max_pressure, release_valve) {
      var valve, _i, _len;
      if (pressure == null) {
        pressure = 0;
      }
      if (discharge == null) {
        discharge = [];
      }
      if (intake == null) {
        intake = [];
      }
      if (tank == null) {
        tank = null;
      }
      if (max_pressure == null) {
        max_pressure = 300;
      }
      if (release_valve == null) {
        release_valve = 160;
      }
      this.pressure = pressure;
      for (_i = 0, _len = discharge.length; _i < _len; _i++) {
        valve = discharge[_i];
        valve.pump = this;
      }
      this.discharge = discharge;
      this.intake = intake;
      this.tank = tank;
      this.max_pressure = max_pressure;
      this.release_valve = release_valve;
    }

    Pump.prototype.adjustPressure = function(new_pressure) {
      return this.pressure = new_pressure;
    };

    Pump.prototype.toStr = function() {
      var d, discharge_str, i, intake_str, _i, _j, _len, _len1, _ref, _ref1;
      discharge_str = ",discharge:[";
      _ref = this.discharge;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        d = _ref[_i];
        discharge_str += d.toStr() + ",";
      }
      discharge_str.substr(0, discharge_str - 1);
      intake_str = "],intake:[";
      _ref1 = this.intake;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        i = _ref1[_j];
        intake_str += i.toStr() + ",";
      }
      intake_str.substr(0, intake_str - 1);
      return "pressure:" + this.pressure + discharge_str + intake_str + "],tank:" + this.tank + ",max_pressure:" + this.max_pressure + ",release_valve:" + this.release_valve;
    };

    return Pump;

  })();

}).call(this);
