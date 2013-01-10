class App.Hydrant
  constructor: (pressure = 60, valve_percentage = 0) ->
    @pressure = pressure
    @valve_percentage = valve_percentage

  openValve: ->
#    App.Gradual.increase_to(@valve_percentage, 100, 8000)
    @valve_percentage = 100

  gallons_per_minute: (two_and_half = false, steamer = false) ->
    # are these numbers in any way accurate?
    if two_and_half
      rated_gpm = 1300
    else if steamer
      rated_gpm = 1560
    else
      rated_gpm = 0

    parseFloat((29.7 * Math.pow(rated_gpm, 2) * Math.sqrt(@pressure)).toFixed(3))

class App.Gradual
  @step_time = 100
  @interval = null

  # this doesn't work because 'what' is passed by value
  @increase_to: (what, to, how_long) ->
    step_time = @step_time
    step_time = how_long if how_long < step_time && how_long != 0
    iterations = how_long / step_time
    diff = to - what
    step_amount = if iterations == 0 then to else diff / iterations
    running_time = 0
    @interval = setInterval =>
      what += step_amount
      running_time += step_time
#      console.log('what: ' + what + ' -- typeof: ' + typeof(what))
#      console.log('to: ' + to + ' -- typeof: ' + typeof(to))
#      console.log('running_time: ' + running_time + ' -- typeof: ' + typeof(running_time))
#      console.log('how_long: ' + how_long + ' -- typeof: ' + typeof(how_long))
      clearInterval(@interval) if what == to || running_time > how_long
    , step_time