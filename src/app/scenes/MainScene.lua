local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local groundmap = import(".map.groundmap")

function MainScene:ctor()
    --[[
    display.newTTFLabel({text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
    --背景图
    display.newSprite("bug886.png",display.cx,display.cy,{})
        :addTo(self)
        :setScaleX(display.cx*2/384)
        :setScaleY(display.cy*2/256)
    ]]
    local ground = groundmap.new("village.tmx"):addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
