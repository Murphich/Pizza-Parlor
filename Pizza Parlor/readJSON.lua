local json = require ("json")
--import my url for pizza db
local dataURL = "http://conormurphy11.site88.net/myDb2.php"

--create newDataList
local function newDataListener(event)
    if (event.isError) then
        print ("Error - no connection")
    else
        --decode json formatted data
        local t = event.response
        t = json.decode(t)
        if #t > 0 then
            print ("Number of records: " .. tostring(#t))
        else
            print("No new records found.")
        end
        
    end
end


--create network req
network.request (dataURL, "GET", newDataListener )




