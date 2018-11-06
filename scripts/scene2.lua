
dofile("player.lua")
dofile("sensor.lua")

--***************************--
----Object setups--------------
-------------------------------
local Player = Player:new(getObject("Player01"))
local Feet   = Sensor:new(getObject("Feet01"))



--***************************--
----Keyhit functionality-------
-------------------------------
local currJumpKeyHit  = "released"
local prevJumpKeyHit  = "released"


--***************************--
----Gravity related stuffs here
-------------------------------
--Grab the current gravity
local gravity = getGravity()

--Is the gravity towards down? 
local currGravDown = true

local currGravkeyHit = "released"
local prevGravKeyHit = "released"

--***************************--
----Player related setups------
-------------------------------

--The main game loop. Ticks every frame
function onSceneUpdate()

    
    --Hitkey setups....eeeeeh
    currGravKeyHit = prevGravKeyHit
    currJumpKeyHit = prevJumpKeyHit
    
    --Feet collision
    coll = Feet:GetNumColls()

    --Mouse position
    mx = getAxis("MOUSE_X")
    my = getAxis("MOUSE_Y")

    --Gravity changer
    if isKeyPressed("G") and (prevGravKeyHit == "released") and coll < 2 then
        currGravDown = Player:GravityChange(currGravDown)
        currGravKeyHit = "pressed"
    elseif onKeyUp("G") then
        currGravKeyHit = "released"
    end
 
    --Moving to the left
    if isKeyPressed("A") then
        Player:MoveLeft(currGravDown)
    end
    --Moving to the right
    if isKeyPressed("D") then
        Player:MoveRight(currGravDown)
    end
    --Jump+Hitkey workaround
    if isKeyPressed("SPACE") and (prevJumpKeyHit == "released") then
        Player:Jump(coll)
        currKeyHit = "pressed"
    elseif onKeyUp("SPACE") then
        currKeyHit = "released"
    end

    --Aiming, and turn around if needed. Has to be changed later.
    --Now we are checking the mouse position compared to the midpoint
    --of the screen. I have to check the mx, my compare to the character.
    --So probably I'll need the caracter's position in 2D.
    if isKeyPressed("MOUSE_BUTTON3") then
        Player:Aim(mx,my,currGravDown)
    end

    --Hitkey workaround
    prevGravKeyHit = currGravKeyHit
    prevJumpKeyHit = currJumpKeyHit

end

