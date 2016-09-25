--有识结界
function c101169142.initial_effect(c)
	--name
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_FZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(c101169142.n1val)
	c:RegisterEffect(e1)
	--cannot be targeted
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c101169142.n1val(e,c)
	if not c:IsSetCard(0xf1) then
		return 521011
	elseif c:GetOriginalCode() == 101169141 then
		return 10119141
	end
end