local groudmap = class("groudmap", function()
    return display.newLayer("groudmap")
end)

local kTagTileMap = 1
--限制一下Y轴的移动
local limitY = 1
local function createTileLayer(title, subtitle)
    local layer = cc.LayerColor:create(cc.c4b(255,255,255,255))

    local function onTouchesMoved(touches, event )
        local diff = touches[1]:getDelta()
        local node = layer:getChildByTag(kTagTileMap)
        local currentPosX, currentPosY= node:getPosition()
        if diff.y < limitY and diff.y > -limitY  then
            diff.y = 0
        end
        node:setPosition(cc.p(currentPosX + diff.x, currentPosY + diff.y))
    end

    local listener = cc.EventListenerTouchAllAtOnce:create()
    listener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    return layer
end

function groudmap:ctor(mapName)
    mapName = "TileMaps/"..mapName
    local mapLayer = createTileLayer("title", "subtitle")
    mapLayer:addTo(self)
    local mapNode = cc.TMXTiledMap:create(mapName)
    mapNode:addTo(mapLayer, 0, kTagTileMap)
end

function groudmap:onEnter()
end

function groudmap:onExit()
end

return groudmap
