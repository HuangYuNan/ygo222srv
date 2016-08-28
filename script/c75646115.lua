--Stella-星夏
function c75646115.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,75646115)
	e1:SetCondition(c75646115.spcon)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(0x2)
	e2:SetRange(0x4)
	e2:SetCode(29)
	e2:SetTargetRange(0x6,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x62c3))
	c:RegisterEffect(e2)
	--damge
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75646115,0))
	e5:SetCategory(0x80000)
	e5:SetType(0x82)
	e5:SetRange(0x4)
	e5:SetCountLimit(1,7564615)
	e5:SetProperty(0x10000)
	e5:SetCode(0x10000000+75646112)
	e5:SetTarget(c75646115.tg)
	e5:SetOperation(c75646115.op)
	c:RegisterEffect(e5)
end
function c75646115.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3)
end
function c75646115.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75646115.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c75646115.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x62c3)
end
function c75646115.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c75646115.damfilter,tp,0xc,0,nil)
	if chk==0 then return ct>0 end
	Duel.SetTargetParam(ct*100)
	Duel.SetOperationInfo(0,0x80000,nil,0,1-tp,ct*100)
end
function c75646115.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c75646115.damfilter,tp,0xc,0,nil)
	if Duel.Damage(1-tp,ct*100,0x40)~=0 then
	local c=e:GetHandler()
	Duel.RaiseEvent(c,0x10000000+75646112,e,0,tp,0,0)
	end
end