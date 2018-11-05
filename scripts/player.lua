Player = {}
Player.__index = Player 

function Player:new(ref, pos, rot)

    local newPlayer = {}
    setmetatable(newPlayer, Player )

    newPlayer.object = ref 
    newPlayer.rotation = setRotation(newPlayer.object, rot)

    setLinearFactor(newPlayer.object,{1,0,1})
    setAngularFactor(newPlayer.object,{1,1,1})

    return newPlayer

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
        addCentralForce(self.object, {0,0,1000},"local")
    end
end

--We aim with our hand on an object, we want to levitate,
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
            setRotation(self.object, {0,180,180})
        else 
            setRotation(self.object, {0,180,0})
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


function Player:GetDirection()
    local orientation = getRotation(self.object)
    if orientation[3] == 0 then
        orientation = "RIGHT"
        print(direction)
    elseif orientation[3] == 180 then
        orientation = "LEFT"
        print(orientation)
    end

    return orientation

end