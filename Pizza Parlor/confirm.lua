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

--Declare local vars
local setNotification = {}
local bg
local backBtn
local navHeight = Prefs.nav.height


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
    
    local newTxt = display.newText("Your order is in the Oven", 0, 0, system.nativeFont, 24)
    newTxt.x = _screen.center.x
    newTxt.y = _screen.center.y
    
    --temp back btn
    --Create a back button & position
    local font = Prefs.menu.font
    local size = Prefs.menu.size
    backBtn = display.newText("Close", 0,0, font, size)
    backBtn.anchorX = 0
    backBtn.x = Prefs.margin
    backBtn.y = navHeight * 0.5
    
    self.view:insert(bg)
    self.view:insert(newTxt)
    self.view:insert(backBtn)

end


function scene:show(e)
    if(e.phase == "will") then
        --create function to perform task
        function backBtn:tap(e)
            composer.gotoScene("menu", {effect = "slideRight"})
        end
        backBtn:addEventListener("tap", backBtn)
    end
end

function scene:hide(e)
    if(e.phase == "will") then
        --temp
        composer.removeScene("confirm")
        
    end
    
end


--add event listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene


