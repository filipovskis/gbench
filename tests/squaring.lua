-- With LuaJIT

local value = 256

gbench()
    :SetCalls(1000000)
    :SetTitle("Squaring")
    :SetJitDisabled(true)
    :AddFunction("math.pow", function()
        return math.pow(value, 2)
    end)
    :AddFunction("x ^ 2", function()
        return (value ^ 2)
    end)
    :AddFunction("x * x", function()
        return (value * value)
    end)
:Start()

--[[
= BENCHMARK =
Title: Squaring
LuaJIT 2.0.4: Disabled
Calls: 1,000,000
Arch: x86
Results:
1. "x ^ 2":     0.013879700000189
2. "x * x":     0.014114800000016 (1.6938406437018% slower)
3. "math.pow":  0.024816599999895 (78.797812629648% slower)
]]