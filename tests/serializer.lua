-- With LuaJIT
-- Results: https://bit.ly/3p8zy9Q

local packer = messagePack.new()
local title = ""
local competitors = {
    ["pON"] = {
        encode = pon.encode,
        decode = pon.decode
    },
    ["messagePack"] = {
        encode = packer.pack,
        decode = packer.unpack
    },
    ["vON"] = {
        encode = von.serialize,
        decode = von.deserialize
    },
    ["JSON"] = {
        encode = util.TableToJSON,
        decode = util.JSONToTable
    }
}

local function doTest(method, testTable)
    local benchmark = gbench()
    benchmark:SetTitle(string.format("Serializers (%s) - %s", string.upper(method), title))
    benchmark:SetCalls(1000)

    for name, methods in next, competitors do
        local fn = methods[method]
        local data

        if method == "encode" then
            data = testTable
        elseif method == "decode" then
            data = methods.encode(testTable)
        end

        benchmark:AddFunction(name, function()
            return fn(data)
        end)
    end

    benchmark:Start()
end

print(string.format("Started test at %s\n", os.date("%H:%M:%S")))

-- Array filled with numbers
do
    local data = {}

    for i = 1, 100 do
        data[i] = i ^ 2
    end

    doTest("encode", data)
    doTest("decode", data)
end

-- Array filled with strings
do
    local data = {}

    -- https://gist.github.com/haggen/2fd643ea9a261fea2094?permalink_comment_id=2640881#gistcomment-2640881
    local function randomString(length)
        local res = ""
        for i = 1, length do
            res = res .. string.char(math.random(97, 122))
        end
        return res
    end

    for i = 1, 100 do
        data[i] = randomString(i)
    end

    title = "Array of Strings"
    doTest("encode", data)
    doTest("decode", data)
end

-- 3D Table
do
    local data = {}

    local entList = ents.GetAll()
    local entCount = #entList

    for i = 1, 100 do
        local key = i % 2 == 0 and tostring(i) or i
        data[key] = {
            key = key,
            num = math.random(-256, 256),
            ent = entList[math.random(1, entCount)],
            vector = Vector(0, 0, 256),
            angle = Angle(0, 45, 45),
            str = "Hello",
            color = Color(255, 0, 0),
            tbl = {"Hello", "have", "a", "nice", "day"}
        }
    end

    title = "Mixed Table"
    doTest("encode", data)
    doTest("decode", data)
end