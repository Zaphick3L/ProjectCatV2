--[[

Credits:
Gelatek (Everything)
ProductionTakeOne (R15 To R6 Animations)

Main:
Align: Done
R15: Done
R6: Done

Properties:
Fling: Done
Bullet: Done
RigEnabled: Done
Net: Done
Physics: Done
Remove Anims: Done
NoNetless: Done
]]--

if not _G.Fling then _G.Fling = false end
if not _G.Bullet then _G.Bullet = false end
if not _G.TorsoCollide then _G.TorsoCollide = false end
if not _G.RigEnabled then _G.RigEnabled = false end
if not _G.Net then _G.Net = false end
if not _G.NoNetless then _G.NoNetless = false end
if not _G.RemoveAnims then _G.RemoveAnims = false end
if not _G.Physics then _G.Physics = false end
function Attach(P0,P1,Position,Orientation)
	for i, v in pairs(P0:GetChildren()) do
        if v:IsA("Motor6D") and v.Name ~= "Neck" then v:Destroy() end
	end
   local AP = Instance.new("AlignPosition")
   AP.Parent = P1
   AP.MaxForce = 76007600
   AP.Responsiveness = 200
   AP.MaxVelocity = math.huge
   AP.ApplyAtCenterOfMass = false
   AP.RigidityEnabled = false
   
   AP.Name = "Position"
   
   local AO = Instance.new("AlignOrientation")
   AO.Parent = P0
   AO.MaxTorque = 76007600
   AO.Responsiveness = 200
   AO.MaxAngularVelocity = math.huge
   AO.RigidityEnabled = false
   AO.Name = "Position"
   
    if _G.RigEnabled == true then
    	 AP.RigidityEnabled = true
   	end
   local Attachment1 = Instance.new("Attachment")
   Attachment1.Parent = P0
   Attachment1.Name = "Attach"
   Attachment1.Position = Position or Vector3.new(0,0,0)
   Attachment1.Orientation = Orientation or Vector3.new(0,0,0)
   local Attachment2 = Instance.new("Attachment")
   Attachment2.Parent = P1
   Attachment2.Name = "Attach"

   
   AP.Attachment0 = Attachment1
   AP.Attachment1 = Attachment2
   
   AO.Attachment0 = Attachment1
   AO.Attachment1 = Attachment2
end

local Character = game.Players.LocalPlayer.Character; Character.Archivable = true
local Clone = game:GetObjects('rbxassetid://8440552086')[1]
Clone.Parent = Character; Clone.Name = "Dummy"
for _, v in pairs(Clone:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then
	v.Transparency = 1
end end
local Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
local CloneTorso = Clone:FindFirstChild("Torso")
local Humanoid = Character:FindFirstChild("Humanoid")
local CloneHumanoid = Clone:FindFirstChild("Humanoid")
local Root = Character:FindFirstChild("HumanoidRootPart")
Clone.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame
local TriggerNoclip
local TriggerNetless
function Noclip()
	for _,v in pairs(Clone:GetDescendants()) do
		if v:IsA("BasePart") then v.CanCollide = false end
	end
	if _G.TorsoCollide == false then
		for _,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then v.CanCollide = false end
		end
	elseif _G.TorsoCollide == true then
		for _,v in pairs(Character:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "UpperTorso" then 
			v.CanCollide = false end
		end
	end

	for _,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
		v:Stop()
	end
end
TriggerNoclip = game:GetService("RunService").Stepped:Connect(Noclip)

if _G.Bullet == true then
	local CloneRoot = Root:Clone()
	CloneRoot.Parent = Character
	Character.PrimaryPart = CloneRoot
	CloneRoot.Name = "HumanoidRootParta"
	CloneRoot.Anchored = true
end
function Netless()
	for _,v in pairs(Character:GetChildren()) do
		if v:IsA("MeshPart") or v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
			if _G.NoNetless == false and _G.Fling == false then
				v.Velocity = Vector3.new(25.05,25.05,25.05)
			elseif _G.NoNetless == false and _G.Fling == true then
				v.Velocity = Vector3.new(25.05,25.05,25.05)
				Torso.RotVelocity = Vector3.new(3500,3500,3500)
			elseif _G.NoNetless == true and _G.Fling == false then
				
			elseif _G.NoNetless == true and _G.Fling == true then
				Torso.RotVelocity = Vector3.new(3500,3500,3500)
			end
		end	
	end
		pcall(function()
		CloneHumanoid:Move(Humanoid.MoveDirection, false)
		if Humanoid.RigType == Enum.HumanoidRigType.R6 then
		 Torso.CFrame = CloneTorso.CFrame
		elseif Humanoid.RigType == Enum.HumanoidRigType.R6 and _G.Bullet == false then
			Torso.CFrame = CloneTorso.CFrame * CFrame.new(0,0.19,0)
			Root.CFrame = Torso.CFrame * CFrame.new(0,-0.15,0)
		elseif Humanoid.RigType == Enum.HumanoidRigType.R6 and _G.Bullet == false then
			
		end
	end)
end
TriggerNetless = game:GetService("RunService").Heartbeat:Connect(Netless)

Humanoid.Died:Connect(function()
	TriggerNoclip:Disconnect()
	TriggerNetless:Disconnect()
end)
if Humanoid.RigType == Enum.HumanoidRigType.R6 then
	Character.HumanoidRootPart:Destroy()
	Attach(Character.Torso,Clone.Torso)
	Attach(Character["Right Arm"],Clone["Right Arm"])
	Attach(Character["Left Arm"],Clone["Left Arm"])
	Attach(Character["Right Leg"],Clone["Right Leg"])
	Attach(Character["Left Leg"],Clone["Left Leg"])
	if _G.Bullet == true then
		Humanoid:ChangeState("Physics")
		local faker = Character:FindFirstChild("Pal Hair").Handle
		faker.AccessoryWeld:Destroy()
		faker.Mesh:Destroy()
		Attach(faker,Clone["Right Arm"],Vector3.new(0,0,0),Vector3.new(90,0,0))
		Character["Right Arm"].Name = "Bullet"
	end
else
    for _,v in pairs(Humanoid:GetChildren()) do
        if v:IsA("NumberValue") then v:Destroy() end
    end
    Attach(Character.UpperTorso, Clone['Torso'],Vector3.new(0, 0.15, 0))
    Attach(Character.LowerTorso, Clone['Torso'],Vector3.new(0, 0.75, 0))
    Attach(Character.LeftUpperArm, Clone['Left Arm'],Vector3.new(0, -0.405, 0)) 
    Attach(Character.LeftLowerArm, Clone['Left Arm'],Vector3.new(0, 0.18, 0))
    Attach(Character.LeftHand, Clone['Left Arm'],Vector3.new(0, 0.8, 0))
    Attach(Character.RightUpperArm, Clone['Right Arm'],Vector3.new(0, -0.405, 0))
    Attach(Character.RightLowerArm, Clone['Right Arm'],Vector3.new(0, 0.18, 0))
    Attach(Character.RightHand, Clone['Right Arm'],Vector3.new(0, 0.8, 0))
    Attach(Character.LeftUpperLeg, Clone['Left Leg'],Vector3.new(0, -0.6, 0))
    Attach(Character.LeftLowerLeg, Clone['Left Leg'],Vector3.new(0, 0.15, 0))
    Attach(Character.LeftFoot, Clone['Left Leg'],Vector3.new(0, 0.85, 0))
    Attach(Character.RightUpperLeg, Clone['Right Leg'],Vector3.new(0, -0.6, 0))
    Attach(Character.RightLowerLeg, Clone['Right Leg'],Vector3.new(0, 0.15, 0))
    Attach(Character.RightFoot, Clone['Right Leg'],Vector3.new(0, 0.85, 0))
    if _G.Bullet == true then
		Humanoid:ChangeState("Physics")
		Character["LowerTorso"].Name = "Bullet"
	end
    Character.Animate.Disabled = true
end
