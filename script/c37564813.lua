--妖隐 -BANAMI & 3L Remix-
local m=37564813
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function cm.initial_effect(c)
	senya.leff(c,m)
end
function cm.effect_operation_3L(c,ec,chk)
	local e=senya.neg(c,1)
	e:SetDescription(m*16+1)
	e:SetReset(senya.lres(chk))
end