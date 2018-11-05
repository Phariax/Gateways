Sensor = {}
Sensor.__index = Sensor

function Sensor:new(ref)

    local newSensor = {}
    setmetatable(newSensor, Sensor)

    newSensor.object = ref


    return newSensor

end


function Sensor:GetNumColls()
    return getNumCollisions(self.object)
end


    