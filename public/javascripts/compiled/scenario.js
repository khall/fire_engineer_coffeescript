(function() {

  App.Scenario = (function() {

    function Scenario() {
      this.direct_factors = ['pump_pressure', 'relief_valve'];
      this.answer_str = null;
      this.changes_needed = [];
      this.pump = null;
    }

    Scenario.prototype.easy = function() {
      var chosen_issues, count, df, discharge, issues, num, num_hoses, num_issues, p, _i;
      num_issues = this.rand(2);
      num_hoses = this.rand(2);
      discharge = (function() {
        var _i, _results;
        _results = [];
        for (num = _i = 0; 0 <= num_hoses ? _i <= num_hoses : _i >= num_hoses; num = 0 <= num_hoses ? ++_i : --_i) {
          _results.push(new App.Valve(this.rand(101), new App.Hose(this.rand(10) * 50, 1.75, this.rand(51) * 5 - 125)));
        }
        return _results;
      }).call(this);
      p = new App.Pump(100, discharge, [], 500);
      this.answer_str = p.toStr();
      issues = [];
      chosen_issues = [];
      for (num = _i = 0; 0 <= num_issues ? _i <= num_issues : _i >= num_issues; num = 0 <= num_issues ? ++_i : --_i) {
        count = 0;
        df = this.rand(this.direct_factors.length);
        while (chosen_issues.indexOf(df) !== -1 && count < 100) {
          df = this.rand(this.direct_factors.length);
          count++;
        }
        chosen_issues.push(df);
        issues.push(this.direct_factors[df]);
      }
      if (issues.indexOf('pump_pressure') !== -1) {
        this.changes_needed.push(['pump pressure', p.pressure()]);
        p.setPressure(parseInt(p.pressure() * this.rand(100) / 100.0));
      }
      if (issues.indexOf('relief_valve') !== -1) {
        this.changes_needed.push(['relief valve', p.relief_valve]);
        p.relief_valve = parseInt(p.relief_valve * this.rand(100) / 100.0);
      }
      return this.pump = p;
    };

    Scenario.prototype.morePressureAllLines = function() {
      var p;
      return p = new App.Pump(25);
    };

    Scenario.prototype.checkAnswer = function(p) {
      return p.toStr() === this.answer_str;
    };

    Scenario.prototype.rand = function(upper_limit) {
      return Math.floor(Math.random() * upper_limit);
    };

    return Scenario;

  })();

}).call(this);
