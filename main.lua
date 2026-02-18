local exti =loadstring(game:HttpGet("https://raw.githubusercontent.com/Pyth0n1zed/GUI-Framework-Roblox/refs/heads/main/script.lua"))()()
--game.ReplicatedStorage.Common:WaitForChild("InitGlove"):Destroy()
local plr = game.Players.LocalPlayer
local char = plr.Character
local hum = char.Humanoid
local hrp = char.HumanoidRootPart
local HitboxThingy = require(game.ReplicatedStorage.Packages.RaycastHitboxV4)
local hitboxnew = nil

local slapAnim = hum:LoadAnimation(game.ReplicatedStorage.Assets.Animations:WaitForChild("SlapAnim",5))
local state = {
	SALEGIT = false,
	SLAPNOW = false,
	SLAPPING = false,
	TARGET = nil,
	SA = false,
	GLOVEINIT = false,
	GLOVEEQUIPPED = false,
	GLOVE = nil,
}
task.spawn(function()
	while task.wait() do
		if state.SLAPNOW and state.GLOVEEQUIPPED and state.GLOVEINIT and not state.SLAPPING then
			--game.ReplicatedStorage.Remotes.Slap:FireServer(state.TARGET)
			--task.wait(1.6)
			--state.SLAPPING = false
			if (not char:GetAttribute("Ragdolled")) and (not char:GetAttribute("Stunned")) and (not state.SLAPPING) then -- ALL ADAPTED FROM GLOVEINIT SCRIPT!!!!
				state.SLAPPING = true	
				hitboxnew:HitStart()
				game.ReplicatedStorage.Remotes.Slap:FireServer(state.TARGET)
				
				slapAnim:Play()
				
				task.wait(0.45)
				hitboxnew:HitStop()
				state.SLAPNOW = false
				task.wait(state.GLOVE.Config.AttackCD.Value)
				state.SLAPPING = false
			end
		end
		if state.GLOVEINIT == false then
			for i,v in pairs(char:GetChildren()) do
				if v:FindFirstChild("Glove") then
					hitboxnew = HitboxThingy.new(v:WaitForChild("Glove"))
					local temp = RaycastParams.new()
					temp.FilterDescendantsInstances = {v.Parent}
					temp.FilterType = Enum.RaycastFilterType.Exclude
					hitboxnew.RaycastParams = temp
					hitboxnew.Visualizer = false
					hitboxnew:SetPoints(v.Glove,{Vector3.new(0.16599, -1.2180, 0.04300), Vector3.new(0.16599, -0.5699, 0.15399), Vector3.new(-0.3740, 1.10199, -0.1260), Vector3.new(-0.5759, -0.4550, 0.04199), Vector3.new(-0.7649, 0.30599, 0.12800), Vector3.new(-0.6589, -0.7730, -0.1340), Vector3.new(-0.6150, 0.64200, -0.1260), Vector3.new(-1.1230, -0.5979, -0.2450), Vector3.new(0.43799, 0.18099, -0.0970), Vector3.new(0.33000, -0.1209, 0.15399), Vector3.new(-0.2210, -0.4810, 0.12800), Vector3.new(-0.1049, 0.25999, 0.07400), Vector3.new(-0.2930, -0.8529, 0.09499), Vector3.new(0.01600, 1.10199, -0.1260), Vector3.new(-0.2930, -1.2180, -0.1389), Vector3.new(0.16599, -0.9100, 0.04300), Vector3.new(-0.7509, -1.0809, -0.3079), Vector3.new(-0.8949, -0.1599, -0.0049), Vector3.new(0.37799, 0.62900, -0.1040), Vector3.new(1.06099, 0.01799, -0.3210), Vector3.new(0.73799, 0.24600, -0.2700)})
					v.Equipped:Connect(function()
						state.GLOVEEQUIPPED = true
						state.GLOVE = v
						if v:FindFirstChild("LocalScript") then
							--v.LocalScript:Destroy()
						end
					end)
					v.Unequipped:Connect(function()
						state.GLOVEEQUIPPED = false
						state.GLOVE = nil
					end)
					if v:FindFirstChild("LocalScript") then
							--v.LocalScript:Destroy()
						end
					state.GLOVEINIT = true
					v.Activated:Connect(function()
						if state.SLAPPING == true or state.SLAPNOW then return end
						state.SLAPPING = true	
						hitboxnew:HitStart()
						game.ReplicatedStorage.Remotes.Slap:FireServer(state.TARGET)
						slapAnim:Play()
						task.wait(0.45)
						hitboxnew:HitStop()
						state.SLAPNOW = false
						task.wait(state.GLOVE.Config.AttackCD.Value)
						state.SLAPPING = false
					end)
				end
			end
		end
	end
end)
-- COMBAT --

task.spawn(function()
	task.wait(5)
	while task.wait() do
		if state.SALEGIT and not state.SLAPPING then
			for i,v in pairs(game.Players:GetPlayers()) do
				if (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude <11 and v ~= plr and not state.SLAPPING and not state.SLAPNOW then
					--game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
					--local camSave = game:GetService("UserInputService").MouseBehavior
					--game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.LockCenter
					local info = TweenInfo.new(0.05,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,true)
					--local tween = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, info, {CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position,v.Character.HumanoidRootPart.Position)})
					local tween2 = game:GetService("TweenService"):Create(hrp, info, {CFrame = CFrame.new(hrp.Position,Vector3.new((v.Character.HumanoidRootPart.Position-hrp.Position).X,0,(v.Character.HumanoidRootPart.Position-hrp.Position).Z).Unit)})
					--tween:Play()
					--tween2:Play()
					--slapAnim:Play()
					state.SLAPNOW = true
					state.TARGET = v.Character:FindFirstChild("Right Leg")
					print("Slapped "..v.Name)
					task.wait(0.1)
					
			
					--game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
					--game:GetService("UserInputService").MouseBehavior = camSave
					--game.Workspace.CurrentCamera.CameraSubject = hum
					break
				end
			end
		end
		if state.SA then
			for i,v in pairs(game.Players:GetPlayers()) do
				if (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude < 17 and v ~= plr --[[and not state.SLAPPING and not state.SLAPNOW]] then
					--game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
					--local camSave = game:GetService("UserInputService").MouseBehavior
					--game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.LockCenter
					local info = TweenInfo.new(0.05,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,true)
					--local tween = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, info, {CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position,v.Character.HumanoidRootPart.Position)})
					local tween2 = game:GetService("TweenService"):Create(hrp, info, {CFrame = CFrame.new(hrp.Position,Vector3.new((v.Character.HumanoidRootPart.Position-hrp.Position).X,0,(v.Character.HumanoidRootPart.Position-hrp.Position).Z).Unit)})
					--tween:Play()
					--tween2:Play()
					--slapAnim:Play()
					state.SLAPNOW = true
					state.TARGET = v.Character:FindFirstChild("Right Leg")
					print("Slapped "..v.Name)
					task.wait(0.1)
					
			
					--game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
					--game:GetService("UserInputService").MouseBehavior = camSave
					--game.Workspace.CurrentCamera.CameraSubject = hum
					break
				end
			end
		end
	end
end)

-- GUI --
local combatTab = exti:CreateTab("Combat", 1)
local miscTab = exti:CreateTab("Misc", 5)
exti:SetTitle("exti hub v2")
exti:CreateButton(miscTab,"trigger","Teleport to Slap Royale matchmaking","Automatically teleports you to the slap royale matchmaking place to start a new game",1,function() 
	exti:Notify("Teleporting.. please wait a second!", 67)
	game:GetService("TeleportService"):Teleport(9426795465,game.Players.LocalPlayer)
end)
exti:CreateButton(miscTab,"trigger","Load Infinite Yield","loads IY",2,function() 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

exti:CreateButton(combatTab,"toggle","Slap Aura", "Auto slaps people", 1, function()
	state.SA = not state.SA
end,
function()
	state.SA = not state.SA
end)
exti:CreateButton(combatTab,"toggle","Slap Aura (legit)", "Auto slaps someone when theyre in range of your glove.", 2, function()
	state.SA = not state.SA
end,
function()
	state.SA = not state.SAL
end)

exti:FinishLoading()
