-- With LuaJIT

local str = "Hello Everyone 428"
local match = string.match

gbench()
    :SetCalls(1000000)
    :SetTitle("Local Func")
    :AddFunction("Localized", function()
        return match(str, "%d+")
    end)
    :AddFunction("global", function()
        return string.match(str, "%d+")
    end)
    :AddFunction("meta func", function()
        return str:match("%d+")
    end)
:Start()

--[[
= BENCHMARK =
Title: Local Func
LuaJIT 2.0.4: Enabled
Calls: 1,000,000
Arch: x86
Results:
1. "Localized": 0.17621889999998
2. "global":    0.18339600000002 (4.0728321423163% slower)
3. "meta func": 0.19996729999991 (13.47664751053% slower)
]]