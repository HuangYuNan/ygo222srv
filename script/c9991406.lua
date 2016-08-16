--イーフィックスの論命者
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991406.initial_effect(c)
	--SP From Hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,19991406)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then
			c9991406.confirm_decktop(tp)
			return
		end
		local sp=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		local tc,confirm=c9991406.confirm_decktop(tp)
		if tc and Dazz.IsAephiex(tc) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
			if Duel.SelectYesNo(tp,aux.Stringid(9991406,0)) then
				if confirm then
					Duel.ConfirmCards(1-tp,tc)
				end
				Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
				return
			end
		end
		if c:IsAbleToDeck() then
			Duel.SendtoDeck(c,tp,0,REASON_EFFECT)
		else
			Duel.SendtoGrave(c,REASON_RULE)
		end
	end)
	c:RegisterEffect(e1)
	--Sort Decktop
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,29991406)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>1 end
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)<2 then return end
		local g1=Duel.GetDecktopGroup(1-tp,2)
		Duel.ConfirmCards(tp,g1)
		if Duel.SelectYesNo(tp,aux.Stringid(9991406,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9991406,2))
			local g2=g1:Select(tp,1,2,nil)
			g1:Sub(g2)
			while g2:GetCount()~=0 do
				Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9991406,5))
				local g=g2:Select(tp,1,1,nil)
				Duel.MoveSequence(g:GetFirst(),1)
				g2:Sub(g)
			end
		end
		local val=g1:GetCount()
		if val<2 then return end
		Duel.SortDecktop(tp,1-tp,val)
	end)
	c:RegisterEffect(e2)
end
c9991406.Dazz_name_Aephiex=true
function c9991406.confirm_decktop(tp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	local pe,tc=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DECK),g:GetFirst()
	local confirm=(pe and tc:IsFaceup()) or (not pe and tc:IsFacedown())
	if confirm then
		Duel.ConfirmCards(tp,g)
	end
	return tc,confirm
end