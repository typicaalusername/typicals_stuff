--[[
	This animation template is based off of
	
				NebulaZoura's
]]

Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
Char = workspace.Camera.CameraSubject.Parent
Hum = Char.Humanoid
Torso = Char.Torso
Root = Char.HumanoidRootPart
attack = false
legAnims = true
normalAnims = true

-- // joints | taken from nebula because im too lazy to make my own \\--
NewInstance = function(instance,parent,properties)
	local inst = Instance.new(instance)
	inst.Parent = parent
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end

function newMotor(P0,P1,C0,C1)
	return NewInstance('Motor',P0,{Part0=P0,Part1=P1,C0=C0,C1=C1})
end

local welds = {newMotor(Torso,Char.Head,CFrame.new(0,1.5,0),CFrame.new()),newMotor(Root,Torso,CFrame.new(),CFrame.new()),newMotor(Torso,Char["Right Leg"],CFrame.new(.5,-1,0),CFrame.new(0,1,0)),newMotor(Torso,Char["Right Arm"],CFrame.new(1.5,.5,0),CFrame.new(0,.5,0)),newMotor(Torso,Char["Left Leg"],CFrame.new(-.5,-1,0),CFrame.new(0,1,0)),newMotor(Torso,Char["Left Arm"],CFrame.new(-1.5,.5,0),CFrame.new(0,.5,0))}
local WeldDefaults = {}
for i = 1,#welds do
	local v=welds[i]
	WeldDefaults[i]=v.C0
end

local neckc0,torsoc0,rightlegc0,rightarmc0,leftlegc0,leftarmc0 = unpack(WeldDefaults)

function swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		game.RunService.Heartbeat:wait()
	else
		for i = 1, NUMBER do
			game.RunService.Heartbeat:wait()
		end
	end
end

--// Variables \\--

local rd = math.rad
local cf = {a=CFrame.Angles,n=CFrame.new}
local sin = math.sin
local cos = math.cos
sine = 0
change = .7
movement = 10
ws = 20
AnimState = "Idle"
attackcombo = 0 -- for diff scripts
local Animator = Char.Humanoid:FindFirstChild("Animator")
local Animate = Char.Animate

--// Custom Items \\--

--[[

Making custom items (like hats!)
this is an example of making it work

local swordhandle = Instance.new("Part", Char)
local swordhanweld = newMotor(Char["Right Arm"], swordhandle, cf.n(0,0,0), cf.a(0,0,0))
local swordc0 = cf.n(0,0,0)*cf.a(0,0,0) -- default pos of the sword

this is 100% optional but i prefer adding in the mesh so i can work without the actual hat

game:GetObjects("rbxassetid://HATID").Handle:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = swordhandle

now in the animations add in

swordhanweld.C0 = swordhanweld.C0:lerp(swordc0, Alpha)

this sets it to the default pos

]]--

--// Attacks \\--

AttackTemplate = function()
	attack = true
	legAnims = true -- set to true if you want only the leg animations to play
	normalAnims = false -- set to true if you want every other anim but legs to play
	for i=0,10 do
		game.RunService.Stepped:wait()
		local Alpha = .3
		welds[1].C0=welds[1].C0:Lerp(neckc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		welds[2].C0=welds[2].C0:Lerp(torsoc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		welds[3].C0=welds[3].C0:Lerp(rightlegc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		welds[4].C0=welds[4].C0:Lerp(rightarmc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		welds[5].C0=welds[5].C0:Lerp(leftlegc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		welds[6].C0=welds[6].C0:Lerp(leftarmc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
	end
	attack = false
	legAnims = true
	normalAnims = true
end

-- start animating
while true do
	swait()
	sine = sine + change
	Hum.CameraOffset=Hum.CameraOffset:Lerp((Root.CFrame*CFrame.new(0,1.5,0)):PointToObjectSpace(Char.Head.Position),.15)
	Animator.Parent = nil
	Animate.Parent = nil
	for i,v in next, Hum:GetPlayingAnimationTracks() do
	    v:Stop()
	end
	local hitfloor,posfloor = workspace:FindPartOnRayWithIgnoreList(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4)), {Effects, Char})
	local Walking = (math.abs(Root.Velocity.x) > 1 or math.abs(Root.Velocity.z) > 1)
	AnimState = (Hum.PlatformStand and 'Paralyzed' or Hum.Sit and 'Sit' or not hitfloor and Root.Velocity.y < -1 and "Fall" or not hitfloor and Root.Velocity.y > 1 and "Jump" or hitfloor and Walking and "Walk" or hitfloor and "Idle")
	Hum.WalkSpeed = ws
	local sidevec = math.clamp((Root.Velocity*Root.CFrame.rightVector).X+(Root.Velocity*Root.CFrame.rightVector).Z,-Hum.WalkSpeed,Hum.WalkSpeed)
	local forwardvec =  math.clamp((Root.Velocity*Root.CFrame.lookVector).X+(Root.Velocity*Root.CFrame.lookVector).Z,-Hum.WalkSpeed,Hum.WalkSpeed)
	local sidevelocity = sidevec/Hum.WalkSpeed
	local forwardvelocity = forwardvec/Hum.WalkSpeed
	if (AnimState == "Idle") then
		local Alpha = .1
		change = .7
		--[[
		if(normalAnims) then
			welds[1].C0=welds[1].C0:Lerp(neckc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[2].C0=welds[2].C0:Lerp(torsoc0*cf.n(0,0.1,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[4].C0=welds[4].C0:Lerp(rightarmc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[6].C0=welds[6].C0:Lerp(leftarmc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		end
		if(legAnims) then
			welds[3].C0=welds[3].C0:Lerp(rightlegc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[5].C0=welds[5].C0:Lerp(leftlegc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		end
		]]--
		if(normalAnims) then
			welds[1].C0=welds[1].C0:Lerp(neckc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[2].C0=welds[2].C0:Lerp(torsoc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[4].C0=welds[4].C0:Lerp(rightarmc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[6].C0=welds[6].C0:Lerp(leftarmc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		end
		if(legAnims) then
			welds[3].C0=welds[3].C0:Lerp(rightlegc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
			welds[5].C0=welds[5].C0:Lerp(leftlegc0*cf.n(0,0,0)*cf.a(rd(0),rd(0),rd(0)),Alpha)
		end
	end
	if (AnimState == "Walk") then
		local Alpha = .2
		change = .6
		wsVal = 4
		movement = 10
		-- Movement Detection walking animation (taken from WAO v2.5)
		-- You are able to edit the arm animations!
		if (normalAnims) then
			welds[1].C0 = welds[1].C0:lerp(neckc0,Alpha)
			welds[2].C0 = welds[2].C0:lerp(torsoc0*cf.n(0,.05+change/4*cos(sine/(wsVal/2)),0)*cf.a(rd(-(change*20)-movement/20*cos(sine/(wsVal/2)))*forwardvelocity,rd(0+5*cos(sine/wsVal)),rd(-(change*20)-movement/20*cos(sine/(wsVal/2)))*sidevelocity+rd(0-1*cos(sine/wsVal))),Alpha)
			welds[6].C0 = welds[6].C0:lerp(leftarmc0*cf.n(0,0,0)*cf.a(rd(0+55*(movement/8)*sin(sine/wsVal))*forwardvelocity,0,rd(-5-5*cos(sine/wsVal))),Alpha)
			welds[4].C0 = welds[4].C0:lerp(rightarmc0*cf.n(0,0,0)*cf.a(rd(0-55*(movement/8)*sin(sine/wsVal))*forwardvelocity,0,rd(0+5*cos(sine/wsVal))),Alpha)	
		end
		if (legAnims) then 
			welds[5].C0 = welds[5].C0:lerp(leftlegc0*cf.n(0,0-movement/15*cos(sine/wsVal)/2,(-.1+movement/15*cos(sine/wsVal))*(.5+.5*forwardvelocity))*cf.a((rd(-10*forwardvelocity+change*5-movement*cos(sine/wsVal))+-(movement/10)*sin(sine/wsVal))*forwardvelocity,0,(rd(change*5-movement*cos(sine/wsVal))+-(movement/10)*sin(sine/wsVal))*(sidevec/(Hum.WalkSpeed*2))),Alpha)
			welds[3].C0 = welds[3].C0:lerp(rightlegc0*cf.n(0,0+movement/15*cos(sine/wsVal)/2,(-.1-movement/15*cos(sine/wsVal))*(.5+.5*forwardvelocity))*cf.a((rd(-10*forwardvelocity+change*5+movement*cos(sine/wsVal))+(movement/10)*sin(sine/wsVal))*forwardvelocity,0,(rd(change*5+movement*cos(sine/wsVal))+(movement/10)*sin(sine/wsVal))*(sidevec/(Hum.WalkSpeed*2))),Alpha)
		end
	end
end
