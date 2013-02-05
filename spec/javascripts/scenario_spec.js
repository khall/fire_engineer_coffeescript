(function() {

  describe('Scenario', function() {
    describe('Easy', function() {
      return it('should come up with a easily solvable scenario', function() {
        var answers, num, num_right, problems, s, _i, _ref;
        s = new App.Scenario;
        problems = s.easy().toStr().split(',');
        answers = s.answer_str.split(',');
        num_right = 0;
        for (num = _i = 0, _ref = answers.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; num = 0 <= _ref ? ++_i : --_i) {
          if (answers[num] === problems[num]) {
            num_right++;
          }
        }
        expect(num_right + 3).toBeGreaterThan(answers.length);
        expect(num_right).not.toEqual(answers.length);
        expect(num_right).toBeLessThan(answers.length);
        return expect(s.changes_needed[0][0].indexOf('pump pressure') + s.changes_needed[1][0].indexOf('relief valve')).toBeGreaterThan(-2);
      });
    });
    describe('morePressure', function() {
      return it('should create a scenario where more pressure is needed', function() {
        var p, s;
        s = new App.Scenario;
        s.morePressureAllLines();
        p = s.pump;
        expect(p).not.toEqual(null);
        return expect(p.discharge[0].hose.nozzle_pressure()).toBeLessThan(p.discharge[0].hose.desired_nozzle_pressure());
      });
    });
    return describe('Rand', function() {
      var s;
      s = null;
      beforeEach(function() {
        return s = new App.Scenario;
      });
      it('should return 0', function() {
        return expect(s.rand(1)).toEqual(0);
      });
      it('should return 0 or 1', function() {
        var rand;
        rand = s.rand(2);
        expect(rand).toBeGreaterThan(-1);
        return expect(rand).toBeLessThan(2);
      });
      return it('should return a number between 0 and 99', function() {
        var rand;
        rand = s.rand(100);
        expect(rand).toBeGreaterThan(-1);
        return expect(rand).toBeLessThan(100);
      });
    });
  });

}).call(this);
