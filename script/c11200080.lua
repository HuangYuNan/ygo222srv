function c11200080.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	a:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	a:SetRange(LOCATION_REMOVED)
	a:SetCategory(CATEGORY_SPECIAL_SUMMON)
	a:SetCountLimit(1)
	a:SetTarget(c11200080.tga)
	a:SetOperation(c11200080.opa)
	a:SetDescription(1118)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_REMOVED)
	b:SetTarget(c11200080.cob)
	b:SetOperation(c11200080.opb)
	b:SetDescription(1103)
	b:SetCountLimit(2,11200080)
	c:RegisterEffect(b)
end
function c11200080.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,0)
end
function c11200080.opa(e,tp)
	if not e:GetHandler():IsRelateToEffect(e)or Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)<1 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x47e0000)
	e1:SetValue(LOCATION_REMOVED)
	e:GetHandler():RegisterEffect(e1,true)
end
function c11200080.cob(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetCurrentPhase()
	if chk==0 then return t>=PHASE_BATTLE_START and t<=PHASE_BATTLE end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_RETURN)
end
function c11200080.opb(e,tp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 and not Duel.SelectYesNo(tp,1122)then
		local c=g:GetFirst()
		local a=Effect.CreateEffect(e:GetHandler())
		a:SetType(EFFECT_TYPE_SINGLE)
		a:SetCode(EFFECT_UPDATE_ATTACK)
		a:SetReset(RESET_EVENT+RESET_LEAVE+RESET_TURN_SET)
		a:SetValue(-550)
		c:RegisterEffect(a)
		local b=a:Clone()
		b:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(b)
		c=g:GetNext()
		while c do
			a=a:Clone()
			c:RegisterEffect(a)
			b=b:Clone()
			c:RegisterEffect(b)
			c=g:GetNext()
		end
	else Duel.SetLP(1-tp,Duel.GetLP(1-tp)-1100)
	end
end