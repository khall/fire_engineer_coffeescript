(function() {

  App.Scenario = (function() {

    function Scenario() {
      this.direct_factors = ['pump_pressure', 'release_valve'];
    }

    Scenario.prototype.easy = function() {
      var discharge, issues, num, num_hoses, num_issues, p, pump_answer_str, _i;
      num_issues = this.rand(2);
      num_hoses = this.rand(2) + 1;
      discharge = (function() {
        var _i, _results;
        _results = [];
        for (num = _i = 0; 0 <= num_hoses ? _i <= num_hoses : _i >= num_hoses; num = 0 <= num_hoses ? ++_i : --_i) {
          _results.push(new App.Valve(this.rand(101), new App.Hose(this.rand(10) * 50, 1.75, this.rand(51) * 5 - 125)));
        }
        return _results;
      }).call(this);
      p = new App.Pump(100, discharge, [], 500);
      pump_answer_str = p.toStr();
      issues = [];
      for (num = _i = 0; 0 <= num_issues ? _i <= num_issues : _i >= num_issues; num = 0 <= num_issues ? ++_i : --_i) {
        issues.push(this.direct_factors[this.rand(2)]);
      }
      if (issues.indexOf('pump_pressure') !== -1) {
        p.pressure *= this.rand(100) / 100.0;
      }
      if (issues.indexOf('release_valve') !== -1) {
        p.release_valve *= this.rand(100) / 100.0;
      }
      return [p, pump_answer_str];
    };

    Scenario.prototype.rand = function(upper_limit) {
      return Math.floor(Math.random() * upper_limit);
    };

    return Scenario;

  })();

}).call(this);
