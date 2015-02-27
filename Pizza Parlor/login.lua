--Incorporate the composer functionality
local composer = require("composer")
--initiate sceen object
local scene = composer.newScene()
--initiate widget object
local widget = require ("widget")
--initiate Pizza Database
local login = require ("memDb")
-- require Prfes for formatting
local Prefs = require("Prefs")

login = {}
validLogin = false


--Declare Variable
local bg
local homeBtn
local navHeight = Prefs.nav.height
local registerBtn
local loginBtn
--New stuff
local usernameField
local passwordField
local emailField

local fieldGrp

--------------------------------
-- save input settings function
--------------------------------
    local function saveSettings()
            native.setKeyboardFocus( nil )
            updateCustomerData(usernameField.text, passwordField.text, emailField.text)
            --checkLoginDetails(true)
    	if not validLogin then
    		native.showAlert( "Invalid Login", "An account with that username and password wasn't found (or, Please try and Register).", {"OK"}  )
    	end
    --
    end -- saveSettings

--Function to check for existing user
local function onCompleteLog(e)
    local password = login.password or "x"
    local username = login.username or "x"
    local email = login.email or "x"
    
    --updateCustomerData(usernameField.text, passwordField.text, emailField.text)
        if username == nil or password == nil or email == nil or username == "" or password == "" or email == "" then
            native.showAlert("Error", "You must enter a valid username, password and email", {"OK"})
        elseif
            username ~= nil or password ~= nil or email ~= nil or username ~= "" or password ~= "" or email ~= "" then
            native.showAlert("Congrats", "You have successfully logged in", {"OK"})

            function loginBtn:tap(e)
                --username ~= nil or password ~= nil or email ~= nil or username ~= "" or password ~= "" or email ~= "" then
                composer.gotoScene("inventory", {effect = "slideRight"})
            end
                loginBtn:addEventListener("tap", loginBtn)
    end
end

-- Create scene
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
    
    --create a button to return to the menu and locate it
    local font = Prefs.menu.font
    local size = Prefs.menu.size
    homeBtn = display.newText("Home", 0,0, font, size)
    homeBtn.anchorX = 0
    homeBtn.x = Prefs.margin
    homeBtn.y = navHeight * 0.5

    --create Login button
    loginBtn = widget.newButton{
        defaultColor = {204, 255, 124, 255},
        overColor = {128, 128, 128, 125},
        --onRelease = onLocation,
        label = "Register/Login",
        fontSize = 14,
        --call save settings ()
        --onRelease = checkLoginDetails
        onRelease = onCompleteLog
    }
    --postion login button
    loginBtn.x = 220
    loginBtn.y = 270

    --insert to group
    self.view:insert(bg)
    self.view:insert(homeBtn)
    self.view:insert(loginBtn)

end

function scene:show(e)
    local group = self.view

    local login = loadCustomerData()
    --local login = insertCustomerData()

    --create a group
    fieldGrp = display.newGroup ()

--------------------------------
-- imput username function
--------------------------------
    local function onUsername( event )
        print(event.phase)
        if ( "began" == event.phase ) then
	   -- Note: this is the "keyboard appearing" event
	
        elseif ( "submitted" == event.phase ) then
	    -- save any changes to username
	    --saveSettings()
            checkLoginDetails()
            --newCust()
            -- Automatically tab to password field if user clicks "Return" on keyboard 
            native.setKeyboardFocus( usernameField )
        end
    end
    
--------------------------------
-- imput password function
--------------------------------   
    local function onPassword (event)
        print(event.phase)
	    -- Automatically tab to email field if user clicks "Return"
        if ( "submitted" == event.phase ) then
	    -- save any changes to password
	    --saveSettings()
            checkLoginDetails()
            --newCust()
            native.setKeyboardFocus( passwordField )
        end
    end
    
--------------------------------
-- imput email function
--------------------------------   
    local function onEmail( event )
	print(event.phase)
            if event.phase == "began" then
		--fieldGrp.y = fieldGrp.y - 50
            end
            if event.phase == "ended" or event.phase == "cancelled" then
		--fieldGrp.y = fieldGrp.y + 50
            end
	    -- Hide keyboard when the user clicks "Return" in this field
	    if ( "submitted" == event.phase ) then
	    	-- save any changes to password
	    	--saveSettings()
                checkLoginDetails()
                --newCust()
	        native.setKeyboardFocus( emailField )
	    end
    end
    
--------------------------------
-- Layout input fields
-------------------------------- 
        local font = Prefs.menu.font
        local size = Prefs.menu.size
        local usernameLbl = display.newText(group, "Name", 0, 0, font, size)
        usernameLbl:setTextColor ( 1, 1, 1 )
        usernameLbl.anchorX = 0
        usernameLbl.x = Prefs.margin + 10
        usernameLbl.y = navHeight * 0.5 + 65
        
        --Creates text field for keyboard to enter details
        usernameField = native.newTextField (0,0, display.contentWidth - 40, 30 )
        usernameField:addEventListener("userInput", onUsername)
        --entered field is to be entered and passed to username
        usernameField.text = login.username
        usernameField.anchorX = 0
        usernameField.x = Prefs.margin + 10
        usernameField.y = navHeight * 0.5 + 85
                
                
	local passwordLbl = display.newText( group, "Password", 0, 0, font, size )
	passwordLbl:setTextColor ( 1, 1, 1 )
        passwordLbl.anchorX = 0
        passwordLbl.x = Prefs.margin + 10
        passwordLbl.y = navHeight * 0.5 + 125
        
	passwordField = native.newTextField(0, 0, display.contentWidth - 40, 30 )
	passwordField:addEventListener ("userInput", onPassword)
        --entered field is to be entered and passed to password
        passwordField.text = login.password
        passwordField.anchorX = 0
        passwordField.x = Prefs.margin + 10
        passwordField.y = navHeight * 0.5 + 145
     

	local emailLbl = display.newText( group, "Enter Email", 0, 0, font, size )
	emailLbl:setTextColor ( 1, 1, 1 )
        emailLbl.anchorX = 0
        emailLbl.x = Prefs.margin + 10
        emailLbl.y = navHeight * 0.5 + 185
        
	emailField = native.newTextField(0,0, display.contentWidth - 40, 30 )
	emailField:addEventListener ("userInput", onEmail)
        --entered field is to be entered and passed to email
        emailField.text = login.email
        emailField.anchorX = 0
        emailField.x = Prefs.margin + 10
        emailField.y = navHeight * 0.5 + 205
	--emailField.font = native.newFont( native.systemFontBold, 14 )
	emailField.inputType = "email"
	emailField:setTextColor( 51, 51, 122, 255 )
        
        --group all fields
	fieldGrp:insert(usernameLbl)
	fieldGrp:insert(passwordLbl)
	fieldGrp:insert(emailLbl)
	fieldGrp:insert(usernameField)
	fieldGrp:insert(passwordField)
	fieldGrp:insert(emailField)
    
        
	group:insert(fieldGrp)
        
    --conditional statement to effectively transition to new page
    if(e.phase == "will")then
        function homeBtn:tap(e)
            composer.gotoScene("menu", {effect = "slideRight"})
        end
        homeBtn:addEventListener("tap", homeBtn)
    end
end --End show scene

function scene:hide(e)
    if(e.phase == "will")then
        composer.removeScene("login")
    end
end

--add listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
