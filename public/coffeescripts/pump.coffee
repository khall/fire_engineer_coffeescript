class App.Pump
  # discharge and intake arrays should have valve objects
  constructor: (pressure = 0, discharge = [], intake = [], tank = null, max_pressure = 300, release_valve = 160) ->
    @pressure = pressure
    valve.pump = this for valve in discharge
    @discharge = discharge
    @intake = intake
    @tank = tank
    @max_pressure = max_pressure
    @release_valve = release_valve

  adjustPressure: (new_pressure) ->
    @pressure = new_pressure

  toStr: ->
    discharge_str = ",discharge:["
    discharge_str += d.toStr() + "," for d in @discharge
    discharge_str.substr(0, discharge_str - 1)

    intake_str = "],intake:["
    intake_str += i.toStr() + "," for i in @intake
    intake_str.substr(0, intake_str - 1)

    "pressure:" + @pressure + discharge_str + intake_str + "],tank:" + @tank + ",max_pressure:" + @max_pressure + ",release_valve:" + @release_valve

  # TODO: drafting / suction