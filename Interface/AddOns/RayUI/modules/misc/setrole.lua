﻿local R, L, P, G = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, GlobalDB
local M = R:GetModule("Misc")
local mod = M:NewModule("SetRole", "AceEvent-3.0")
local S = R:GetModule("Skins")

local t = {
	["Melee"] = "DAMAGER",
	["Caster"] = "DAMAGER",
	["Tank"] = "TANK",
}

function mod:SetRole()
	local spec = GetSpecialization()
	if UnitLevel("player") >= 10 and not InCombatLockdown() then
		if spec == nil and UnitGroupRolesAssigned("player") ~= "NONE" then
			UnitSetRole("player", "NONE")
		elseif spec ~= nil then
			if GetNumGroupMembers() > 0 then
				if R.isHealer then
					if UnitGroupRolesAssigned("player") ~= "HEALER" then
						UnitSetRole("player", "HEALER")
					end
				else
					if UnitGroupRolesAssigned("player") ~= t[R.Role] then
						UnitSetRole("player", t[R.Role])
					end
				end
			end
		end
	end
end

function mod:Initialize()
	R.RegisterCallback(mod, "RoleChanged", "SetRole")
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "SetRole")
	RolePollPopup:SetScript("OnShow", function() StaticPopupSpecial_Hide(RolePollPopup) end)
end

M:RegisterMiscModule(mod:GetName())
