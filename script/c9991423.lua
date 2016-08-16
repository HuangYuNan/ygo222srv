--イーフィックスの召集
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991423.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9991423.target)
	e1:SetOperation(c9991423.activate)
	c:RegisterEffect(e1)
end
c9991423.Dazz_name_Aephiex=true
function c9991423.filter(c,e,tp,lv)
	return Dazz.IsAephiex(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (not lv or c:IsLevelBelow(lv))
end
function c9991423.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local v={
		Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9991423.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
			and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,c),
		Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1,
	}
	if chk==0 then return v[1] or v[2] end
	local selt={tp}
	local keyt={}
	for i=1,2 do
		if v[i] then
			table.insert(selt,aux.Stringid(9991423,i-1))
			table.insert(keyt,i)
		end
	end
	local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
	c:RegisterFlagEffect(1,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991423,sel-1))
	if sel==1 then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	end
	e:SetLabel(sel)
end
function c9991423.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c9991423.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			Duel.BreakEffect()
			Duel.ShuffleDeck(tp)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,2,nil)
			local val=Duel.SendtoDeck(g,tp,0,REASON_EFFECT)
			if val==2 then
				Duel.SortDecktop(tp,tp,2)
			end
		end
	else
		local g=Duel.GetDecktopGroup(tp,2)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(tp,g)
		local sg=g:Filter(c9991423.filter,nil,e,tp,4)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and sg:GetCount()~=0
			and Duel.SelectYesNo(tp,aux.Stringid(9991423,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			sg=sg:Select(tp,1,1,nil)
			Duel.DisableShuffleCheck()
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			g:Sub(sg)
		end
		if g:GetCount()<=1 then return end
		Duel.SortDecktop(tp,tp,g:GetCount())
	end
end