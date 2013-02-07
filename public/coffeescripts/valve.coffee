class App.Valve
  constructor: (open_percentage = 0, hose = null, pump = null) ->
    @open_percentage = open_percentage
    hose.valve = this if hose != null
    @hose = hose
    @pump = pump

  setOpenPercentage: (percent) ->
    percent = 100 if percent > 100
    percent = 0 if percent < 0
    @open_percentage = percent

  pressureOut: ->
    po = (@open_percentage / 100.0) * @pump.pressure()
    parseFloat(po.toFixed(1))

  toStr: (with_pump = false) ->
    hose_str = @hose.toStr()
    pump = if with_pump then ",pump:" + @pump.toStr() else ""
    "open_percentage:" + @open_percentage + ",hose:" + hose_str + pump

#  processWaterLoss: ->
#    console.log("gpm: " + @hose.gallons_per_second() + " tank: " + @pump.tank)
#    @pump.tank -= @hose.gallons_per_second()