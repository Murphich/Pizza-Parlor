local composer = require ("composer")
--initiate sceen object
local scene = composer.newScene()
--initiate widget object
local widget = require ("widget")
-- require Prfes for formatting
local Prefs = require("Prefs")

--Declare Vars
local bg
local navHeight = Prefs.nav.height
local backBtn
local credits
local credits1
local credits2
local credits3
local credits4
local credits5
local creditsX
local fieldGrp

--Implement create scene
function scene:create(e)
    local group = self.view
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
    
   
    --create a button to return to the menu and locate it
    local font = Prefs.menu.font
    local size = Prefs.menu.size
    backBtn = display.newText("Back", 0,0, font, size)
    backBtn.anchorX = 0
    backBtn.x = Prefs.margin
    backBtn.y = navHeight * 0.5
    
    local font = Prefs.body.font
    local size = Prefs.body.size    
    credits = display.newText ("Pizza Parlor", 0, 0, font, size)
    credits.anchorX = 0
    credits.x = 120
    credits.y = 110

    credits1 = display.newText ("Created by Conor Murphy", 0, 0, font, size)
    credits1.anchorX = 0
    credits1.x = 60
    credits1.y = 130
    
    credits2 = display.newText ("This app was created as a first", 0, 0, font, size)
    credits2.anchorX = 0
    credits2.x = 55
    credits2.y = 200
    
    credits3 = display.newText ("project for the company 3 young", 0, 0, font, size)
    credits3.anchorX = 0
    credits3.x = 45
    credits3.y = 215
    
    credits4 = display.newText ("mugs, and is intended to be used", 0, 0, font, size)
    credits4.anchorX = 0
    credits4.x = 45
    credits4.y = 230
    
    credits5 = display.newText ("by customers and owners.", 0, 0, font, size)
    credits5.anchorX = 0
    credits5.x = 60
    credits5.y = 245

    creditsX = display.newText ("Copyright 2015.", 0, 0, font, 10)
    creditsX:setFillColor(1,1,1)
    creditsX.anchorX = 0
    creditsX.x = 130
    creditsX.y = 148
    
    --group all disp objectss
    fieldGrp = display.newGroup ()
    
    fieldGrp:insert(bg)
    fieldGrp:insert(credits)
    fieldGrp:insert(credits1)
    fieldGrp:insert(credits2)
    fieldGrp:insert(credits3)
    fieldGrp:insert(credits4)
    fieldGrp:insert(credits5)
    fieldGrp:insert(creditsX)
    fieldGrp:insert(backBtn)
    
    group:insert(fieldGrp)
    
end

function scene:show(e)
    if(e.phase == "will")then
        function backBtn:tap(e)
            composer.gotoScene("menu", {effect = "slideRight"})
        end
        --add event listener for menu button
        backBtn:addEventListener("tap", backBtn)
    end
end
--Implement hide scene

function scene:hide(e)
    if(e.phase == "will")then
        composer.removeScene("info")
    end
end
--add listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
-- Return scene
return scene
