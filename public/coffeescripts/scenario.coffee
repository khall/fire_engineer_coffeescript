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
    num_issues = @rand(2) + 1
    num_hoses = @rand(2) + 1

    discharge = (new App.Valve(@rand(101), new App.Hose(@rand(10) * 50, 1.75, @rand(51) * 5 - 125)) for num in [0..num_hoses])

    p = new App.Pump(100, discharge, [], 500)

    # record current settings to create the answer
    pump_answer_str = p.toStr()

    # change num_issues factors to create a problem
    issues = []
    console.log('num_issues: ' + num_issues)
    chosen_issues = []
#    chosen_issues.push(@rand(@direct_factors.length)) if num_issues > 0
    for num in [1..num_issues]
      console.log('num: ' + num)
      # get a directly controllable factor that doesn't exist in chosen_issues, add it to chosen issues
      count = 0
      df = @rand(@direct_factors.length)
      while chosen_issues.indexOf(df) != -1 && count < 100
        console.log('count: ' + count)
        df = @rand(@direct_factors.length)
        count++
      console.log('adding: ' + df)
      chosen_issues.push(df)

      issues.push(@direct_factors[df])

    console.log('issues[0]: ' + issues[0])
    console.log('issues[1]: ' + issues[1])
    p.pressure *= (@rand(100) / 100.0) if issues.indexOf('pump_pressure') != -1
    p.release_valve *= (@rand(100) / 100.0) if issues.indexOf('release_valve') != -1

    [p, pump_answer_str]

  rand: (upper_limit) ->
    Math.floor(Math.random() * upper_limit)