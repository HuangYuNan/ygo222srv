function c11200081.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	a:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	a:SetRange(LOCATION_REMOVED)
	a:SetCategory(CATEGORY_SPECIAL_SUMMON)
	a:SetCountLimit(1)
	a:SetTarget(c11200081.tga)
	a:SetOperation(c11200081.opa)
	a:SetDescription(1118)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_REMOVED)
	b:SetTarget(c11200081.cob)
	b:SetOperation(c11200081.opb)
	b:SetDescription(1103)
	b:SetCountLimit(2,11200081)
	c:RegisterEffect(b)
end
function c11200081.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetTurnPlayer()==tp end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,0)
end
function c11200081.opa(e,tp)
	if not e:GetHandler():IsRelateToEffect(e)or Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)<1 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x47e0000)
	e1:SetValue(LOCATION_REMOVED)
	e:GetHandler():RegisterEffect(e1,true)
end
function c11200081.cob(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetCurrentPhase()
	if chk==0 then return t>=PHASE_BATTLE_START and t<=PHASE_BATTLE and
		(Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)or
		Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil))
	end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_RETURN)
end
function c11200081.opb(e,tp)
	local a=Duel.GetMatchingGroup(Card.IsFaceup,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local b=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	if a:GetCount()>0 and(
		b:GetCount()<1 or
		Duel.SelectYesNo(tp,514))then
		Duel.ChangePosition(a:Select(tp,1,1,nil),POS_FACEDOWN_DEFENSE)
	elseif b:GetCount()>0 then
		Duel.Destroy(b:Select(tp,1,1,nil),REASON_EFFECT)
	end
end