class App.Pump
  # discharge and intake arrays should have valve objects
  constructor: (idle_percentage = 0, discharge = [], intake = [], tank = null, max_pressure = 600, relief_valve = 160) ->
    @idle_percentage = idle_percentage
    valve.pump = this for valve in discharge
    @discharge = discharge
    @intake = intake
    @tank = tank
    @max_pressure = max_pressure
    @relief_valve = relief_valve
    @tank_to_pump = false
    @tank_fill = false
    @drive_to_pump = false
    @flow_interval = null

  driveToPump: ->
    @drive_to_pump = !@drive_to_pump
    @processWaterLoss() if @tank_to_pump && @drive_to_pump
    @drive_to_pump

  tankToPump: ->
    @tank_to_pump = !@tank_to_pump
    @processWaterLoss() if @tank_to_pump && @drive_to_pump
    @tank_to_pump

  pressure: ->
    (@idle_percentage / 100.0) * @max_pressure

  setPressure: (desired_pressure) ->
    @idle_percentage = @max_pressure / parseFloat(desired_pressure)

#  adjustPressure: (new_pressure) ->
#    @pressure = new_pressure

  # TODO: ensure this summation idea is correct
  totalIntakePressure: ->
    pressure = 0
    pressure += i.pressure for i in @intake
    pressure

  toStr: ->
    discharge_str = ",discharge:["
    discharge_str += d.toStr() + "," for d in @discharge
    discharge_str.substr(0, discharge_str - 1)

    intake_str = "],intake:["
    intake_str += i.toStr() + "," for i in @intake
    intake_str.substr(0, intake_str - 1)

    "pressure:" + @pressure() + discharge_str + intake_str + "],tank:" + @tank + ",max_pressure:" + @max_pressure + ",relief_valve:" + @relief_valve

  reduceTankWater: (gallons) ->
    @tank -= gallons
    @tank = 0 if @tank < 0

  processWaterLoss: ->
    clearInterval(@flow_interval) if @flow_interval
    @flow_interval = setInterval =>
      @reduceTankWater(valve.hose.gallons_per_second()) for valve in @discharge
    , 1000

  reliefValveOpen: ->
    for valve in @discharge
      return true if @relief_valve < valve.pressureOut()
    false

  # TODO: drafting / suction