function c37564309.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564309,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,37564309)
	e2:SetTarget(c37564309.drtg)
	e2:SetOperation(c37564309.drop)
	e2:SetLabelObject(g)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564309,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,37564309)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c37564309.spcost)
	e3:SetTarget(c37564309.sptg)
	e3:SetOperation(c37564309.spop)
	c:RegisterEffect(e3)
end
function c37564309.f1(c)
	return c:IsAbleToDeck() and not c:IsPublic()
end
function c37564309.f2(c,tpe)
	return c:IsAbleToDeck() and not c:IsPublic() and c:IsType(tpe)
end
function c37564309.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=e:GetLabelObject()
	if chk==0 then return Duel.IsExistingMatchingCard(c37564309.f1,tp,LOCATION_HAND,0,1,nil) end
	sg:Clear()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	local s1=Duel.SelectMatchingCard(tp,c37564309.f1,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	sg:AddCard(s1)
	local tpe=bit.band(s1:GetType(),0x7)
	if Duel.IsExistingMatchingCard(c37564309.f2,tp,LOCATION_HAND,0,1,s1,tpe) and Duel.SelectYesNo(tp,aux.Stringid(37564309,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
		local g=Duel.SelectMatchingCard(tp,c37564309.f2,tp,LOCATION_HAND,0,1,99,s1,tpe)
		sg:Merge(g)
	end
	Duel.ConfirmCards(tp,sg)
	Duel.SetTargetCard(sg)
	e:SetLabel(0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+   EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_END)
		e1:SetLabelObject(e)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			if e:GetLabelObject():GetLabel()==0 then
				Duel.ShuffleHand(tp)
			end
			e:Reset()
		end)
		Duel.RegisterEffect(e1,tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,sg:GetCount())
end
function c37564309.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local sg=e:GetLabelObject()
	local g=sg:Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	if ct>0 then
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,ct,REASON_EFFECT)
		e:SetLabel(1)
	end
end
function c37564309.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564309.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) and Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c37564309.costfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37564309.filter(c,e,tp)
	return c:GetLevel()==4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564309.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:GetLevel()==4 and c:IsAbleToRemoveAsCost()
end
function c37564309.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564309.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c37564309.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564309.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
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
		if Duel.IsExistingMatchingCard(c37564309.dfilter,tp,LOCATION_DECK,0,1,nil,tc) and Duel.SelectYesNo(tp,aux.Stringid(37564309,3)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g=Duel.SelectMatchingCard(tp,c37564309.dfilter,tp,LOCATION_DECK,0,1,1,nil,tc)
			if g:GetCount()>0 then
				Duel.SendtoGrave(g,REASON_EFFECT)
			end
		end
	end
end
function c37564309.dfilter(c,tc)
	local lv1=c:GetLevel()
	local lv2=tc:GetLevel()
	return bit.band(c:GetAttribute(),tc:GetAttribute())~=0 and bit.band(c:GetRace(),tc:GetRace())~=0 and c:GetLevel()>0 and lv1==lv2 and lv1~=0 and c:IsAbleToGrave() and c:IsType(TYPE_MONSTER)
end