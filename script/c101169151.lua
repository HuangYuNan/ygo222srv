--空明-云戌亥双见
function c101169151.initial_effect(c)
	--ritual material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101169151,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e1:SetCondition(c101169151.otcon)
	e1:SetTarget(c101169151.ottg)
	e1:SetOperation(c101169151.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	Duel.RegisterEffect(e2,tp)
	--lv up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101169151,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,101169151)
	e3:SetHintTiming(0x1c0)
	e3:SetTarget(c101169151.target)
	e3:SetOperation(c101169151.operation)
	c:RegisterEffect(e3)
end
function c101169151.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c101169151.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c101169151.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c101169151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c101169151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c101169151.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-1)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetValue(1)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetValue(-300)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetValue(300)
		c:RegisterEffect(e4)
		local e5=Effect.CreateEffect(e:GetHandler())
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_UPDATE_DEFENCE)
		e5:SetValue(-300)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e5)
		local e6=e5:Clone()
		e6:SetValue(300)
		c:RegisterEffect(e6)
	end
end
function c101169151.rmfilter(c)
	return c:IsCode(101169151) 
end
function c101169151.otcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c101169151.rmfilter,tp,LOCATION_HAND,0,1,nil)
end
function c101169151.ottg(e,c)
	local mi,ma=c:GetTributeRequirement()
	return c:IsSetCard(0xf1) and mi>=1 and not c:IsCode(101169151)
end
function c101169151.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectMatchingCard(tp,c101169151.rmfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Release(g1,REASON_COST)
end