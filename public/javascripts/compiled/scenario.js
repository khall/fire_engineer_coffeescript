(function() {

  App.Scenario = (function() {

    function Scenario() {
      this.direct_factors = ['pump_pressure', 'release_valve'];
    }

    Scenario.prototype.easy = function() {
      var chosen_issues, count, df, discharge, issues, num, num_hoses, num_issues, p, pump_answer_str, _i;
      num_issues = this.rand(2) + 1;
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
      console.log('num_issues: ' + num_issues);
      chosen_issues = [];
      for (num = _i = 1; 1 <= num_issues ? _i <= num_issues : _i >= num_issues; num = 1 <= num_issues ? ++_i : --_i) {
        console.log('num: ' + num);
        count = 0;
        df = this.rand(this.direct_factors.length);
        while (chosen_issues.indexOf(df) !== -1 && count < 100) {
          console.log('count: ' + count);
          df = this.rand(this.direct_factors.length);
          count++;
        }
        console.log('adding: ' + df);
        chosen_issues.push(df);
        issues.push(this.direct_factors[df]);
      }
      console.log('issues[0]: ' + issues[0]);
      console.log('issues[1]: ' + issues[1]);
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
