require 'script.c2150000'
function c2150002.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_SINGLE)
	a:SetCode(EFFECT_INDESTRUCTABLE)
	a:SetValue(1)
	c:RegisterEffect(a)
	a=a:Clone()
	a:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(a)
	a=a:Clone()
	a:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	c:RegisterEffect(a)
end
	
