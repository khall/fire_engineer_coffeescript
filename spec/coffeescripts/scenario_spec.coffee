describe 'Scenario', ->
  describe 'Easy', ->
    it 'should come up with a easily solvable scenario', ->
      s = new App.Scenario
      easy = s.easy()
      scenario = easy[0]
      answer_str = easy[1]
      problems = scenario.toStr().split(',')
      answers = answer_str.split(',')

      num_right = 0
      num_right++ for num in [0..answers.length - 1] when answers[num] == problems[num]

      expect(num_right + 3).toBeGreaterThan(answers.length)
      expect(num_right).not.toEqual(answers.length)
      expect(num_right).toBeLessThan(answers.length)

  describe 'Rand', ->
    s = null

    beforeEach ->
      s = new App.Scenario

    it 'should return 0', ->
      expect(s.rand(1)).toEqual(0)

    it 'should return 0 or 1', ->
      rand = s.rand(2)
      expect(rand).toBeGreaterThan(-1)
      expect(rand).toBeLessThan(2)

    it 'should return a number between 0 and 99', ->
      rand = s.rand(100)
      expect(rand).toBeGreaterThan(-1)
      expect(rand).toBeLessThan(100)