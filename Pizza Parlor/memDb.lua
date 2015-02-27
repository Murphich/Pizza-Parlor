-- Designed to be called if there is connectivity or not
function showNoConnectMessage()
	native.showAlert( "Network Error", "No wi-fi or cellular connection found.", {"OK"}  )
end

-- Actual DB password validation (presently over ruled for simulation purposes)
function checkLoginDetails(e)
    if validateDets then
            local login = loadCustomerData()
            local login = updateCustomerData()

            local password = login.password or ""
            local username = login.username or ""
            local email = login.email or ""
            --postData = "u=" .. username .. "&p=" .. password .. "&db=" .. tostring(daysBack)

                if username == nil or password == nil or email == nil or username == "" or password == "" or email == "" then
                    validLogin = false
                    native.showAlert("Limited Data", "You must enter a valid username, password and email", {"OK"})
                else if
                    username == "Conor" and password == "admin321" and email == "conormurphy11@gmail.com" then
                    print ("Yes, this is Conor")
                --else

                end
        end
    end
end

--Set up Sqlite3 Db for inventory
require "sqlite3"

local function setUpDatabase(dbName)
        
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

-------------------------------------------------
--This function allows us to SELECT Customer data
-------------------------------------------------
function loadCustomerData()
	local sql = "SELECT * FROM login LIMIT 1"
	local login = {}
	for a in db:nrows(sql)
	do
                login.id = a.id
		login.username = a.username
		login.password = a.password
		login.email = a.email
	end
	return login
end

----------------------------------------
--This function allows us to Update data
----------------------------------------
function updateCustomerData(u, p, e)

	local sql
sql = [[update settings set username = ']] .. u .. [[', password = ']] .. p .. [[', email = ']] .. e .. [['; ]]
	print(sql)
	db:exec(sql)

end


----------------------------------------
--This function allows us to INSERT data
----------------------------------------
function insertCustomerData(n, p, e)
    local sql = "INSERT INTO login (name, password, email, ) VALUES ('" .. n .. "', '" .. p .. "', '" .. e .. "')"
    db:exec(sql)
end

----------------------------------------
--This function allows us to DELETE data
----------------------------------------
function deleteCustomerData(id)
    local sql = "DELETE FROM login WHERE id = " .. tostring(id)
    db:exec(sql)
end

----------------------------------------
--This function allows us to UPDATE data
----------------------------------------
function updateCustomerData(id, col, v)
    local sql = "UPDATE login SET " .. col .. " = '" .. v .. "' WHERE id = " .. tostring(id)
    db:exec(sql)
end


db = setUpDatabase("myPizzaDatabase.sqlite") -- the params have the name of my db
--[[Bellow code if for coding input and editiong of db]
        --comment out below for removal of inserting function
        --insertCustomerData("Shane", "customer2", "shane@gmail.com")

        --Now enter function to delete data
        --deleteCustomerData()

        --Update Function call (copy/paste for multiple updates)
        --updateCustomerData(3, "password", "customer2")
        --updateCustomerData(4, "password", "customer3")
]]

--Return dets for calling
local customerData = loadCustomerData()
    for i = 1, #customerData do
        print (customerData[i].id .. " = " .. customerData[i].name .. ", and " .. customerData[i].password ..", and " .. customerData[i].email)
    end
return customerData







