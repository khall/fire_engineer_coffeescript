(function() {

  App.Pump = (function() {

    function Pump(idle_percentage, discharge, intake, tank, max_pressure, relief_valve) {
      var valve, _i, _len;
      if (idle_percentage == null) {
        idle_percentage = 0;
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
      if (relief_valve == null) {
        relief_valve = 160;
      }
      this.idle_percentage = idle_percentage;
      for (_i = 0, _len = discharge.length; _i < _len; _i++) {
        valve = discharge[_i];
        valve.pump = this;
      }
      this.discharge = discharge;
      this.intake = intake;
      this.tank = tank;
      this.max_pressure = max_pressure;
      this.relief_valve = relief_valve;
      this.tank_to_pump = false;
      this.tank_fill = false;
    }

    Pump.prototype.pressure = function() {
      return (this.idle_percentage / 100.0) * this.max_pressure;
    };

    Pump.prototype.setPressure = function(desired_pressure) {
      return this.idle_percentage = this.max_pressure / parseFloat(desired_pressure);
    };

    Pump.prototype.totalIntakePressure = function() {
      var i, pressure, _i, _len, _ref;
      pressure = 0;
      _ref = this.intake;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        pressure += i.pressure;
      }
      return pressure;
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
      return "pressure:" + this.pressure() + discharge_str + intake_str + "],tank:" + this.tank + ",max_pressure:" + this.max_pressure + ",relief_valve:" + this.relief_valve;
    };

    return Pump;

  })();

}).call(this);
