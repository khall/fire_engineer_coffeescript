class App.Scenario
  constructor: ->
#    @direct_factors = ['pump_pressure', 'release_valve', 'valve1', 'valve2', 'valve3', 'valve4', 'connection1?']
    @direct_factors = ['pump_pressure', 'release_valve']

  # create a situation where only one or two directly controllable factors need changing in order to be correct
  # directly controllable factors:
  # 1. pump pressure
  # 2. release valve
  # 3. hose valves (1-4)
  # 4. hose connections?
  #
  # total values
  # 1.
  easy: ->
    num_issues = @rand(2) #+ 1
    num_hoses = @rand(2) + 1

    discharge = (new App.Valve(@rand(101), new App.Hose(@rand(10) * 50, 1.75, @rand(51) * 5 - 125)) for num in [0..num_hoses])

    p = new App.Pump(100, discharge, [], 500)

    # record current settings to create the answer
    pump_answer_str = p.toStr()

    # change num_issues factors to create a problem
    issues = []
    issues.push(@direct_factors[@rand(2)]) for num in [0..num_issues]

    p.pressure *= (@rand(100) / 100.0) if issues.indexOf('pump_pressure') != -1
    p.release_valve *= (@rand(100) / 100.0) if issues.indexOf('release_valve') != -1

    [p, pump_answer_str]

  rand: (upper_limit) ->
    Math.floor(Math.random() * upper_limit)