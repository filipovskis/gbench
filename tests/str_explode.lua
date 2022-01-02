-- With LuaJIT

local text = "Hello everyone, have a nice weekend :)"
local separator = " "

gbench()
    :SetCalls(1000000)
    :SetTitle("string.Explode VS string.Split")
    :AddFunction("string.Explode", function()
        return string.Explode(separator, text)
    end)
    :AddFunction("string.Split", function()
        return string.Split(text, separator)
    end)
:Start()

--[[
= BENCHMARK =
Title: string.Explode VS string.Split
LuaJIT 2.0.4: Enabled
Calls: 1,000,000
Arch: x86
Results:
1. "string.Split":      0.88799110000014
2. "string.Explode":    0.90650649999998 (2.0850884653956% slower)
]]