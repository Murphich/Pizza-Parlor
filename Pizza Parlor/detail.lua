local composer = require ("composer")
local scene = composer.newScene()
--load widget lib
local widget = require("widget")
--load pizzaDb
local pizzaDb = require("pizzaDb")
--import Prefs
local Prefs = require("Prefs")

--Declare variables for the details scene
local navHeight = Prefs.nav.height
local bg
local img
local titleText
local shadowText
local descriptionText
local backBtn
local buyBtn

function scene:create(e)
    --import params from prev scene
     local index = e.params.index
     local pizza = pizzaDb[index]
     --load background again
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
    
    --Large image of the pizza
    --Set scale to full width and 180 height
    img = display.newImageRect(pizza.image, 320, 180)
    img.anchorX = 0
    img.anchorY = 0
    img.y = navHeight
    
    --The Title name resized
    local font = Prefs.subheader.font
    local size = Prefs.subheader.size
    titleText = display.newText(pizza.name, 0,0, font, size)
    titleText.anchorX = 0
    titleText.anchorY = 1
    titleText.x = Prefs.margin
    titleText.y = img.y + img.height - Prefs.margin
    
    --Shadow title to be placed ontop of title to create effect
    shadowText = display.newText(pizza.name, 0,0, font, size)
    shadowText.anchorX = 0
    shadowText.anchorY = 1
    --postiton the text one pixle over titleText
    shadowText.x = titleText.x + 1
    shadowText.y = titleText.y + 1
    --black for shadow effect
    shadowText.fill = {0,0,0,1}

    --Outline decription
    font = Prefs.body.font
    size = Prefs.body.size
    descriptionText = display.newText({
        text = pizza.description,
        width = _screen.Width - (Prefs.margin * 2),
        font = font,
        fontSize = size
    })
    
    --postion description
    descriptionText.anchorX = 0
    descriptionText.anchorY = 0
    descriptionText.x = Prefs.margin
    descriptionText.y = img.y + img.height + Prefs.margin
    
    --Create a back button & position
    font = Prefs.menu.font
    size = Prefs.menu.size
    backBtn = display.newText("Other Pizzas", 0,0, font, size)
    backBtn.anchorX = 0
    backBtn.x = Prefs.margin
    backBtn.y = navHeight * 0.5
    
     --Create a buy button & position
    font = Prefs.menu.font
    size = Prefs.menu.size
    buyBtn = display.newText("Buy", 0,0, font, size)
    buyBtn.anchorX = 0
    buyBtn.x = Prefs.margin + 258
    buyBtn.y = navHeight * 0.5
    
    --Group all variables
    self.view:insert(bg)
    self.view:insert(img)
    --Display pref for text shading for either of these
    self.view:insert(shadowText)
    self.view:insert(titleText)
    self.view:insert(descriptionText)
    self.view:insert(backBtn)
    self.view:insert(buyBtn)
end

function scene:show(e)
    if(e.phase == "will")then
        --create function to perform task
        function backBtn:tap(e)
            composer.gotoScene("inventory", {effect = "slideRight"})
        end
    else
        function buyBtn:tap(e)
           composer.gotoScene("purchase", {effect = "slideUp"})
        end
        --add event listener for back button
        backBtn:addEventListener("tap", backBtn)
        buyBtn:addEventListener("tap", buyBtn)

    end
end

function scene:hide(e)
    if(e.phase == "will")then
        composer.removeScene("detail")
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene