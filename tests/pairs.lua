-- With LuaJIT

local test = {}

for i = 1, 100 do
    test[i] = i * 2
end

gbench()
    :SetCalls(1000000)
    :SetTitle("Iterators")
    :AddFunction("pairs", function()
        for k, v in pairs(test) do
            
        end
    end)
    :AddFunction("ipairs", function()
        for k, v in ipairs(test) do
            
        end
    end)
    :AddFunction("num", function()
        for i = 1, #test do
            local v = test[i]
        end
    end)
:Start()

--[[
= BENCHMARK =
Title: Iterators
LuaJIT 2.0.4: Enabled
Calls: 1,000,000
Arch: x86
Results:
1. "num":       0.086335700000006
2. "ipairs":    0.12808510000002 (48.357052760343% slower)
3. "pairs":     0.37798379999998 (337.80707169798% slower)
]]