(function() {

  describe('Scenario', function() {
    describe('Easy', function() {
      return it('should come up with a easily solvable scenario', function() {
        var answer_str, answers, easy, num, num_right, problems, s, scenario, _i, _ref;
        s = new App.Scenario;
        easy = s.easy();
        scenario = easy[0];
        answer_str = easy[1];
        problems = scenario.toStr().split(',');
        answers = answer_str.split(',');
        num_right = 0;
        for (num = _i = 0, _ref = answers.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; num = 0 <= _ref ? ++_i : --_i) {
          if (!(answers[num] === problems[num])) {
            continue;
          }
          console.log(num + ' - does ' + answers[num] + ' == ' + problems[num] + '?');
          num_right++;
        }
        expect(num_right + 3).toBeGreaterThan(answers.length);
        expect(num_right).not.toEqual(answers.length);
        return expect(num_right).toBeLessThan(answers.length);
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
