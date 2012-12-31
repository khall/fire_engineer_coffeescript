window.App = {}

class App.Hose
  friction_coefficients = {1: 150, 1.5: 24, 1.75: 15.5, 2.5: 2, 3: 0.8}

  # at 50 psi nozzle pressure
  smooth_bore_nozzle_gpm = {'1/4': 13, '7/8': 159, '15/16': 184, '1': 209, '9/8': 265, '5/4': 326}

  # see http://fireengineeriq.com/Friction%20Loss.htm for more
  appliance_friction_loss = {'clappered siamese': 10, 'portable monitor': 25, 'standpipe': 25}

  constructor: (distance = 100, diameter = 1.75, elevation = 0, max_pressure = 300, valve = null, nozzle = '15/16') ->
    @distance = distance
    @diameter = diameter
    @elevation = elevation
    @max_pressure = max_pressure
    @valve = valve
    @nozzle_str = nozzle
    @nozzle_float = eval(nozzle)

  friction_loss: ->
    # FL = CQ^2L
    # FL: friction loss in psi
    # C: friction loss coefficient
    # Q: quantity of water (hundreds of gpm)
    # L: hose length in 100s of feet
#    gpm = 100 # this has to do with actual flow levels that the nozzle is doing...i think.
    gpm = smooth_bore_nozzle_gpm[@nozzle_str]
    fl = friction_coefficients[@diameter] * Math.pow((gpm / 100.0), 2) * (@distance / 100.0)
    parseFloat(fl.toFixed(3))

  appliance_loss: ->
    # not supporting appliances yet
    0

  elevation_loss: ->
    @elevation * 0.434

  total_pressure_loss: ->
    # total pressure loss = friction loss + appliance loss +/- elevation loss
#    console.log("fl: " + @friction_loss())
#    console.log("al: " + @appliance_loss())
#    console.log("el: " + @elevation_loss())
    @friction_loss() + @appliance_loss() + @elevation_loss()

  gallons_per_minute: ->
#    console.log('gpm: ' + (29.7 * Math.pow(@diameter, 2) * Math.sqrt(@nozzle_pressure())))
#    console.log('diameter: ' + @diameter)
#    console.log('np: ' + @nozzle_pressure())
#    console.log('xxxxxxxxxxxxxxxxxxx')
    parseFloat((29.7 * Math.pow(@nozzle_float, 2) * Math.sqrt(@nozzle_pressure())).toFixed(3))

  nozzle_pressure: ->
    # nozzle pressure = pump discharge pressure - total pressure loss
#    console.log("pdp: " + @valve.pressureOut())
#    console.log("total loss: " + @total_pressure_loss())
    np = parseFloat((@valve.pressureOut() - @total_pressure_loss()).toFixed(3))
    if np > 0 then np else 0

  pressure_for_gpm: (gpm) ->
    # gpm = 29.7 * Math.pow(@diameter, 2) * Math.sqrt(@pressure)
    # @pressure = Math.pow(gpm / (29.7 * Math.pow(@diameter, 2)), 2)
    parseFloat(Math.pow(gpm / (29.7 * Math.pow(@nozzle_float, 2)), 2).toFixed(3))

  toStr: (with_valve = false) ->
    valve = if with_valve then @valve.toStr() else ""
    "distance:" + @distance + ",diameter:" + @diameter + ",elevation:" + @elevation + ",max_pressure:" + @max_pressure +
      valve + ",nozzle:" + @nozzle_str