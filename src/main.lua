package.path = package.path .. ";src/?.lua;src/framework/protobuf/?.lua"

print("REMOTE_DEBUG", REMOTE_DEBUG)
if REMOTE_DEBUG then
    local breakInfoFun,xpcallFun = require("LuaDebug")("localhost", 7003)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.3, false)
end

function __G__TRACKBACK__(errorMessage)
    xpcallFun()
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

require("app.MyApp").new():run()
