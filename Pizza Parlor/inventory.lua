--Incorporate the composer functionality
local composer = require("composer")
--initiate sceen object
local scene = composer.newScene()
--initiate widget object
local widget = require ("widget")
--initiate Pizza Database
local pizzaDb = require ("pizzaDb")
--Import Prefs module
local Prefs = require("Prefs")
--local json = require ("json")
--local t = json.decode( jsonFile( "pizzaDb.json" ) )

--Declare Variables
local navHeight = Prefs.nav.height
local bg
local tableView
local menuBtn

--create local function for page layout
local function onRowRender(e)
    --create local variables for row display objects
    --row display group
    local row = e.row
    local rowIndex = row.index
    local rowLabel
    local rowThumbnail
    
    --invoke parameters
    rowLabel = e.row.params.title
    rowThumbnail = e.row.params.thumbnail
    
    --display and position thumbnail pic
    row.rowThumbnail = display.newImageRect(rowThumbnail, 60, 60)
    row.rowThumbnail.anchorX = 0
    row.rowThumbnail.x = Prefs.margin
    row.rowThumbnail.y = row.height * 0.5
    
    --postion the row text
    local font = Prefs.body.font
    local size = Prefs.body.size
    row.rowText = display.newText(rowLabel, 0, 0, font, size)
    row.rowText.anchorX = 0
    row.rowText.x = row.rowThumbnail.width + row.rowThumbnail.x + Prefs.margin
    row.rowText.y = row.height * 0.5
    row.rowText.fill = {0,0,0,1}
    
    row:insert(row.rowThumbnail)
    row:insert(row.rowText)
end

--Create function for touching a row
local function onRowTouch(e)
    if(e.phase == "tap") then
        if(e.target.params)then
            --go to new scene
            composer.gotoScene("detail",{ 
                effect = "slideLeft", 
                --transfere data across to other scene
                params = {
                    -- event target passes through that index
                    index = e.target.params.index
                }
            })   
        end
    end
end

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
    
    --create a button to return to the menu and locate it
    local font = Prefs.menu.font
    local size = Prefs.menu.size
    menuBtn = display.newText("Menu", 0,0, font, size)
    menuBtn.anchorX = 0
    menuBtn.x = Prefs.margin
    menuBtn.y = navHeight * 0.5
    
    --create a table and position it
    tableView = widget.newTableView({
        left = 0,
        top = navHeight,
        height = _screen.Height - navHeight,
        width = _screen.Width,
        --method invoked when a row is rendered
        onRowRender = onRowRender,
        --invoke method when row is touched
        onRowTouch = onRowTouch
    })
    
    --insert into scene so transition scenes will operate
    self.view:insert(bg)
    self.view:insert(tableView)
    self.view:insert(menuBtn)
    
    --Populate the table with rows of table info
    for i = 1, #pizzaDb do
        local pizza = pizzaDb[i].name
        local thumbnail = pizzaDb[i].thumbnail
        
        local params = {
            isCategory = false,
            rowHeight = 60,
            rowColor = {
                -- keep row white
                default = {1,1,1,1}, over = {1,1,1,1}
            },
            --Table to hold all data from pizzaDb
            params = {
                title = pizza,
                thumbnail = thumbnail,
                index = i
            }
        }
        --Insert the pizza row
        tableView:insertRow(params)
    end  
end

function scene:show(e)
    if(e.phase == "will") then
        function menuBtn:tap(e)
            composer.gotoScene("menu", {effect = "slideRight"})
        end
        --add event listener for menu button
        menuBtn:addEventListener("tap", menuBtn)
    end
end

function scene:hide(e)
    if(e.phase == "will") then
        composer.removeScene("inventory")
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

--return scene object
return scene
