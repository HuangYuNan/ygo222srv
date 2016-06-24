--凋叶棕-Cruel CRuEL
function c29200121.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29200121,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	--e1:SetCondition(c29200121.setcon)
	e1:SetTarget(c29200121.sptg)
	e1:SetOperation(c29200121.spop)
	c:RegisterEffect(e1)
end
function c29200121.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c29200121.afilter,tp,LOCATION_HAND,0,2,nil) 
	  and Duel.IsExistingMatchingCard(c29200121.afilter1,tp,LOCATION_EXTRA,0,1,nil) 
end
function c29200121.afilter(c)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER)
end
function c29200121.afilter1(c)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_FUSION) 
end
function c29200121.filter1(c,e,tp,lv)
    local clv=c:GetLevel()
	return clv>0 and c:IsSetCard(0x53e0) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c29200121.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,clv+2)
end
--lv+c:GetLevel() 
function c29200121.filter2(c,e,tp,lv)
	return c:GetLevel()==lv and c:IsSetCard(0x53e0) and c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,true) 
end
--c:GetLevel()==lv ,e:GetHandler():GetLevel()
function c29200121.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_HAND) and c29200121.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and e:GetHandler():IsAbleToGrave()
		and Duel.IsExistingTarget(c29200121.filter1,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectTarget(tp,c29200121.filter1,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29200121.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local lv=tc:GetLevel()+2
	local g=Group.FromCards(c,tc)
	if Duel.SendtoGrave(g,REASON_EFFECT)==2 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c29200121.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetLevel()+2)
        local tc=sg:GetFirst()
        if tc then
             Duel.BreakEffect()
			 Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,true,POS_FACEUP)
			 tc:CompleteProcedure()
		end
	end
end

