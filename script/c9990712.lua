--Persistent Nightmare
require "expansions/script/c9990000"
function c9990712.initial_effect(c)
	Dazz.DFCBacksideCommonEffect(c)
	--Spirit Return
	aux.EnableSpiritReturn(c,EVENT_SPSUMMON_SUCCESS)
	--Attack Limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end