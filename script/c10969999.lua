--虚梦天使
function c10969999.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetRange(LOCATION_PZONE)
	e6:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e6:SetTarget(c10969999.target)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e7:SetTarget(c10969999.target2)
	c:RegisterEffect(e7)
	local e8=e6:Clone()
	e8:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e8:SetTarget(c10969999.target3)
	c:RegisterEffect(e8)	
end
function c10969999.target(e,c)
	return c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ)
end
function c10969999.target2(e,c)
	return c:IsType(TYPE_FUSION) or c:IsType(TYPE_SYNCHRO)
end
function c10969999.target3(e,c)
	return c:IsType(TYPE_XYZ) or c:IsType(TYPE_SYNCHRO)
end