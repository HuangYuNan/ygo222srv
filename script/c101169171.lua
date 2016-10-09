--空明-午卯茂一
function c101169171.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DEFENSE_ATTACK)
	e1:SetValue(c101169171.val)
	c:RegisterEffect(e1)
	--def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c101169171.atlimit)
	c:RegisterEffect(e3)
end
function c101169171.val(e,c)
	return e:GetHandler():GetAttack()<e:GetHandler():GetDefense()
end
function c101169171.atlimit(e,c)
	return c~=e:GetHandler()
end