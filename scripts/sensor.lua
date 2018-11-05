<<<<<<< HEAD
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


=======
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


>>>>>>> 4517f21ed8907ebabc995061a274ce56b88f7590
    