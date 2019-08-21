if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/icon_shield.vmt")
	resource.AddFile("materials/vgui/ttt/perks/hud_shield.png")
end

ITEM.hud = Material("vgui/ttt/perks/hud_shield.png")
ITEM.EquipMenuData = {
	type = "item_passive",
	name = "BlockDmg",
	desc = "You don't get any damage anymore!"
}
ITEM.material = "vgui/ttt/icon_shield"
ITEM.credits = 8
ITEM.notBuyable = true
ITEM.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}

if SERVER then
	hook.Add("ScalePlayerDamage", "TTTBlockDmg", function(ply, _, dmginfo)
		if ply:IsActive() and ply:HasEquipmentItem("item_ttt_blockdmg") then
			dmginfo:ScaleDamage(0) -- no dmg
		end
	end)

	hook.Add("EntityTakeDamage", "TTTBlockDmg", function(target, dmginfo)
		if not IsValid(target) or not target:IsPlayer() then return end

		if target:IsActive() and target:HasEquipmentItem("item_ttt_blockdmg") then
			dmginfo:ScaleDamage(0) -- no dmg
		end
	end)
end
