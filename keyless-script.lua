repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Base64 decoding logic
local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function base64Decode(data)
    data = data:gsub('[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c=0
        for i=1,8 do c=c + (x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL05vTGFnLWlkL05vLUxhZy1IVUIvcmVmcy9oZWFkcy9tYWluL0dhcmRlbi9HYXJkZW4tVjIubHVh"


local url = base64Decode(encodedUrl)
local success, response = pcall(game.HttpGet, game, url)
if success and response then
    local loadedFunc, err = loadstring(response)
    if loadedFunc then
        loadedFunc()
    else
        warn("Loadstring failed: " .. tostring(err))
    end
else
    warn("Failed to fetch script: " .. tostring(response))
end