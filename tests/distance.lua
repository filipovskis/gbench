-- With LuaJIT

local vec1 = Vector(0, 0, 0)
local vec2 = Vector(255, 255, 255)

gbench()
    :SetCalls(1000000)
    :SetTitle("Distance")
    :AddFunction("Distance", function()
        return vec1:Distance(vec2)
    end)
    :AddFunction("DistToSqr", function()
        return vec1:DistToSqr(vec2)
    end)
    :AddFunction("Length", function()
        return (vec1 - vec2):Length()
    end)
:Start()

--[[
= BENCHMARK =
Title: Distance
LuaJIT 2.0.4: Enabled
Calls: 1,000,000
Arch: x86
Results:
1. "DistToSqr": 0.10077739999997
2. "Distance":  0.10357729999998 (2.7783014842757% slower)
3. "Length":    0.26364239999998 (161.60865432137% slower)
]]