-- With LuaJIT

local tbl = {}

for i = 1, 100 do
    tbl[i] = i * 2
end

gbench()
    :SetCalls(1000000)
    :SetTitle("Check if table is empty")
    :AddFunction("table.IsEmpty", function()
        return table.IsEmpty(tbl)
    end)
    :AddFunction("tbl[1]", function()
        return tbl[1]
    end)
    :AddFunction("#tbl > 0", function()
        return #tbl > 0
    end)
    :AddFunction("table.Count", function()
        return table.Count(tbl) > 0
    end)
:Start()

--[[
= BENCHMARK =
Title: Check if table is empty
LuaJIT 2.0.4: Enabled
Calls: 1,000,000
Arch: x86
Results:
1. "tbl[1]":    0.011488500000041
2. "#tbl > 0":  0.019323100000065 (68.195151673374% slower)
3. "table.IsEmpty":     0.040358399999946 (251.29390259651% slower)
4. "table.Count":       0.53470790000006 (4554.2882012285% slower)
]]