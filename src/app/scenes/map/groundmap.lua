local groudmap = class("groudmap", function()
    return display.newLayer("groudmap")
end)

--没啥用就是列一下成员变量
table.merge(groudmap, {
    touchLayer = nil, --触摸事件层
    mapNode  = nil, --tmx地图根节点
})

local kTagTileMap = 1
function groudmap:ctor(mapName)
    local touchLayer = self:createTileLayer()
    touchLayer:addTo(self)

    mapName = "TileMaps/"..mapName
    local mapNode = cc.TMXTiledMap:create(mapName)
    mapNode:setAnchorPoint(display.ANCHOR_POINTS[display.BOTTOM_LEFT])
    mapNode:addTo(touchLayer, 0, kTagTileMap)
    self.mapNode = mapNode
end

function groudmap:onEnter()
end

function groudmap:onExit()
end

function groudmap:createTileLayer()
    local touchLayer = cc.LayerColor:create(cc.c4b(255,255,255,255))
    self.touchLayer = touchLayer
    local onTouchesBegan = function (touches, event)
        self:onTouchesBegan(touches, event)
    end
    local onTouchesMoved = function (touches, event)
        self:onTouchesMoved(touches, event)
    end
    local onTouchesEnded = function (touches, event)
        self:onTouchesEnded(touches, event)
    end
    local onTouchesCancelled = function (touches, event)
        self:onTouchesCancelled(touches, event)
    end
    --事件监听
    local listener = cc.EventListenerTouchAllAtOnce:create()
    listener:registerScriptHandler(onTouchesBegan,cc.Handler.EVENT_TOUCHES_BEGAN )
    listener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
    listener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_ENDED )
    listener:registerScriptHandler(onTouchesCancelled,cc.Handler.EVENT_TOUCHES_CANCELLED )
    local eventDispatcher = touchLayer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, touchLayer)

    return touchLayer
end

function groudmap:onTouchesBegan(touches, event )
    local diff = touches[1]:getDelta()
    local node = self.mapNode
    local currentPosX, currentPosY= node:getPosition()
    local currentSize = node:getContentSize()
end

--限制一下Y轴的移动
local limitY = 0 --效果不好,先关掉
function groudmap:onTouchesMoved(touches, event )
    local diff = touches[1]:getDelta()
    local node = self.mapNode
    local currentPosX, currentPosY= node:getPosition()
    local currentSize = node:getContentSize()
    --粘滞移动
    if diff.y < limitY and diff.y > -limitY  then
        diff.y = 0
    end
    --边界检测
    local destX,destY = currentPosX + diff.x, currentPosY + diff.y
    destX = math.min(destX,0)
    destX = math.max(destX,-currentSize.width)
    destY = math.min(destY,0)
    destY = math.max(destY,-currentSize.height)
    --设置坐标
    node:setPosition(cc.p(destX, destY))
end

function groudmap:onTouchesEnded(touches, event )
    local diff = touches[1]:getDelta()
    local node = self.mapNode
    local currentPosX, currentPosY= node:getPosition()
    local currentSize = node:getContentSize()
end

function groudmap:onTouchesCancelled(touches, event )
    local diff = touches[1]:getDelta()
    local node = self.mapNode
    local currentPosX, currentPosY= node:getPosition()
    local currentSize = node:getContentSize()
end

return groudmap
