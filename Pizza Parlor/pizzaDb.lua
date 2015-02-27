--Set up Sqlite3 Db for inventory
require "sqlite3"

local function setUpDatabase(dbName)
        --copy db if it doesnt exist
        local path = system.pathForFile (dbName, system.DocumentsDirectory)
        local file = io.open(path, "r")
        
        if (file == nil) then
            --copy the db file if it doesnt exist
            local pathSource = system.pathForFile(dbName, system.ResourceDirectory)
            local fileSource = io.open(pathSource, "r")
            local contentsSource = fileSource:read("*a")
            
            local pathDest = system.pathForFile(dbName, system.DocumentDirectory)
            local fileDest = io.open(pathDest, "w")
            fileDest:write(contentsSource)
            
            io.close(fileSource)
            io.close(fileDest)
        end
        
        local myDb = system.pathForFile(dbName, system.DocumentsDirectory)
        local dbNew = sqlite3.open(myDb)
        
        return dbNew
end

----------------------------------------
--This function allows us to SELECT data
----------------------------------------
local function loadData()
    local sql = "SELECT * FROM pizzaInven" -- this is the sql for the table in the db
    local pizzaInven  = {} -- we must now create a lua table for the same name as the db table
    
    for a in db:nrows(sql) do
        pizzaInven[#pizzaInven+1] = 
        {
            id = a.id,
            name = a.name,
            thumbnail = a.thumbnail,
            image = a.image,
            description = a.description
        }
    end
    return pizzaInven -- must return the table to whoever is calling it
end

----------------------------------------
--This function allows us to INSERT data
----------------------------------------
local function insertData(n, t, i, d)
    local sql = "INSERT INTO pizzaInven (name, thumbnail, image, description) VALUES ('" .. n .. "', '" .. t .. "', '" .. i .. "', '" .. d .. "')"
    db:exec(sql)
end

----------------------------------------
--This function allows us to DELETE data
----------------------------------------
local function deleteData(id)
    local sql = "DELETE FROM pizzaInven WHERE id = " .. tostring(id)
    db:exec(sql)
end

----------------------------------------
--This function allows us to UPDATE data
----------------------------------------
local function updateData(id, col, v)
    local sql = "UPDATE pizzaInven SET " .. col .. " = '" .. v .. "' WHERE id = " .. tostring(id)
    db:exec(sql)
end


-------------------------------------------------
--This function allows us to SELECT Customer data
-------------------------------------------------
local function loadCustomerData()
    local sql = "SELECT * FROM login" -- this is the sql for the table in the db
    local login  = {} -- we must now create a lua table for the same name as the db table
    
    for a in db:nrows(sql) do
        login[#login+1] = 
        {
            id = a.id,
            name = a.name,
            pword = a.password,
            email = a.email
        }
    end
    return login -- must return the table to whoever is calling it
end




db = setUpDatabase("myPizzaDatabase.sqlite") -- the params have the name of my db
--[[Bellow code if for coding input and editiong of db]
        --comment out below for removal of inserting function
        --insertData("Calabresa", "Small picture", "Large picture", "This is the best pizza")

        --Now enter function to delete data
        --deleteData(6)

        --Update Function call (copy/paste for multiple updates)
        --updateData(5, "id", 4)
]]
--now call it
local data = loadData()
    for i = 1, #data do
        print (data[i].id .. " = " .. data[i].name .. ", and " .. data[i].thumbnail ..", and " .. data[i].image .. " : " ..  data[i].description)
    end
return data




