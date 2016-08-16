--イーフィックスの術士
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991405.initial_effect(c)
	--To Hand or SSet
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetDecktopGroup(tp,1)
		if g:GetCount()==0 then return end
		local pe,tc=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DECK),g:GetFirst()
		local confirm=(pe and tc:IsFaceup()) or (not pe and tc:IsFacedown())
		if confirm then
			Duel.ConfirmCards(tp,g)
		end
		if not (Dazz.IsAephiex(tc) and tc:IsType(TYPE_SPELL+TYPE_TRAP)) then
			Duel.SelectOption(tp,aux.Stringid(9991404,2))
			return
		end
		local selt={tp}
		local keyt={}
		if tc:IsAbleToHand() then
			table.insert(selt,aux.Stringid(9991404,0))
			table.insert(keyt,0)
		end
		if tc:IsSSetable(true) and (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
			table.insert(selt,aux.Stringid(9991404,1))
			table.insert(keyt,1)
		end
		table.insert(selt,aux.Stringid(9991404,2))
		table.insert(keyt,2)
		local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
		if sel==0 then
			Duel.DisableShuffleCheck()
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
			Duel.ShuffleHand(tp)
		elseif sel==1 then
			Duel.DisableShuffleCheck()
			Duel.SSet(tp,tc)
			Duel.ConfirmCards(1-tp,tc)
		end
	end)
	c:RegisterEffect(e1)
	--Sort Decktop
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,9991405)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Dazz.IsAephiex,tp,LOCATION_DECK,0,1,nil) end
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetMatchingGroup(Dazz.IsAephiex,tp,LOCATION_DECK,0,nil)
		if g:GetCount()==0 then
			g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
			if g:GetCount()~=0 then
				Duel.ConfirmCards(1-tp,g)
				Duel.ShuffleDeck(tp)
			end
			return
		end
		Duel.Hint(HINT_SELECTMSG,tp,526)
		g=g:Select(tp,1,4,nil)
		Duel.ConfirmCards(1-tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,506)
		g1=g:Select(tp,1,1,nil)
		if g1:GetFirst():IsAbleToHand() then
			Duel.SendtoHand(g1,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g1)
		else
			Duel.SendtoGrave(g1,REASON_RULE)
		end
		g:Sub(g1)
		Duel.ShuffleDeck(tp)
		local tc=g:GetFirst()
		while tc do
			Duel.MoveSequence(tc,0)
			tc=g:GetNext()
		end
		Duel.SortDecktop(tp,tp,g:GetCount())
	end)
	c:RegisterEffect(e2)
end
c9991405.Dazz_name_Aephiex=true