

_G.Velocity = Vector3.new(0,-36.5,0) -- Velocity
_G.Fling = false -- Torso Fling
_G.Bullet = false -- Bullet (Range Fling; R6 WEAR THIS: https://www.roblox.com/catalog/63690008/Pal-Hair)
_G.RigEnabled = false -- Rigidity Enabled for AlignPosition to reduce body movement on idle.
_G.Net = false -- Applies Network Claim to avoid body parts drop for first few seconds
_G.NoNetless = false -- Disables Netless
_G.RemoveAnims = false -- Removes Animations
_G.Physics = false -- Simillar to net, expect its just physics.

loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/ProjectCatV2/main/Reanimate/Reanimation.lua"))()
