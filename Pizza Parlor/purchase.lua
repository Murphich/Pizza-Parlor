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



local bg
local confirmBtn
local navHeight = Prefs.nav.height
local mapBtn
local addBtn
local backBtn


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
    bg.fill = brownGradientFill
    
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
    
 ---------------------------------------
 --Bring in current loc
 --------------------------
 
 -- Create a native map view
local myMap = native.newMapView( 20, 20, 280, 360 )
myMap.x = display.contentCenterX

local attempts = 0

local locationText = display.newText( "Location: ", 0, 400, native.systemFont, 16 )
locationText.anchorY = 0
locationText.x = display.contentCenterX

local function locationHandler( event )

    local currentLocation = myMap:getUserLocation()

    if ( currentLocation.errorCode or ( currentLocation.latitude == 0 and currentLocation.longitude == 0 ) ) then
        locationText.text = currentLocation.errorMessage

        attempts = attempts + 1

        if ( attempts > 10 ) then
            native.showAlert( "No GPS Signal", "Can't sync with GPS.", { "Okay" } )
        else
            timer.performWithDelay( 1000, locationHandler )
        end
    else
        locationText.text = "Current location: " .. currentLocation.latitude .. "," .. currentLocation.longitude
        myMap:setCenter( currentLocation.latitude, currentLocation.longitude )
        --myMap:addMarker( currentLocation.latitude, currentLocation.longitude )
    end
end

--locationHandler()
 

    mapBtn = widget.newButton{
        defaultColor = { 148, 233, 255, 255},
        overColor = {128, 128, 128, 125},
        onRelease = locationHandler,
        label = "Show Location",
        emboss = true,
        width = 145,
        height = 30,
        fontSize = 14,
        left = 10,
        top = 223
    }
    
    addBtn = widget.newButton{
        defaultColor = {204, 255, 124, 255},
        overColor = {128, 128, 128, 125},
        onRelease = onLocation,
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
    
    self.view:insert(mapBtn)
    self.view:insert(addBtn)
    --self.view:insert(pickerWheel)
    --self.view:insert(locationLbl)

    
    --self.view:insert(columnData)
    --self.view:insert(createPicker)


end

function scene:show(e)
    if(e.phase == "will") then
        --create function to perform task
        function backBtn:tap(e)
            composer.gotoScene("inventory", {effect = "slideRight"})
        end
        backBtn:addEventListener("tap", backBtn)
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