--光波色散
function c10980008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10980008+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c10980008.target)
	e1:SetOperation(c10980008.operation)
	c:RegisterEffect(e1)	
end
function c10980008.cfilter(c,e,tp)
	local lv=c:GetLevel()
	return lv>0 
		and Duel.IsExistingMatchingCard(c10980008.spfilter,tp,LOCATION_DECK,0,1,nil,lv,e,tp)
end
function c10980008.spfilter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsSetCard(0x1236) and
		(c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) or c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE))
end
function c10980008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroupEx(tp,c10980008.cfilter,1,nil,e,tp) end
	local rg=Duel.SelectReleaseGroupEx(tp,c10980008.cfilter,1,1,nil,e,tp)
	e:SetLabel(rg:GetFirst():GetLevel())
	Duel.Release(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c10980008.spfilter2(c,e,tp)
	return c:IsSetCard(0x1236) and
		(c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) or c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE))
end
function c10980008.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local c=e:GetHandler()
	local slv=e:GetLabel()
	local sg=Duel.GetMatchingGroup(c10980008.spfilter2,tp,LOCATION_DECK,0,nil,e,tp)
	sg:Remove(Card.IsLevelAbove,nil,slv+1)
	if sg:GetCount()==0 then return end
	local cg=Group.CreateGroup()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=sg:Select(tp,1,1,nil):GetFirst()
		sg:RemoveCard(tc)
		slv=slv-tc:GetLevel()
		local spos=0
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then spos=spos+POS_FACEUP_ATTACK end
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN) then spos=spos+POS_FACEDOWN_DEFENSE end
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,spos)
		if tc:IsFacedown() then cg:AddCard(tc) end
		c:SetCardTarget(tc)
		sg:Remove(Card.IsLevelAbove,nil,slv+1)
		ft=ft-1
	until ft<=0 or sg:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(10980008,0))
	Duel.SpecialSummonComplete()
	Duel.ConfirmCards(1-tp,cg)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetOperation(c10980008.desop)
	Duel.RegisterEffect(e1,tp)
end
function c10980008.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
