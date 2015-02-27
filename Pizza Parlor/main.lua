--Global variables for positioning purposes
_screen =
{
    Height = display.contentHeight,
    Width = display.contentWidth
}

--add to screen table at the center
_screen.center = {
   x = display.contentCenterX,
   y = display.contentCenterY
}

--Hide the display object
display.setStatusBar(display.HiddenStatusBar)

--include composer
local composer = require ("composer")
local login = require ("memDb")
composer.gotoScene("menu")

-- Cancel the notifications
    system.cancelNotification()
    
-- Reset badge if showing
    native.setProperty("applicationIconBadgeNumber", 0)

    local function setNotification()
        local options = {
            alert = "The Pizza has left our building",
            badge = "1"
        }
        
        --manually set notification timelimit
        local secsFromNow = 20
        local notification = system.scheduleNotification(secsFromNow, options)
        
    end

--When app is closed call to the notifications function
local function onSystemEvent (event)
    if (event.type == "applicationExit") then
        login = loadCustomerData()
            if login.notify then
                setNotification()
            end
        db:close()
    end
end

--Runtime event to catch application Exit
Runtime:addEventListener ("system", onSystemEvent)

