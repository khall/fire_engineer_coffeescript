class App.Scenario
  constructor: ->
#    @direct_factors = ['pump_pressure', 'relief_valve', 'valve1', 'valve2', 'valve3', 'valve4', 'connection1?']
    @direct_factors = ['pump_pressure', 'relief_valve']
    @answer_str = null
    @changes_needed = []
    @pump = null

  # create a situation where only one or two directly controllable factors need changing in order to be correct
  # directly controllable factors:
  # 1. pump pressure
  # 2. relief valve
  # 3. hose valves (1-4)
  # 4. hose connections?
  #
  # total values
  # 1.
  easy: ->
    num_issues = @rand(2)
    num_hoses = @rand(2)

    discharge = new App.Valve(@rand(101), new App.Hose(@rand(10) * 50, 1.75, @rand(51) * 5 - 125)) for num in [0..num_hoses]

    p = new App.Pump(100, [discharge], [], 500)

    # record current settings to create the answer
    @answer_str = p.toStr()

    # change num_issues factors to create a problem
    issues = []
    chosen_issues = []
    for num in [0..num_issues]
      # get a directly controllable factor that doesn't exist in chosen_issues, add it to chosen issues
      count = 0
      df = @rand(@direct_factors.length)
      while chosen_issues.indexOf(df) != -1 && count < 100
        df = @rand(@direct_factors.length)
        count++
      chosen_issues.push(df)

      issues.push(@direct_factors[df])

    if issues.indexOf('pump_pressure') != -1
      @changes_needed.push(['pump pressure', p.pressure()])
      p.setPressure(parseInt(p.pressure() * @rand(100) / 100.0))
    if issues.indexOf('relief_valve') != -1
      @changes_needed.push(['relief valve', p.relief_valve])
      p.relief_valve = parseInt(p.relief_valve * @rand(100) / 100.0)

    @pump = p

  morePressureAllLines: ->
    p = new App.Pump(25)

  checkAnswer: (p) ->
    p.toStr() == @answer_str

  rand: (upper_limit) ->
    Math.floor(Math.random() * upper_limit)