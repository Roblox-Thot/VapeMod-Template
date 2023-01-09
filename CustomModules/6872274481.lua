local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local lplr = players.LocalPlayer
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local connections = {}

local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local checkpublicreponum = 0
local checkpublicrepo
checkpublicrepo = function()
	local suc, req = pcall(function() return requestfunc({
		Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872274481.lua",
		Method = "GET"
	}) end)
	if not suc then
		checkpublicreponum = checkpublicreponum + 1
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Loading CustomModule Failed!, Attempts : "..checkpublicreponum
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			task.wait(2)
			textlabel:Remove()
		end)
		task.wait(2)
		return checkpublicrepo()
	end
	if req.StatusCode == 200 then
		return req.Body
	end
	return nil
end
local publicrepo = checkpublicrepo()
if publicrepo then
    --Feel free to remove line 44 to use my
    --Bypasses/edits just know I won't update them!

    --[[
	local regex,repin
	-- disables and Vape Private user commands
	regex = 'local commands = {.*local AutoReport = {'
	repin =  "local commands = {} local AutoReport = {"
	publicrepo = string.gsub(tostring(publicrepo), regex,repin)
	
	-- attempts to give lplr admin (CLIENT SIDED)
	regex = 'WhitelistFunctions:CheckPlayerType%(lplr%) ~= "DEFAULT"'
	repin = "true"
	publicrepo = string.gsub(tostring(publicrepo), regex,repin)
	regex = 'WhitelistFunctions:CheckPlayerType%(lplr%)'
	repin = '"VAPE PRIVATE"'
	publicrepo = string.gsub(tostring(publicrepo), regex,repin)
	
	-- removes bedwarsdata kicks
	regex = 'newdatatab%.KickUsers%[tostring%(lplr%.UserId%)%]'
	repin = "false"
	publicrepo = string.gsub(tostring(publicrepo), regex,repin)
	regex = 'datatab%.KickUsers%[tostring%(lplr%.UserId%)%]'
	repin = "false"
	publicrepo = string.gsub(tostring(publicrepo), regex,repin)
    --]]--

    loadstring(publicrepo)()
end

GuiLibrary["SelfDestructEvent"].Event:Connect(function()
	for i3,v3 in pairs(connections) do
		if v3.Disconnect then pcall(function() v3:Disconnect() end) end
		if v3.disconnect then pcall(function() v3:disconnect() end) end
	end
end)

local function runcode(func)
	func()
end

local function COB(tab, argstable) 
    return GuiLibrary["ObjectsThatCanBeSaved"][tab.."Window"]["Api"].CreateOptionsButton(argstable)
end

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(234, 255, 9)
		return frame
	end)
	return (suc and res)
end

local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
