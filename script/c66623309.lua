
require("/expansions/script/c37564765")
require("/expansions/script/c37564777")
function c66623309.initial_effect(c)
	senya.setreg(c,66623309,66623300)
	c:EnableReviveLimit()
	prim.nnr(c,c66623309.con,c66623309.op,aux.Stringid(66623309,0),CATEGORY_SPECIAL_SUMMON)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(function(e,re,r,rp)
		return bit.band(r,REASON_EFFECT)~=0
	end)
	c:RegisterEffect(e1)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(66623309,1))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c66623309.target)
	e6:SetOperation(c66623309.activate)
	c:RegisterEffect(e6)
end
function c66623309.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66623309.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler())
end
function c66623309.filter(c,e,tp)
	return c:IsHasEffect(66623300) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66623309.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66623309.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		Duel.SpecialSummonComplete()
	end
end
function c66623309.filter1(c,tp)
	local seq=c:GetSequence()
	local g1=Duel.GetMatchingGroup(c66623309.filter2,tp,0,LOCATION_ONFIELD,nil,4-seq)
	local g2=Duel.GetMatchingGroup(c66623309.filter2,tp,LOCATION_ONFIELD,0,nil,seq)
	g1:Merge(g2)
	return c:IsHasEffect(66623300) and g1:GetCount()>0 and c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c66623309.filter2(c,seq)
	return c:GetSequence()==seq and c:IsDestructable()
end
function c66623309.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c66623309.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66623309.filter1,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c66623309.filter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	local seq=g:GetFirst():GetSequence()
	local g1=Duel.GetMatchingGroup(c66623309.filter2,tp,0,LOCATION_ONFIELD,nil,4-seq)
	local g2=Duel.GetMatchingGroup(c66623309.filter2,tp,LOCATION_ONFIELD,0,nil,seq)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c66623309.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local seq=tc:GetSequence()
		local g1=Duel.GetMatchingGroup(c66623309.filter2,tp,0,LOCATION_ONFIELD,nil,4-seq)
		local g2=Duel.GetMatchingGroup(c66623309.filter2,tp,LOCATION_ONFIELD,0,nil,seq)
		g1:Merge(g2)
		Duel.Destroy(g1,REASON_EFFECT)
	end
end