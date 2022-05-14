--[[

					This reanimation was created by
					
							 TypicalUsername
		   
	Removal of some loadstrings could cause issues with the reanimation.
	
			   r15 to r6 made by typicalusername :sunglasses:
	
				I DO NOT USE LOGGERS WITHIN THE LOADSTRINGS!
				
							 shut up gary
	
	  Please credit me if you wish to use this inside of your scripts!

]]--

--// Fix for duplicated hats \\--

loadstring(game:HttpGet("https://raw.githubusercontent.com/TypicallyAUser/TypicalsConvertingLibrary/main/renameallhatclones"))()

--// Main Variables \\--

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TypicallyAUser/TypicalsConvertingLibrary/main/Main"))()
Library.Net()
local Alignment = Library.Align2
local Player = game.Players.LocalPlayer
local Character = Player.Character
for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
	if v:IsA("AnimationTrack") then
		v:Stop()
	end
end

function CFrame(part0,part1) 
	game.RunService.Heartbeat:Connect(function()
		part0.CFrame = part1.CFrame
	end)
end

Character.Archivable = true
Animations = true

--// Cloning \\--

local Dummy = game:GetObjects("rbxassetid://8329239188")[1]--9358207503")[1]
Dummy.Parent = workspace
Dummy.HumanoidRootPart.Anchored = false
Dummy.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame
Character.Parent = Dummy
Character.Animate:Remove()
Character.HumanoidRootPart.Transparency = 0.5
Dummy.Name = "Typical's Reanimation"
Dummy.Head.face.Transparency = 1
for i,v in pairs(Dummy:GetChildren()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
	elseif v:IsA("Accessory") then
		v.Handle.Transparency = 0
	end
end

--// Permanent Death \\--

Library.Notification("Permanent Death","Loading.")

Player.Character = nil

Player.Character = Dummy

wait(game.Players.RespawnTime + .5)

Character.Humanoid:ChangeState(15)

Library.Notification("Permanent Death","Player health set to 0.")

--// Functions \\--

function Noclip()
	for i,v in pairs(Dummy:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
    if game.Workspace:FindFirstChild(Character.Name) then
    	Dummy:Remove()
    	return
    	
	end
end
Dummy:FindFirstChildOfClass("Humanoid").Died:Connect(function()
	Character.Humanoid:Remove()
	Character:BreakJoints()
	Library.Notification("Permanent Death","Your character will reset in a few seconds.")
end)
Noclip = game.RunService.Stepped:Connect(Noclip)

Dummy.Parent.ChildRemoved:connect(function(Obj)
	if Obj == Dummy then
		Library.Notification("Permanent Death","Your reanimation rig has been removed from workspace.")
	end
end)

function Netless()
    for _, v in pairs(Character:GetChildren()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") and v.Name ~= "HumanoidRootPart" then
            v.AssemblyLinearVelocity = Vector3.new(-20.05, 0, -20.05)
        elseif v:IsA("Accessory") then
        	v.Handle.AssemblyLinearVelocity = Vector3.new(-30.15, 0, -30.15)
        end
    end
end
Netless = game.RunService.Heartbeat:Connect(Netless)

--// Align \\--

local Limbs = {}
table.insert(Limbs, Character['RightUpperArm'])
table.insert(Limbs, Character['RightLowerArm'])
table.insert(Limbs, Character['RightHand'])
table.insert(Limbs, Character['LeftUpperArm'])
table.insert(Limbs, Character['LeftLowerArm'])
table.insert(Limbs, Character['LeftHand'])
table.insert(Limbs, Character['RightUpperLeg'])
table.insert(Limbs, Character['RightLowerLeg'])
table.insert(Limbs, Character['RightFoot'])
table.insert(Limbs, Character['LeftUpperLeg'])
table.insert(Limbs, Character['LeftLowerLeg'])
table.insert(Limbs, Character['LeftFoot'])
table.insert(Limbs, Character['UpperTorso'])
table.insert(Limbs, Character['LowerTorso'])
table.insert(Limbs, Character['Head'])

Alignment(Limbs[1], Dummy["Right Arm"], Vector3.new(0, 0.395, 0))
Alignment(Limbs[2], Dummy["Right Arm"], Vector3.new(0, -0.2, 0))
Alignment(Limbs[3], Dummy["Right Arm"], Vector3.new(0, -0.85, 0))

Alignment(Limbs[4], Dummy["Left Arm"], Vector3.new(0, 0.395, 0))
Alignment(Limbs[5], Dummy["Left Arm"], Vector3.new(0, -0.2, 0))
Alignment(Limbs[6], Dummy["Left Arm"], Vector3.new(0, -0.85, 0))

Alignment(Limbs[7], Dummy["Right Leg"], Vector3.new(0, 0.395, 0))
Alignment(Limbs[8], Dummy["Right Leg"], Vector3.new(0, -0.2, 0))
Alignment(Limbs[9], Dummy["Right Leg"], Vector3.new(0, -0.85, 0))

Alignment(Limbs[10], Dummy["Left Leg"], Vector3.new(0, 0.395, 0))
Alignment(Limbs[11], Dummy["Left Leg"], Vector3.new(0, -0.2, 0))
Alignment(Limbs[12], Dummy["Left Leg"], Vector3.new(0, -0.85, 0))

Alignment(Limbs[13], Dummy.Torso, Vector3.new(0, 0.2, 0))
Alignment(Limbs[14], Dummy.Torso, Vector3.new(0, -0.8, 0))

CFrame(Limbs[15], Dummy.Head)

CFrame(Character.HumanoidRootPart, Dummy.Torso)

for i,v in pairs(Character:GetChildren()) do -- based off mizt
    if v:IsA("Accessory") then
        local HatClone = v:Clone()
        HatClone.Handle.Transparency = 1
        HatClone.Parent = Dummy
		local hatattach = HatClone.Handle:FindFirstChildOfClass("Attachment")
		local partattach
		for i,v in pairs(Dummy:GetChildren()) do
			if v:IsA("BasePart") then
				for i,v in pairs(v:GetChildren()) do
					if v.Name == hatattach.Name then
						partattach = v
						break
					end
				end
				if partattach then break end
			end
		end
		local FakeAccessoryWeld = Instance.new("Weld",HatClone.Handle)
		FakeAccessoryWeld.Name = "AccessoryWeld"
		FakeAccessoryWeld.Part0 = HatClone.Handle
		FakeAccessoryWeld.Part1 = partattach.Parent
		FakeAccessoryWeld.C0 = hatattach.CFrame
		FakeAccessoryWeld.C1 = partattach.CFrame
		CFrame(v.Handle, HatClone.Handle)
    end
end

Character.ChildAdded:Connect(function(Instance_)
	if Instance_:IsA("Accessory") then
		wait()
		local HatClone = Instance_:Clone()
		HatClone.Parent = Dummy
		local hatattach = HatClone.Handle:FindFirstChildOfClass("Attachment")
		local partattach
		for i,v in pairs(Dummy:GetChildren()) do
			if v:IsA("BasePart") then
				for i,v in pairs(v:GetChildren()) do
					if v.Name == hatattach.Name then
						partattach = v
						break
					end
				end
				if partattach then break end
			end
		end
		local FakeAccessoryWeld = Instance.new("Weld",HatClone.Handle)
		FakeAccessoryWeld.Name = "AccessoryWeld"
		FakeAccessoryWeld.Part0 = HatClone.Handle
		FakeAccessoryWeld.Part1 = partattach.Parent
		FakeAccessoryWeld.C0 = hatattach.CFrame
		FakeAccessoryWeld.C1 = partattach.CFrame
		CFrame(Instance_.Handle,HatClone.Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
		Instance_.Handle.Transparency = 1
	end
end)
if Animations then loadstring(game:HttpGet("https://raw.githubusercontent.com/TypicallyAUser/TypicalsConvertingLibrary/main/Animations"))().R6(Dummy.Torso) end
workspace.Camera.CameraSubject = Dummy.Humanoid
Library.Notification("Permanent Death","You are now reanimated.\nYou may now run your scripts.")
warn("Loaded R15 to R6 within seconds! Enjoy!")

local fakerespawnevent = Instance.new("BindableEvent")
fakerespawnevent.Event:Connect(function()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	Character.Humanoid:Remove()
	Library.Notification("Permanent Death", "Please wait.\nWe are force resetting your character.")
end)
game:GetService("StarterGui"):SetCore("ResetButtonCallback", fakerespawnevent)
