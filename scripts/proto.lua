
------------------------------------------------------------------------
--Gateways prototype----------------------------------------------------
------------------------------------------------------------------------
dofile("player.lua")
dofile("classic.lua")


--Camera
Camera = getObject("Camera0")

point = getUnProjectedPoint(Camera, vec3(x,y,z))


local windowScale = getWindowScale()
local width = windowScale[1]
local height = windowScale[2]

local jumpKeyState = {"pressed","released"}


--The player entity 
Player = getObject("Player")
setLinearFactor(Player,{1,0,1})
setAngularFactor(Player)
angFac = getAngularFactor(Player)

local playerPos = nil
local playerRot = nil
local direction = {"LEFT", "RIGHT"}
local playerJumpForce =  nil


--The feet entity
Feet = getObject("Feet")

--The prop entity
PropBox1 = getObject("PropBox1")
setLinearFactor(PropBox1,{1,0,1})

--Grab the current gravity
local gravity = getGravity()

--Jump variables
local jumpAllowed = true
local prevJumpAllowed = true
local currHeight = 0
local prevHeight = 0

--Is the gravity towards down? 
local currGravDown = true

--The base of a mappable keyset for control
local jumpKey = "SPACE"
local gravityFlipper = "G"

--Main loop. Ticks on every frame
function onSceneUpdate()
    --print(width)
    --print(mx)
    print("the angfac is " ..tostring(angFac))
    coll = getNumCollisions(Feet)

    --Jumping
    playerPos = getPosition(Player)
    playerRot = getRotation(Player)
    direction = playerRot[3] 
    jumpAllowed = prevJumpAllowed

    --print(playerPos[1])

    if isKeyPressed(jumpKey) == true then
        jumpKeyState = "pressed"
    elseif isKeyPressed(jumpKey) == false then
        jumpKeyState = "released"
    end
   

    if playerRot[3] == 0 then
        direction = "RIGHT"
       -- print(direction)
    elseif playerRot[3] == 180 then
        direction = "LEFT"
        --print(direction)
    end


    --Propbox
    propBoxPos = getPosition(PropBox1)

    --------------------------------------------
    ---------Player Movement--------------------
    --------------------------------------------

    mx = getAxis("MOUSE_X")
    my = getAxis("MOUSE_Y")
    
    --Go to the left
    if isKeyPressed("A") then
        translate(Player, {-1,0,0})
        if currGravDown == true then
            if playerRot[3] == 0 then
                setRotation(Player,{0,0,180})
                --direction = "LEFT"
            end
        elseif currGravDown == false then
                setRotation(Player, {0,180,0})
                --direction = "LEFT"
        end
    end
    
    --Go to the right 
    if isKeyPressed("D") then
        translate(Player, {1,0,0})
        if currGravDown == true then
            if playerRot[3] == 180 then
                setRotation(Player, {0,0,0})
                --direction = "RIGHT"
            end
        elseif currGravDown == false then
                setRotation(Player, {0,180,180})
                --direction = "RIGHT"
        end
    end

    if isKeyPressed("MOUSE_BUTTON3") then
        if mx < 0.5 then
            if currGravDown == true then
                if playerRot[3] == 0 then
                    setRotation(Player,{0,0,180})
                    --direction = "LEFT"
                end
            elseif currGravDown == false then
                    setRotation(Player, {0,180,0})
                    --direction = "LEFT"
            end
        elseif mx > 0.5 then
            if currGravDown == true then
                if playerRot[3] == 180 then
                    setRotation(Player, {0,0,0})
                    --direction = "RIGHT"
                end
            elseif currGravDown == false then
                    setRotation(Player, {0,180,180})
                    --direction = "RIGHT"
            end
        end
    end
    

    if jumpKeyState == "pressed" and jumpAllowed == true then 
        currHeight = playerPos[3]
        if coll > 1 then
            if currGravDown == true then
                addCentralForce(Player,{0,0,300},"local")
            elseif currGravDown == false then
                addCentralForce(Player,{0,0,300}, "local")
            end
            playerJumpForce = getCentralForce(Player)
        end
    elseif jumpKeyState == "released" then
        currHeight = playerPos[3]
    end
      
    
    
    --Gravity flipper. Push the "Q" to change the directionection of gravity
    --Plus, we push both Player and PropBox1 a bit along the Z axis
    --to prevent steadyness at the beginning of gravity changing
    --Basically a toggle button currently. It has to be changed later
    
    if onKeyDown(gravityFlipper) and currGravDown == true then
        setGravity({0,0,0.98})

        addCentralForce(PropBox1,{0,0,0.01})
        addCentralForce(Player,{0,0,0.01})
        if direction == "RIGHT" then
            setRotation(Player, {0,180,180})
        else 
            setRotation(Player, {0,180,0})
        end

        currGravDown = false
		
    elseif onKeyDown(gravityFlipper) and currGravDown == false then
        setGravity({0,0,-0.98})
        addCentralForce(PropBox1,{0,0,0.-01})
        addCentralForce(Player,{0,0,0.-01})
        if direction == "RIGHT" then
            setRotation(Player, {0,0,180})
        else 
            setRotation(Player, {0,0,0})
        end
        
        currGravDown = true
    end
    
    if currGravDown == true then
        if jumpKeyState == "released" and (prevHeight > currHeight) then
            jumpAllowed = true
        elseif prevHeight > currHeight and jumpKeyState == "pressed" then
            jumpAllowed = false
        elseif onKeyUp(jumpKey) then
            jumpAllowed =  true
        end
    elseif currGravDown == false then
        if jumpKeyState == "released" and (prevHeight < currHeight) then
            jumpAllowed = true
        elseif prevHeight < currHeight and jumpKeyState == "pressed" then
            jumpAllowed = false
        elseif onKeyUp(jumpKey) then
            jumpAllowed =  true
        end
    end


    --[[
    startRay = {playerPos[1], playerPos[2], playerPos[3]}
    stopRay  = {playerPos[1]+500, 0, playerPos[3]+100}
    hit      = rayHit(startRay, stopRay, PropBox1)
    if hit then
        print("the object has been hit")
    end
    --]]


    --print(playerRot[3])
    prevJumpAllowed = jumpAllowed
    prevHeight = currHeight

    rotate(Player, {0,0,1},10)
end

