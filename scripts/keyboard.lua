Keyboard = {}
Keyboard.__index = Keyboard

function Keyboard:new()

    local newKeyboard = {}
    setmetatable(newKeyboard, Keyboard)

    return newKeyboard

end

function Keyboard:isKeyPressed()
    return isKeyPressed(key)
end

function Keyboard:onKeyDown()
    return onKeyDown(key)
end

function Keyboard:onKeyUp()
    return onKeyUp(key)
end

function Keyboard:onKeyHit(key, keyState)

    if isKeyPressed(key) == true then
        keyState = "pressed"
        print("We are pressing the :"..tostring(key).." key")
    elseif isKeyPressed(key) == false then
        keyState = "released"
        print("we are not pressing the: "..tostring(key).." key")
    end
     
    return keyState
end
