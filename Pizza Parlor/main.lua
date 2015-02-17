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
composer.gotoScene("menu")


