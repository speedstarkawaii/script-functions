--[[
* do not use this unless you have a restricted script executor like some pysploits
* will work mid; each func has a comment to tell you if it works properly or not

these will not ALL check on unc but may still work in real world scripts
this is just an example of what you can do :)

made by speedsterkawaii <3
]]

-- * setting up do not modify

-- modify these to your likings 
local exploit = "DUMMY" --exploit name goes here
local version = "6.9"
local identity = 3 --dont change it; makes your job easier









-- * DO NOT TOUCH unless your modifying 

-- * main funcs 

function getscripts()
    local scripts = {}

    local function scan_script(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("LocalScript") or child:IsA("ModuleScript") then
                table.insert(scripts, child)
            end
            findScripts(child)
        end
    end

    scan_script(game)--we can change it to find it in more services though

    return scripts
end

-- Example usage


function getthreadidentity()
    return identity
end

function setthreadidentity(identity_x)
    if identity_x >= 0 and identity_x <= 7 then --we shouldnt allow negative or above lvl 8
        identity = identity_x
    else
        error("Did not set identity")
    end
end


function identifyexecutor()
    local name = exploit
    local version_dm = version
    return name, version
end

function gethui()
    local gui_cus = Instance.new("ScreenGui")--we can return coregui or any instance that certain scripts use but we will return screengui
    return gui_cus
end

function checkcaller()--always should return true
  return true
end

-- * clipboard functions they are mid and only work for one roblox instance (ofc why would it work externally wtf?)

local clip_storage = {}--all of our new clipboard shit will be here

function setclipboard(content)
    table.insert(clip_storage, content)
end

function getclipboard()
    return clip_storage[#clip_storage] or "" --well we can return nothing if nothing was set or the last thing if it was set
end

-- * console functions; they are simply possible via allocating an console in c but lot of people dont got a bridge or dont have the use of pushing closure and setting field for an actual real function instead of what these new exploits do (typically send a request to a server externally)

--leave these bottom empty; we can insert f9 but thats just bad cus we need to assume if its open or not
function rconsoleclear()
end

function rconsolecreate()
end

function rconsoledestroy()
end

function rconsoleinput(callback)
    print("["..exploit.."] "..callback) 
end

function rconsoleprint(message)
    print("["..exploit.."] "..message) 
end

function rconsolesettitle(name)
    print("["..exploit.."] "..name) 
end

-- * crypt lib

local crypt = {} --well store it here

function crypt.base64encode(input)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local encoded = ''
    local padding = 0

    while #input % 3 ~= 0 do
        input = input .. '\0'
        padding = padding + 1
    end

    for i = 1, #input, 3 do
        local a, b, c = input:byte(i, i + 2)

        local x = (a << 16) + (b << 8) + c

        encoded = encoded .. b:sub((x >> 18) + 1, (x >> 18) + 1)
        encoded = encoded .. b:sub((x >> 12 & 0x3F) + 1, (x >> 12 & 0x3F) + 1)
        encoded = encoded .. (padding > 1 and '=' or b:sub((x >> 6 & 0x3F) + 1, (x >> 6 & 0x3F) + 1))
        encoded = encoded .. '='
    end

    return encoded:sub(1, #encoded - padding) 
end

function crypt.base64decode(input)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local decoded = ''
    local padding = 0

    if input:sub(-1) == '=' then padding = padding + 1 end
    if input:sub(-2, -2) == '=' then padding = padding + 1 end

    for i = 1, #input, 4 do
        local a, b, c, d = input:byte(i, i + 3)
        
        if not a then break end 
        local x = ((b and (b - 65) or 0) << 18) + ((c and (c - 65) or 0) << 12) + ((d and (d - 65) or 0) << 6) + (a - 65)
        decoded = decoded .. string.char((x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF)
    end

    return decoded:sub(1, #decoded - padding) 
end




--* aliases

crypt.base64_encode = crypt.base64encode
crypt.base64_encode = crypt.base64encode
crypt.base64encode = crypt.base64encode
crypt.base64_encode = crypt.base64encode

crypt.base64decode = crypt.base64decode
crypt.base64_decode = crypt.base64decode
crypt.base64decode = crypt.base64decode
crypt.base64_decode = crypt.base64decode

getidentity = getthreadidentity
getthreadcontext = getthreadidentity

setidentity = setthreadidentity
setthreadcontext = setthreadidentity

function toclipboard(...)
  return setclipboard(...)
end

function setrbxclipboard(...)
  return setclipboard(...)
end

function getexecutorname()
  return identifyexecutor()
end
