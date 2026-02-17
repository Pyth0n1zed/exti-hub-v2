local exti =loadstring(game:HttpGet("https://raw.githubusercontent.com/Pyth0n1zed/GUI-Framework-Roblox/refs/heads/main/script.lua"))()()
local plr = game.Players.LocalPlayer
local char = plr.Character
local hum = char.Humanoid
local hrp = char.HumanoidRootPart

local slapAnim = hum:LoadAnimation(game.ReplicatedStorage.Assets.Animations:WaitForChild("SlapAnim",5))
local state = {
	SALEGIT = false,
	SLAPPING = false,
}
task.spawn(function()
	while task.wait() do
		if state.SLAPPING then
			task.wait(1.6)
			state.SLAPPING = false
		end
	end
end)
-- COMBAT --

task.spawn(function()
	task.wait(5)
	while task.wait() do
		if state.SALEGIT and not state.SLAPPING then
			for i,v in pairs(game.Players:GetPlayers()) do
				if (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude < 5.3 and v ~= plr then
					--game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
					--local camSave = game:GetService("UserInputService").MouseBehavior
					game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.LockCenter
					local info = TweenInfo.new(0.05,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,true)
					--local tween = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, info, {CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position,v.Character.HumanoidRootPart.Position)})
					local tween2 = game:GetService("TweenService"):Create(hrp, info, {CFrame = CFrame.new(hrp.Position,Vector3.new((v.Character.HumanoidRootPart.Position-hrp.Position).X,0,(v.Character.HumanoidRootPart.Position-hrp.Position).Z).Unit)})
					--tween:Play()
					--tween2:Play()
					task.wait(0.025)
					slapAnim:Play()
					state.SLAPPING = true
					game.ReplicatedStorage.Remotes.Slap:FireServer(v.Character:FindFirstChild("Right Leg"))
					task.wait(0.01)
			
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

exti:CreateButton(combatTab,"toggle","Slap Aura (legit)", "Auto slaps someone when theyre in range of your glove, turns camera and slaps naturally.", 1, function()
	state.SALEGIT = not state.SALEGIT
end,
function()
	state.SALEGIT = not state.SALEGIT
end)

exti:FinishLoading()
