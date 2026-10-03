-- =====================================================================
-- 🔱 ZEROIX HUB v10 FINAL - PREMIUM CYBER INTERFACE (PART 1) 🔱
-- =====================================================================
if not game:IsLoaded() then game.Loaded:Wait() end

if game.CoreGui:FindFirstChild("ZEROIX_MULTIVERSE_V10") then
	game.CoreGui.ZEROIX_MULTIVERSE_V10:Destroy()
end

pcall(function()
	settings().Physics.AllowSleep = false
	settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
	setfpscap(999)
end)

shared.ZeroixV10 = {
	ScreenGui = Instance.new("ScreenGui"),
	Tabs = {},
	RainbowObjects = {},
	CurrentColor = Color3.fromRGB(0, 180, 255)
}

local Data = shared.ZeroixV10
Data.ScreenGui.Name = "ZEROIX_MULTIVERSE_V10"
Data.ScreenGui.DisplayOrder = 999
Data.ScreenGui.ResetOnSpawn = false
Data.ScreenGui.Parent = game:GetService("CoreGui")

-- 1. PREMIUM FHD+ DRAGGABLE CIRCLE "ZH" FLOATING ICON
local OpenIcon = Instance.new("TextButton", Data.ScreenGui)
OpenIcon.Name = "ZeroixQuantumToggle"
OpenIcon.Size = UDim2.new(0, 52, 0, 52)
OpenIcon.Position = UDim2.new(0.90, 0, 0.20, 0)
OpenIcon.Font = Enum.Font.GothamBold
OpenIcon.Text = "ZH"
OpenIcon.TextSize = 16
OpenIcon.Active = true
OpenIcon.Draggable = true 

local IconGradient = Instance.new("UIGradient", OpenIcon)
IconGradient.Color = ColorSequence.new(Color3.fromRGB(5, 20, 45), Color3.fromRGB(8, 8, 12))
IconGradient.Rotation = 45

Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)

local IconStroke = Instance.new("UIStroke", OpenIcon)
IconStroke.Thickness = 3
table.insert(Data.RainbowObjects, OpenIcon)
table.insert(Data.RainbowObjects, IconStroke)

-- 2. MAIN FRAME HUB MENU INTERFACE
local MainFrame = Instance.new("Frame", Data.ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 350)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(6, 8, 12)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3
table.insert(Data.RainbowObjects, MainStroke)

-- 🌈 CHROMATIC SINUSOIDAL WAVE ANIMATION (DARK BLUE - CYAN NEON - DARK RGB)
task.spawn(function()
	local timeTick = 0
	while true do
		timeTick = timeTick + 0.015
		local dynamicColor = Color3.fromRGB(
			0, 
			math.clamp(math.sin(timeTick) * 100 + 150, 50, 255), 
			math.clamp(math.cos(timeTick) * 50 + 200, 150, 255)
		)
		Data.CurrentColor = dynamicColor
		
		for _, obj in ipairs(Data.RainbowObjects) do
			pcall(function()
				if obj:IsA("UIStroke") then obj.Color = dynamicColor
				elseif obj:IsA("TextButton") then obj.TextColor3 = dynamicColor
				elseif obj:IsA("TextLabel") then obj.TextColor3 = dynamicColor end
			end)
		end
		task.wait(0.01)
	end
end)

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 145, 1, -10)
Sidebar.Position = UDim2.new(0, 5, 0, 5)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 5)

shared.ZeroixContainer = Instance.new("Frame", MainFrame)
shared.ZeroixContainer.Size = UDim2.new(1, -160, 1, -10)
shared.ZeroixContainer.Position = UDim2.new(0, 155, 0, 5)
shared.ZeroixContainer.BackgroundTransparency = 1

OpenIcon.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

function shared.CreateMultiverseTab(tabName)
	local TabBtn = Instance.new("TextButton", Sidebar)
	TabBtn.Size = UDim2.new(1, -10, 0, 36)
	TabBtn.Position = UDim2.new(0, 5, 0, 0)
	TabBtn.Font = Enum.Font.GothamBold
	TabBtn.Text = tabName
	TabBtn.TextSize = 11
	TabBtn.TextColor3 = Color3.fromRGB(100, 120, 150)
	TabBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 32)
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

	local ScrollPage = Instance.new("ScrollingFrame", shared.ZeroixContainer)
	ScrollPage.Size = UDim2.new(1, 0, 1, 0)
	ScrollPage.BackgroundTransparency = 1
	ScrollPage.Visible = false
	ScrollPage.CanvasSize = UDim2.new(0, 0, 0, 680)
	ScrollPage.ScrollBarThickness = 2
	local PageList = Instance.new("UIListLayout", ScrollPage)
	PageList.Padding = UDim.new(0, 6)

	TabBtn.MouseButton1Click:Connect(function()
		for _, page in pairs(shared.ZeroixContainer:GetChildren()) do page.Visible = false end
		for _, btn in pairs(Sidebar:GetChildren()) do 
			if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(100, 120, 150) end
		end
		ScrollPage.Visible = true
		TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	local function AddToggle(text, varName, callback)
		local TglBtn = Instance.new("TextButton", ScrollPage)
		TglBtn.Size = UDim2.new(1, -5, 0, 38)
		TglBtn.Font = Enum.Font.GothamBold
		TglBtn.TextSize = 12
		TglBtn.BackgroundColor3 = Color3.fromRGB(12, 16, 24)
		Instance.new("UICorner", TglBtn).CornerRadius = UDim.new(0, 6)
		local TglStroke = Instance.new("UIStroke", TglBtn)
		TglStroke.Thickness = 1.2
		TglStroke.Color = Color3.fromRGB(25, 35, 50)

		local function updateVisual()
			if _G[varName] then
				TglBtn.Text = text .. " : ACTIVE"
				TglBtn.TextColor3 = Color3.fromRGB(0, 255, 200)
				TglStroke.Color = Color3.fromRGB(0, 200, 255)
			else
				TglBtn.Text = text .. " : DISABLED"
				TglBtn.TextColor3 = Color3.fromRGB(100, 110, 120)
				TglStroke.Color = Color3.fromRGB(25, 35, 50)
			end
		end

		TglBtn.MouseButton1Click:Connect(function()
			_G[varName] = not _G[varName]
			updateVisual()
			if callback then pcall(callback, _G[varName]) end
		end)
		updateVisual()
		return TglBtn
	end

	local function AddWalkspeedSlider(text)
		local SliderContainer = Instance.new("Frame", ScrollPage)
		SliderContainer.Size = UDim2.new(1, -5, 0, 55)
		SliderContainer.BackgroundColor3 = Color3.fromRGB(12, 16, 24)
		Instance.new("UICorner", SliderContainer).CornerRadius = UDim.new(0, 6)
		local ContainerStroke = Instance.new("UIStroke", SliderContainer)
		ContainerStroke.Color = Color3.fromRGB(25, 35, 50)

		local Label = Instance.new("TextLabel", SliderContainer)
		Label.Size = UDim2.new(1, 0, 0, 20)
		Label.Position = UDim2.new(0, 10, 0, 2)
		Label.Font = Enum.Font.GothamBold
		Label.Text = text .. " : 16"
		Label.TextColor3 = Color3.fromRGB(150, 160, 180)
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.BackgroundTransparency = 1

		local Bar = Instance.new("Frame", SliderContainer)
		Bar.Size = UDim2.new(1, -40, 0, 6)
		Bar.Position = UDim2.new(0, 20, 0, 32)
		Bar.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
		Instance.new("UICorner", Bar)

		local Fill = Instance.new("Frame", Bar)
		Fill.Size = UDim2.new(0, 0, 1, 0)
		Fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
		Instance.new("UICorner", Fill)

		local Button = Instance.new("TextButton", Bar)
		Button.Size = UDim2.new(0, 14, 0, 14)
		Button.Position = UDim2.new(0, -7, 0.5, -7)
		Button.Text = ""
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)
		
		local UIS = game:GetService("UserInputService")
		local dragging = false
		Button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
		end)
		UIS.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local percentage = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
				Button.Position = UDim2.new(percentage, -7, 0.5, -7)
				Fill.Size = UDim2.new(percentage, 0, 1, 0)
				
				local walkspeedValue = math.floor(16 + (percentage * (120 - 16)))
				Label.Text = text .. " : " .. tostring(walkspeedValue)
				
				if _G.ActiveWalkspeedMenu then
					pcall(function()
						local char = game.Players.LocalPlayer.Character
						local hum = char and char:FindFirstChildOfClass("Humanoid")
						if hum then hum.WalkSpeed = walkspeedValue end
					end)
				end
			end
		end)
		UIS.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
		end)
	end

	if #Sidebar:GetChildren() == 2 then ScrollPage.Visible = true end
	return AddToggle, AddWalkspeedSlider, ScrollPage
end

local AddMove, AddSlider = shared.CreateMultiverseTab("🏃 Movement / Pergerakan")
local AddVisual = shared.CreateMultiverseTab("👁️ Visual ESP")

AddMove("⚡ Active Walkspeed Menu", "ActiveWalkspeedMenu", function(state)
	pcall(function()
		local char = game.Players.LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum and not state then hum.WalkSpeed = 16 end
	end)
end)
AddSlider("Walkspeed Adjuster •")

AddMove("🛡️ Anti-Hit Core Protection", "AntiHitCoreActive")
AddVisual("⚙️ Optimize FPS Booster", "FpsBoostActive")
AddVisual("🔴 Quantum Egg ESP (Wallhack)", "EggEspActive")

print("[ZEROIX HUB] Part 1 successfully loaded!");
-- =====================================================================
-- 🔱 ZEROIX HUB v10 FINAL - PREMIUM CYBER INTERFACE (PART 2) 🔱
-- =====================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Z_STR_HRP = "HumanoidRootPart"

local AddToggleFarm, _, FarmPage = shared.CreateMultiverseTab("🥚 Auto Steal Farm")
local AddTroll = shared.CreateMultiverseTab("🤡 Chaos Troll")

_G.SelectedMapValue = "All Eggs" 
_G.EggEspActive = true

-- INJECTING THE MAIN ENGLISH TOGGLES
AddToggleFarm("🚨 Auto Steal Egg High Value TP", "AutoRareEggsActive")
AddToggleFarm("📥 Move The Egg To Safe Zone TP", "InstantBringToBase")
AddTroll("🌪️ Ragnarok Fling All Server", "FlingAllActive")

-- ENGLISH DYNAMIC DROPDOWN INTERFACE
local DropdownMainFrame = Instance.new("Frame", FarmPage)
DropdownMainFrame.Size = UDim2.new(1, -5, 0, 110)
DropdownMainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
Instance.new("UICorner", DropdownMainFrame).CornerRadius = UDim.new(0, 8)
local DropdownStroke = Instance.new("UIStroke", DropdownMainFrame)
DropdownStroke.Color = Color3.fromRGB(40, 55, 75)

local DropdownLabel = Instance.new("TextLabel", DropdownMainFrame)
DropdownLabel.Size = UDim2.new(1, 0, 0, 25)
DropdownLabel.Font = Enum.Font.GothamBold
DropdownLabel.Text = "🗺️ SELECT ACTIVE EGG VALUES SPAWNED IN MAP:"
DropdownLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
DropdownLabel.TextSize = 10
DropdownLabel.BackgroundTransparency = 1

local DropdownScroll = Instance.new("ScrollingFrame", DropdownMainFrame)
DropdownScroll.Size = UDim2.new(1, -10, 1, -30)
DropdownScroll.Position = UDim2.new(0, 5, 0, 28)
DropdownScroll.BackgroundTransparency = 1
DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 250)
DropdownScroll.ScrollBarThickness = 2
local DropdownList = Instance.new("UIListLayout", DropdownScroll)
DropdownList.Padding = UDim.new(0, 4)

-- SAFE REAL-TIME SCANNING ENGINE (ANTI BUG & DELETION PROOF)
local function RefreshDropdownList()
	pcall(function()
		for _, child in ipairs(DropdownScroll:GetChildren()) do
			if child:IsA("TextButton") then child:Destroy() end
		end
		
		local clearBtn = Instance.new("TextButton", DropdownScroll)
		clearBtn.Size = UDim2.new(1, -4, 0, 26)
		clearBtn.Font = Enum.Font.GothamBold
		clearBtn.TextSize = 11
		clearBtn.Text = "👉 [RESET] Steal Every Single Egg"
		clearBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 40)
		Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 4)
		
		if _G.SelectedMapValue == "All Eggs" then clearBtn.TextColor3 = Color3.fromRGB(0, 255, 150) else clearBtn.TextColor3 = Color3.fromRGB(180, 180, 180) end
		clearBtn.MouseButton1Click:Connect(function() _G.SelectedMapValue = "All Eggs" end)

		local detectedValues = {}
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj and obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Parent.Name:lower():find("egg")) and obj.Parent and obj.Parent:IsA("Model") then
				local eggPoinAttr = obj:GetAttribute("Value") or obj:GetAttribute("Poin") or (obj:FindFirstChild("Value") and obj.Value.Value)
				local eggNameStr = obj.Parent.Name
				
				local identityKey = ""
				if eggPoinAttr and eggPoinAttr > 0 then
					if eggPoinAttr >= 1000000000 then identityKey = tostring(math.floor(eggPoinAttr/1000000000)) .. "b/s"
					else identityKey = tostring(eggPoinAttr) .. " Points" end
				else
					identityKey = eggNameStr
				end
				
				if identityKey ~= "" and not detectedValues[identityKey] then
					detectedValues[identityKey] = true
					
					local optBtn = Instance.new("TextButton", DropdownScroll)
					optBtn.Size = UDim2.new(1, -4, 0, 26)
					optBtn.Font = Enum.Font.GothamBold
					optBtn.TextSize = 11
					optBtn.Text = "🎯 Lock Target: " .. identityKey
					optBtn.BackgroundColor3 = Color3.fromRGB(26, 32, 48)
					Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)
					
					if _G.SelectedMapValue == identityKey then optBtn.TextColor3 = Color3.fromRGB(255, 170, 0) else optBtn.TextColor3 = Color3.fromRGB(150, 160, 170) end
					
					optBtn.MouseButton1Click:Connect(function()
						_G.SelectedMapValue = identityKey
					end)
				end
			end
		end
	end)
end

task.spawn(function()
	while true do
		pcall(RefreshDropdownList)
		task.wait(2.5)
	end
end)

-- ANTI-HIT BOUNDARY STEPPED LOOP (STABLE & BUGLESS)
RunService.Stepped:Connect(function()
	pcall(function()
		local char = LocalPlayer.Character
		local hrp = char and char:FindFirstChild(Z_STR_HRP)
		if _G.AntiHitCoreActive and hrp then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") and part.Name ~= Z_STR_HRP then part.CanCollide = false end
			end
			sethiddenproperty(hrp, "NetworkOwner", nil)
		end
	end)
end)

-- ACCELERATED DYNAMIC INTERCEPTOR TELEPORT ENGINE (STABLE RE-VERIFIER)
task.spawn(function()
	while true do
		RunService.Heartbeat:Wait()
		if _G.AutoRareEggsActive then
			pcall(function()
				local char = LocalPlayer.Character
				local myHrp = char and char:FindFirstChild(Z_STR_HRP)
				if not myHrp then return end
				
				local myBase = workspace:FindFirstChild("Bases") and workspace.Bases:FindFirstChild(LocalPlayer.Name) or workspace:FindFirstChild(LocalPlayer.Name .. "Base") or workspace:FindFirstChild("Nest")
				
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj and obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Parent.Name:lower():find("egg")) and obj.Parent and obj.Parent:IsA("Model") then
						if obj.Position and obj.Parent.Parent ~= char then
							
							local eggPoinAttr = obj:GetAttribute("Value") or obj:GetAttribute("Poin") or (obj:FindFirstChild("Value") and obj.Value.Value)
							local currentIdentity = ""
							if eggPoinAttr and eggPoinAttr > 0 then
								if eggPoinAttr >= 1000000000 then currentIdentity = tostring(math.floor(eggPoinAttr/1000000000)) .. "b/s"
								else currentIdentity = tostring(eggPoinAttr) .. " Points" end
							else
								currentIdentity = obj.Parent.Name
							end
							
							local isMatch = false
							if _G.SelectedMapValue == "All Eggs" then
								isMatch = true
							elseif _G.SelectedMapValue == currentIdentity then
								isMatch = true
							end
							
							if isMatch then
								myHrp.CFrame = obj.CFrame + Vector3.new(0, 0.3, 0)
								
								local checkTime = 0
								while obj and obj.Parent and obj.Parent.Parent == workspace and checkTime < 0.25 do
									RunService.Heartbeat:Wait()
									checkTime = checkTime + 0.01
								end
								
								if _G.InstantBringToBase and myBase and myBase.Parent then
									myHrp.CFrame = myBase:GetPivot() or myBase.CFrame
									task.wait(0.15)
								end
								break 
							end
							
						end
					end
				end
			end)
		end
	end
end)

-- CRITICAL EGG ESP CHAMS CORE LOOP (CLEAN REFRESH ENGINE)
task.spawn(function()
	while true do
		task.wait(0.4)
		pcall(function()
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj and obj:IsA("Model") and obj.Name:lower():find("egg") then
					local hasHighlight = obj:FindFirstChild("EggGlowESP")
					if _G.EggEspActive then
						if not hasHighlight then
							hasHighlight = Instance.new("Highlight", obj)
							hasHighlight.Name = "EggGlowESP"
							hasHighlight.OutlineTransparency = 0
							hasHighlight.OutlineColor = Color3.fromRGB(0, 0, 0)
						end
						hasHighlight.FillTransparency = 0.15
						
						local nameLower = obj.Name:lower()
						if nameLower:find("giant") or nameLower:find("massive") or nameLower:find("omega") then
							hasHighlight.FillColor = Color3.fromRGB(255, 0, 0)
						elseif nameLower:find("diamond") or nameLower:find("mythic") then
							hasHighlight.FillColor = Color3.fromRGB(0, 220, 255)
						else
							hasHighlight.FillColor = Color3.fromRGB(255, 200, 0)
						end
					else
						if hasHighlight then hasHighlight:Destroy() end
					end
				end
			end
		end)
	end
end)
print("[ZEROIX HUB v10] Bugless Overdrive Engine Fully Online!");
