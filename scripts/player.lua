
Player = {}
Player.__index = Player 

function Player:new(ref, pos, rot)

    local newPlayer = {}
    setmetatable(newPlayer, Player )

    newPlayer.object = ref 
    setLinearFactor(newPlayer.object,{1,0,1})
   
    return newPlayer

end

function Player:Rotate()
    local currAngle = getRotation(self.object)
    print(currAngle[3])
    if currAngle[3] <= 180 and currAngle[3] >=0 then
        rotate(self.object, {0,0,1},5)
    elseif currAngle[3] >=180 and currAngle[3] <= 0 then
        rotate(self.object, {0,0,1},-5)
    end
    
end


--Move to the left and turn to the left, if 
--we are facing to the right
function Player:MoveLeft(currGravDown)
    translate(self.object, {-1,0,0})
    rotation = getRotation(self.object)
    if currGravDown == true then
        if rotation[3] == 0 then
            setRotation(self.object,{0,0,180})
            --direction = "LEFT"
        end
    elseif currGravDown == false then
            setRotation(self.object, {0,180,0})
            --direction = "LEFT"
    end
end


--Move to the right and turn to the right, if
--we are facing to the left
function Player:MoveRight(currGravDown)     
    translate(self.object, {1,0,0})
    rotation = getRotation(self.object)
    if currGravDown == true then
        if rotation[3] == 180 then
            setRotation(self.object, {0,0,0})
            --direction = "RIGHT"
        end
    elseif currGravDown == false then
            setRotation(self.object, {0,180,180})
            --direction = "RIGHT"
    end
end

--Jump
function Player:Jump(coll)
    local coll = coll

    if coll > 1 then
        addCentralForce(self.object, {0,0,2500},"local")
    end
end

--We aim with our hand towards an object we want to levitate,
--or to a surface we want to elevate from it
function Player:Aim(mx,my, currGravDown)
    --Mouse position x
    local mx = mx
    --Rotation of the player, aka direction
    rotation = getRotation(self.object)
    if mx < 0.5 then
        if currGravDown == true then
            if rotation[3] == 0 then
                setRotation(self.object, {0,0,180})
                --direction = "LEFT"
            end
        elseif currGravDown == false then
                setRotation(self.object, {0,180,0})
                --direction = "LEFT"
        end
    elseif mx > 0.5 then
        if currGravDown == true then
            if rotation[3] == 180 then
                setRotation(self.object, {0,0,0})
                --direction = "RIGHT"
            end
        elseif currGravDown == false then
                setRotation(self.object, {0,180,180})
                --direction = "RIGHT"
        end
    end
end

function Player:GravityChange(currGravDown)

    rotation = getRotation(self.object)
    if currGravDown == true then
        setGravity({0,0,0.98})
        addCentralForce(self.object, {0,0,0.01})
        if rotation[3] == 0 then
            rotate(self.object, {0,180,180},2)
            --setRotation(self.object, {0,180,180})
        else 
            rotate(self.object, {0,180,0},2)
            --setRotation(self.object, {0,180,0})
        end

        currGravDown = false

    elseif currGravDown == false then
        setGravity({0,0,-0.98})
        addCentralForce(self.object,{0,0,0.-01})
        if rotation[3] == 180 then
            setRotation(self.object, {0,0,180})
        else 
            setRotation(self.object, {0,0,0})
        end
        
        currGravDown = true
    end

    return currGravDown

end


--We can snap the character wherever we want
--'pos' is a Vec3 type variable
function Player:SetLocation(pos)
    setPosition(self.object,pos)
end

function Player:GetLocation()
    local pos = getPosition(self.object)
    print(pos[1].." "..pos[2].." "..pos[3])  
    return pos[1],pos[2],pos[3]
end

function Player:GetRotation()
    local rot = getRotation(self.object)
    print(rot[1].." "..rot[2].." "..rot[3])
    return rot[1],rot[2],rot[3]
end

function Player:AngularFactorOn()

    local angularFactor = setAngularFactor(self.object,{1,1,1})
    --This gives 0 as return value
    return angularFactor
end


function Player:AngularFactorOff()

    local angularFactor = setAngularFactor(self.objet,{0,0,0})
    --This gives 1 as return value
    return angularFactor
end

--[[

--Minden framen le kell vizsgalni. Attributumkent kell a pillanatnyi szog, a sebesseg,
--A maximalis fordulasi szog, azaz a limit minden tengelyre. A GravityChange
--Fuggvenybol hivjuk meg, ha : 1. coll < 2 , gravityKeyHit statusza available

function Player:Rotate(currRotation, speed, rotationLimit)
    local currRotation  = currRotation --getRotation(self.object)
    local speed         = speed
    local rotate        = rotate(self.object,currRotation,speed)
    local rotationLimit = 180
    repeat
        rotate(self.object,{x,y,z},speed)
    until  (currRotation[1] == limitX and
            currRotation[2] == limitY and
            currRotation[3] == limitZ) 
    return rotate[1],rotate[2],rotate[3]
end
--]]

function Player:GetDirection()
    local orientation = getRotation(self.object)
    if orientation[3] == 0 then
        orientation = "RIGHT"
    elseif orientation[3] == 180 then
        orientation = "LEFT"
    end

    return orientation
    
end