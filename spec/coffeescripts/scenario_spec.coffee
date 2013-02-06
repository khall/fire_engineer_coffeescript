describe 'Scenario', ->
  describe 'Easy', ->
    it 'should come up with a easily solvable scenario', ->
      s = new App.Scenario
      problems = s.easy().toStr().split(',')
      answers = s.answer_str.split(',')

      num_right = 0
      num_right++ for num in [0..answers.length - 1] when answers[num] == problems[num]

      expect(num_right + 3).toBeGreaterThan(answers.length)
      expect(num_right).not.toEqual(answers.length)
      expect(num_right).toBeLessThan(answers.length)

      names = s.changes_needed.map (changes) -> changes[0]
      expect(names.indexOf('pump pressure') + names.indexOf('relief valve')).toBeGreaterThan(-2)

  describe 'morePressure', ->
    it 'should create a scenario where more pressure is needed', ->
      s = new App.Scenario
      s.morePressureAllLines()
      p = s.pump

      # either the pump idle percentage needs to be increased or the hose valve needs to be opened more
      expect(p).not.toEqual null
      expect(p.discharge[0].hose.nozzle_pressure()).toBeLessThan p.discharge[0].hose.desiredNozzlePressure()

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