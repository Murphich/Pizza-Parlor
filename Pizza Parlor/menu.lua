--Incorporate the composer functionality
local composer = require ("composer")
--initiate sceen object
local scene = composer.newScene()
--Import Prefs module
local Prefs = require("Prefs")

local widget = require ("widget")

-- require "sqlite3"

--Declare Variables
local bg
local pizza
local titleText
local inventoryText
local titleGroup
local infoPg


--creating handling functions
--create function
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
    
    --Load image of pizzas main screen..
    pizza = display.newImageRect("images/pizza_parlor.png",220, 170)
    -- Make image appear
    pizza.alpha = 0
    
    --Create Title Text
    local font = Prefs.header.font
    local size = Prefs.header.size
    titleText = display.newText("Pizza Parlor", 0, 0, font, size)
    --Set Text hidden
    titleText.alpha = 0
    
    --Create Menu text
    font = Prefs.subheader.font
    size = Prefs.subheader.size
    inventoryText = display.newText("Browse Pizzas", 0, 0, font, size)
    --Set InventoryText hidden
    inventoryText.alpha = 0
    
      --Create Menu text
    font = Prefs.subheader.font
    size = Prefs.subheader.size
    infoPg = display.newText("i", 0, 0, font, size)
    --Set InventoryText hidden
    infoPg.alpha = 1
    
    --create Overlay for login
    local function handleButtonEvent(event)
        if ("ended" == event.phase) then
            composer.showOverlay(event.target.goto,{effect = "fade"})
        end
            
    end
    

    --Now group the display assets
    titleGroup = display.newGroup()
    
    --insert assets within group
    titleGroup:insert(pizza)
    titleGroup:insert(titleText)
    titleGroup:insert(inventoryText)
    titleGroup:insert(infoPg)
    
    --position the text object
    titleText.y = pizza.height * 0.5 + 20
    
    --position the menu text 
    inventoryText.y = titleText.y + inventoryText.height + 24

    --position the group within the screen
    titleGroup.x = _screen.center.x
    titleGroup.y = _screen.center.y - 60
    
    --position infoPg
    infoPg.x = _screen.center.x - 300
    infoPg.y = _screen.center.y + 40


    --insert into scene so transition scenes will operate
    self.view:insert(bg)
    self.view:insert(titleGroup)


--------------------------------------
-- Add transitions to code for effects
--------------------------------------
    --over 1 sec make pizza pop
    transition.from(pizza,{
        time = 1000, xScale = 0.1, yScale = 0.1,
        transition = easing.outBounce, onComplete = function()
            print ("Pizza popped")
        end
    })
    --transition pizza image to appear
    transition.to(pizza,{
        time = 1000, alpha = 1, transition = easing.outQuad,
        onComplete = function()
            print ("pizza appeared")
        end
    })
    transition.to(titleText,{
        time = 500, delay = 750, alpha = 1, transition = easing.outQuad,
        onComplete = function()
            inventoryText.alpha = 1
        end
    })
end

--show function
-- slide left to transition to the new scene
function scene:show(e)
    if(e.phase == "will") then
        function inventoryText:tap(e)
            composer.gotoScene("login", {effect = "slideLeft"})
        end
    else
        function infoPg:tap(e)
           composer.gotoScene("info", {effect = "slideUp"})
        end
        --add event listener
        inventoryText:addEventListener("tap", inventoryText)
        infoPg:addEventListener("tap", infoPg)
        
    end
end

--hide function
--remove current scene
function scene:hide(e)
    if(e.phase =="will") then
        composer.removeScene("menu")
    end
end

--add scene event listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)


--return scene object
return scene
