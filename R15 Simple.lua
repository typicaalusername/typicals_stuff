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
Character.Archivable = true
--Character.Animate:Clone().Parent = Dummy

--// Cloning \\--

local Dummy = Character:Clone()--game:GetObjects("rbxassetid://8329239188")[1]--9358207503")[1]
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
		v.Handle.Transparency = 1
	end
end

--// Functions \\--

function Noclip()
	for i,v in pairs(Dummy:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			--v.Anchored = false
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
	Library.Notification("Simple","Your character will reset in a few seconds.")
end)
Noclip = game.RunService.Stepped:Connect(Noclip)

Dummy.Parent.ChildRemoved:connect(function(Obj)
	if Obj == Dummy then
		Library.Notification("Simple","Your reanimation rig has been removed from workspace.")
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

function CFrame1(part0,part1,pos,ori) 
	game.RunService.Heartbeat:Connect(function()
		part0.CFrame = part1.CFrame
	end)
end
function CFrame2(part0,part1,pos,ori) 
	game.RunService.Heartbeat:Connect(function()
		part0.CFrame = part1.CFrame + pos
	end)
end

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

for i,v in pairs(Limbs) do
	CFrame1(v, Dummy[v.Name])
	for i,Object in pairs(v:GetChildren()) do
		if Object:IsA("Motor6D") then
			Object:Remove()
		end
	end
end

CFrame2(Character.HumanoidRootPart, Dummy.UpperTorso, Vector3.new(0,-.2,0))

for i,v in pairs(Character:GetChildren()) do
	if v:IsA("Accessory") then
		local clone = Dummy[v.Name]
		clone.Handle.Transparency = 1
		--clone.Parent = Dummy
		v.Handle:BreakJoints()
		CFrame1(v.Handle,Dummy[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
	end
end

Character.ChildAdded:Connect(function(Instance_)
	if Instance_:IsA("Accessory") then
		wait()
		local HatClone = Instance_:Clone()
		HatClone.Parent = Dummy
		Instance_.Handle:BreakJoints()
		CFrame(Instance_.Handle,HatClone.Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
		Instance_.Handle.Transparency = 1
	end
end)

local fakerespawnevent = Instance.new("BindableEvent")
fakerespawnevent.Event:Connect(function()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	Character.Humanoid:Remove()
	Library.Notification("Simple", "Please wait.\nWe are force resetting your character.")
end)
game:GetService("StarterGui"):SetCore("ResetButtonCallback", fakerespawnevent)

workspace.Camera.CameraSubject = Dummy.Humanoid
Player.Character = Dummy
Library.Notification("Simple","You are now reanimated.\nYou may now run your scripts.")
warn("Loaded R15 to R15 within seconds! Enjoy!")

Dummy.Animate.Disabled = true
Dummy.Animate.Disabled = false