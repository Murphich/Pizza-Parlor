--Implement Json
local json = require ("json")

local Prefs
-- Create file "Prefs.txt" in DocDirect
local path = system.pathForFile("Prefs.txt", system.DocumentsDirectory)
local file = io.open(path)

local function readPrefs()
    print ("Prefs file exists, now loading")
    --must be able to read the file if it does exist
    local content = file:read("*a")
    -- so now decode the content string and decode it to the Prefs table
    Prefs = json.decode(content) 
end

local function initPrefs ()
    print ("Prefs file doesnt exist, will create it")
    --create a Preference table
    Prefs = {}
    --create a constant for height
    Prefs.nav ={
        height = 44
    }
    --Create margin to a constant
    Prefs.margin = 12
    
    --Prefs for Header
    Prefs.header = {
        font = "AmericanTypewriter-Bold" or native.SystemFont,
        size = 36,
        color = {1,1,1,1}
    }
    --Create PRefs for a subheader
    Prefs.subheader = {
        --keep font consistant with main header
        font = Prefs.header.font,
        size = 24,
        color = {1,1,1,1}
    }
    --Create Prefs for body
    Prefs.body = {
        font = "AmericanTypewriter" or native.SystemFont,
        size = 16
    }
    --Prefs for the body
    Prefs.menu = {
        --keep font same as header
        font = Prefs.header.font,
        size = 18
    }
    
end

--local function to save the preferences
local function savePrefs()
    --create local prefs for functions
    local prefs = {}
    --don't allow function change data
    for key,val in pairs(Prefs) do
        local kind = type(val)
        if(kind ~= "function") then
            prefs[key] = val
        end
    end
    
    --
    file = io.open(path, "w")
    --json takes local table and makes it json readable
    local JSON_Prefs = json.encode(prefs)
    file:write(JSON_Prefs)
    io.close(file)
end

    if(file) then
        readPrefs()
    else 
        initPrefs()
        savePrefs()
    end

return Prefs



