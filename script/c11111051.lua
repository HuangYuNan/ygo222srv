--鲜血与冰凌花
function c11111051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,11111051+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c11111051.target)
	e1:SetOperation(c11111051.activate)
	c:RegisterEffect(e1)
end
function c11111051.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x15d) and c:IsAbleToDeck()
		and Duel.IsExistingMatchingCard(c11111051.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetCode())
end
function c11111051.spfilter(c,e,tp,code)
	return c:IsSetCard(0x15d) and not c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11111051.filter2(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x15d) and c:IsDestructable()
		and Duel.IsExistingMatchingCard(c11111051.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c11111051.thfilter(c,code)
	return c:IsSetCard(0x15d) and not c:IsCode(code) and c:IsAbleToHand()
end
function c11111051.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if Duel.GetTurnPlayer()==tp then
		if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c11111051.filter1(chkc,e,tp) end
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanDraw(tp,1)
			and Duel.IsExistingTarget(c11111051.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c11111051.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	else
        if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c11111051.filter2(chkc,tp) end
		if chk==0 then return Duel.IsExistingTarget(c11111051.filter2,tp,LOCATION_MZONE,0,1,nil,tp) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,c11111051.filter2,tp,LOCATION_MZONE,0,1,1,nil,tp)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end	
end
function c11111051.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then
	    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		local tc=Duel.GetFirstTarget()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c11111051.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc:GetCode())
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 then
			    Duel.ShuffleDeck(tp)
 				Duel.BreakEffect()
		        Duel.Draw(tp,1,REASON_EFFECT)
			end
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetAbsoluteRange(tp,1,0)
			e1:SetTarget(c11111051.splimit)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			g:GetFirst():RegisterEffect(e1,true)
		end
	else
	    local tc=Duel.GetFirstTarget()
	    if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=Duel.SelectMatchingCard(tp,c11111051.thfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode())
			if g:GetCount()>0 then
			    Duel.SendtoHand(g,nil,REASON_EFFECT)
		        Duel.ConfirmCards(1-tp,g)
			end
		end	
	end		
end
function c11111051.splimit(e,c)
	return not c:IsSetCard(0x15d)
end