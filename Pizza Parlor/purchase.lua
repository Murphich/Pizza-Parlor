local composer = require ("composer")
--create new scene
local scene = composer.newScene()
--load widget lib
local widget = require("widget")
--widget.setTheme("theme_android")
--load pizzaDb
local pizzaDb = require("pizzaDb")
--import Prefs
local Prefs = require("Prefs")

--Declare Variables
local bg
local confirmBtn
local navHeight = Prefs.nav.height
local mapBtn
local addBtn
local backBtn
--local values
local fieldGrp

local picker
local myMap
local locationField
local top = display.statusBarHeight

--Create scene
function scene:create(e)
      local brownGradientFill ={
        type = "gradient",
        -- Brown color
        color1 = {87/255, 37/255, 0, 1},
        --Darker shade brown
        color2 = {38/255, 16/255, 0, 1},
        --implement direction of shade
        direction = "down"
      }
    --create new rect for background shading
    bg = display.newRect(0,0, _screen.Width, _screen.Height)
    --position background
    bg.x = _screen.center.x
    bg.y = _screen.center.y
    --fill background with gradient
    bg:setFillColor(brownGradientFill)
    
    --showMap()
    
    --Create a purchase button & position
    local font = Prefs.menu.font
    local size = Prefs.menu.size
    confirmBtn = display.newText("Confirm", 0,0, font, size)
    confirmBtn.anchorX = 0
    confirmBtn.x = Prefs.margin + 228
    confirmBtn.y = navHeight * 0.5
    
    --Create a back button & position
    font = Prefs.menu.font
    size = Prefs.menu.size
    backBtn = display.newText("Other Pizzas", 0,0, font, size)
    backBtn.anchorX = 0
    backBtn.x = Prefs.margin
    backBtn.y = navHeight * 0.5
        
    --Automatically call location function
    --Copied code from below due to time constraints
    local myMap1 = native.newMapView( 20, 20, 280, 360 )
    myMap1.x = display.contentCenterX
    --keep attempts to one
    local attempts = 0
    
    local locationText1 = display.newText( "Location: ", 0, 100, native.systemFont, 16 )
    locationText1.anchorY = 0
    locationText1.x = display.contentCenterX

    local function locationHandler1( event )

        local currentLocation = myMap1:getUserLocation()

        if ( currentLocation.errorCode or ( currentLocation.latitude == 0 and currentLocation.longitude == 0 ) ) then
            locationText1.text = currentLocation.errorMessage
            
            --retry location setting
            attempts = attempts + 1

            if ( attempts > 4 ) then
                native.showAlert( "No GPS Signal", "Can't sync with GPS.", { "Okay" } )
            else
                timer.performWithDelay( 1000, locationHandler1 )
            end
        else
            locationText1.text = "Current location: " .. currentLocation.latitude .. "," .. currentLocation.longitude
            myMap1:setCenter( currentLocation.latitude, currentLocation.longitude )
            --myMap:addMarker( currentLocation.latitude, currentLocation.longitude )
            --self.view:insert(locationText1)
        end
    end
    locationHandler1()
 --------------------------
 --Bring in current loc
 --------------------------
 
 -- Create a native map view
local function showMap()
    --remove loction fucntions
    display.remove(addNewLocation)
    display.remove(locationField)
    local myMap = native.newMapView( 20, 20, 280, 360 )
    myMap.x = display.contentCenterX

    local attempts = 0

    local locationText = display.newText( "Location: ", 0, 100, native.systemFont, 16 )
    locationText.anchorY = 0
    locationText.x = display.contentCenterX

    local function locationHandler( event )

        local currentLocation = myMap:getUserLocation()
        
        if ( currentLocation.errorCode or ( currentLocation.latitude == 0 and currentLocation.longitude == 0 ) ) then
            locationText.text = currentLocation.errorMessage
            
            --retry location setting
            attempts = attempts + 1

            if ( attempts > 4 ) then
                native.showAlert( "No GPS Signal", "Can't sync with GPS.", { "Okay" } )
            else
                timer.performWithDelay( 1000, locationHandler )
            end
        else
            --display present co-ordinates
            locationText.text = "Current location: " .. currentLocation.latitude .. "," .. currentLocation.longitude
            myMap:setCenter( currentLocation.latitude, currentLocation.longitude )
            --myMap:addMarker( currentLocation.latitude, currentLocation.longitude )
            self.view:insert(locationText)
        end
    end
    locationHandler()
end -- close show map function


    --trim all white space
    local function trim (s)
        return (string.gsub(s, "^%s*(.-_%s*", "%1"))
    end

--Creat picker whaeel
        local function createPicker(selNum)
            local group = self.view

            --create a group
            fieldGrp = display.newGroup ()
            
            -- Create two tables to hold data for days and years      
            local number = {}
            local zip = {}

            -- Populate the num table
            for n = 1, 30 do
                number[n] = n
            end
            
            -- Populate the zip table
            for n = 1, 30 do
                number[n] = n
            end

            -- Configure the picker wheel columns
            local columnData = 
            {
                -- Town
                { 
                    align = "left",
                    width = 140,
                    startIndex = 2,
                    labels = { "Baldoyle", "Bayside", "Sutton", "Howth", "Killbarrack" }
                },
                -- Number
                {
                    align = "left",
                    width = 60,
                    startIndex = 18,
                    labels = number
                },
                
                -- zip
                {
                    align = "center",
                    width = 80,
                    startIndex = 2,
                    labels = number
                }
            }

            -- Image sheet options and declaration
            local options = {
                frames = 
                {
                    { x=0, y=0, width=320, height=222 },
                    { x=320, y=0, width=320, height=222 }
                    --{ x=640, y=0, width=8, height=222 }
                },
                sheetContentWidth = 648,
                sheetContentHeight = 222
            }
            local pickerWheelSheet = graphics.newImageSheet(group, "images/pickersheet.png", options )

            -- Create the widget
            local pickerWheel = widget.newPickerWheel
            {
                group,
                top = display.contentHeight - 222,
                columns = columnData,
                sheet = pickerWheelSheet,
                overlayFrame = 1,
                overlayFrameWidth = 320,
                overlayFrameHeight = 222,
                backgroundFrame = 2,
                backgroundFrameWidth = 320,
                backgroundFrameHeight = 222,
                separatorFrame = 3,
                separatorFrameWidth = 8,
                separatorFrameHeight = 222,
                columnColor = { 0, 0, 0, 0 },
                fontColor = { 0.4, 0.4, 0.4, 0.5 },
                fontColorSelected = { 0.2, 0.6, 0.4 }
            }

            -- Get the table of current values for all columns
            -- This can be performed on a button tap, timer execution, or other event
            local values = pickerWheel:getValues()

            -- Get the value for each column in the wheel (by column index)
            local currentStreet = values[1].index
            local currentNum = values[2].value
            local currentTown = values[3].value

            print( currentStreet, currentNum, currentTown )
            --
            self.view:insert(pickerWheelSheet)
            self.view:insert(pickerWheel)
            self.view:insert(columnData)
            self.view:insert(number)

            --self.view:insert(createPicker)
            
            fieldGrp:insert(pickerWheel)
            fieldGrp:insert(pickerWheelSheet)
            --fieldGrp:insert(locationText1)

        end

        local function addNewLocation()
            --remove location field so data to enter can appear
            display.remove(locationText1)
            --display.remove(locationField)
            local locationLbl
            local gotEnd = false

            local function onLocation(event)
                if (event.phase == "began") then
                elseif (event.phase == "submitted") or (event.phase == "ended") and not gotEnd then
                    gotEnd = true
                    local newLoc = locationField.text
                        if trim(newLoc) ~= "" then
                            --new bug which has only appeared at a late stage
                            columnData[1][#columnData[1]+1] = newLoc
                        end

                    native.setKeyboardFocus(nil)
                    --remove the keyboard
                    display.remove(locationLbl)
                    display.remove(locationField)
                    local values = picker:getValues()
                    local selNum = values[1].values

                    --remove the picker
                    display.remove(picker)
                    picker = nil
                    --create a new picker so the new location can be displayed
                    createPicker(selNum)
                end
            end

            --Create location lable so information of new location can be passed through
            locationLbl = display.newText("New Location", 0, 0, font, size)
            locationLbl:setTextColor (244, 255, 251)
            locationLbl.anchorX = 0
            locationLbl.x = Prefs.margin + 10
            locationLbl.y = navHeight * 0.5 + 65

            -- Text Field to allow user to input data
            locationField = native.newTextField(0, 0, display.contentWidth -40, 30)
            locationField:addEventListener ("userInput", onLocation)
            locationField.font = native.newFont(native.systemFontBold, 14)
            locationField:setTextColor(51, 51, 122, 255)
            locationField.anchorX = 0
            locationField.x = Prefs.margin + 10
            locationField.y = navHeight * 0.5 + 85
            --calls keyboard when the locationField is called (doesn't work on simulator)
            native.setKeyboardFocus (locationField)
    
        self.view:insert(locationField)
        self.view:insert(locationLbl)

    
        end

        --createPicker()

-- add show map button
        mapBtn = widget.newButton{
                defaultColor = { 148, 233, 255, 255},
                overColor = {128, 128, 128, 125},
                onRelease = showMap,
                label = "Show Location",
                emboss = true,
                width = 145,
                height = 30,
                fontSize = 14,
                left = 10,
                top = 223
            }
            
-- add location button
        addBtn = widget.newButton{
                defaultColor = {204, 255, 124, 255},
                overColor = {128, 128, 128, 125},
                onRelease = addNewLocation,
                label = "Add Your Location",
                emboss = true,
                width = 145,
                height = 30,
                fontSize = 14,
                left = 150,
                top = 223
            }


    --Group display objects
    self.view:insert(bg)
    self.view:insert(confirmBtn)
    self.view:insert(backBtn)
    self.view:insert(addBtn)
    self.view:insert(mapBtn)
    self.view:insert(locationText1)



end -- end create

function scene:show(e)
    if(e.phase == "will") then
    
        --create function to perform task
        function backBtn:tap(e)
            composer.gotoScene("inventory", {effect = "slideRight"})
        end
    else
        function confirmBtn:tap(e)
            composer.gotoScene("confirm", {effect = "fade"})
        end
        backBtn:addEventListener("tap", backBtn)
        confirmBtn:addEventListener("tap", confirmBtn)

    end
end

function scene:hide(e)
    if(e.phase == "will") then
        composer.removeScene("purchase")
    end
end

--add event listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

--return scene object
return scene