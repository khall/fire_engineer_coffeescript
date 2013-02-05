(function() {

  App.Valve = (function() {

    function Valve(open_percentage, hose, pump) {
      if (open_percentage == null) {
        open_percentage = 0;
      }
      if (hose == null) {
        hose = null;
      }
      if (pump == null) {
        pump = null;
      }
      this.open_percentage = open_percentage;
      if (hose !== null) {
        hose.valve = this;
      }
      this.hose = hose;
      this.pump = pump;
      this.flow_interval = null;
    }

    Valve.prototype.setOpenPercentage = function(percent) {
      var _this = this;
      if (percent > 100) {
        percent = 100;
      }
      if (percent < 0) {
        percent = 0;
      }
      this.open_percentage = percent;
      if (this.flow_interval) {
        clearInterval(this.flow_interval);
      }
      return this.flow_interval = setInterval(function() {
        return _this.pump.tank -= _this.hose.gallons_per_second();
      }, 1000);
    };

    Valve.prototype.pressureOut = function() {
      var po;
      po = (this.open_percentage / 100.0) * this.pump.pressure();
      return parseFloat(po.toFixed(3));
    };

    Valve.prototype.toStr = function(with_pump) {
      var hose_str, pump;
      if (with_pump == null) {
        with_pump = false;
      }
      hose_str = this.hose.toStr();
      pump = with_pump ? ",pump:" + this.pump.toStr() : "";
      return "open_percentage:" + this.open_percentage + ",hose:" + hose_str + pump;
    };

    return Valve;

  })();

}).call(this);
