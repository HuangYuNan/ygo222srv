--炼金生命体·绿
function c10112010.initial_effect(c)
	--ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c10112010.rlevel)
	c:RegisterEffect(e1)  
	--fusion substitute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e2:SetCondition(c10112010.subcon)
	c:RegisterEffect(e2)  
	--nontuner
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_NONTUNER)
	c:RegisterEffect(e3)
	--xyzlv
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_XYZ_LEVEL)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c10112010.xyzlv)
	c:RegisterEffect(e4)
end

function c10112010.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_MZONE) and e:GetHandler():IsFaceup()
end

function c10112010.xyzlv(e,c,rc)
	return 0x50000+e:GetHandler():GetLevel()
end

function c10112010.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	local clv=c:GetLevel()
	if e:GetHandler():IsLocation(LOCATION_MZONE) and e:GetHandler():IsFaceup() then
	return lv*65536+clv
	else return lv end
end
