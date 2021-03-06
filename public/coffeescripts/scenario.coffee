class App.Scenario
  constructor: ->
#    @direct_factors = ['idle_speed', 'relief_valve', 'valve1', 'valve2', 'valve3', 'valve4', 'connection1?']
    @direct_factors = ['idle_speed', 'relief_valve']
    @answer_str = null
    @changes_needed = []
    @change_text = ''
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
    num_issues = @rand(2) + 1
    num_hoses = @rand(2) + 1

    discharge = []
    discharge.push( new App.Valve(@rand(101), new App.Hose((@rand(10) + 1) * 50, 1.75, @rand(51) * 5 - 125)) ) for num in [0..num_hoses]

    p = new App.Pump(100, discharge, [], 500)

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

    if issues.indexOf('idle_speed') != -1
      @changes_needed.push(['idle speed', p.idle_percentage])
      @change_text = "Adjust idle speed. "
      p.idle_percentage = parseInt(p.idle_percentage * @rand(100) / 100.0)
    if issues.indexOf('relief_valve') != -1
      @changes_needed.push(['relief valve', p.relief_valve])
      @change_text += "Adjust relief valve. "
      p.relief_valve = parseInt(p.relief_valve * @rand(100) / 100.0)

    @pump = p

  ############
  # Easy / one change problems
  ############
  morePressureAllLines: ->
    # TODO
    p = new App.Pump(25, [new App.Valve(100, new App.Hose())], [], 500, 300)
    @pump = p
    @change_text = "More pressure on all lines. "

  morePressureOneLine: ->
    # TODO
    # Possible solutions:
    # 1. increase idle speed
    # 2. open discharge valve
    # 3. raise relief valve
    @createWorkingConditions()
    @pump.relief_valve = 0
    @pump.idle_percentage = 0
    @pump.discharge[0].open_percentage = 0
    @change_text = "More pressure on the one line. "

  lessPressureAllLines: ->
    # Possible solutions:
    # 1. decrease idle speed
    # 2. close all discharge valves
    # TODO
    p = new App.Pump(25, [new App.Valve(100, new App.Hose())], [], 500, 300)
    @pump = p
    @change_text = "Less pressure on all lines. "

  lessPressureOneLine: ->
    # TODO
    @change_text = "Less pressure on the one line. "

  addOnMoreHoseOneLine: ->
    # TODO

  compensateForElevatedHose: ->
    # TODO

  protectLineFromSurge: ->
    # TODO

  chargeSecondLineWhileKeepingFirstConstant: ->
    # TODO

  createWorkingConditions: (num_hoses = 1) ->
    # 1. randomly create uncontrollable values (hose length, elevation, nozzle type, number of lines, initial tank size)
    # 2. create believable directly controllable pump values (idle, relief valve, discharge valve)
    discharge = []
    discharge.push( new App.Valve(0, new App.Hose((@rand(10) + 1) * 50, 1.75, @rand(51) * 5 - 125)) ) for num in [0..num_hoses]
    @pump = new App.Pump(0, discharge, [], 1000, 600, 0)


  checkAnswer: (p) ->
    p.toStr() == @answer_str

  # rand(100) -> 0 - 99
  rand: (upper_limit) ->
    Math.floor(Math.random() * upper_limit)

#  http://www.firefighternation.com/article/engine-co-operations/pump-operator-skills-modern-fireground
#  Hose needs more pressure
#  Hose has too much pressure
#  Adding on more hose
#  Raising hose elevation
#  Protect hose from water surge using relief valve
#  Charge second line while keeping pressure constant on first line