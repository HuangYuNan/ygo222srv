--イーフィックスの識者
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991404.initial_effect(c)
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
	--Draw 2
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,9991404)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.Draw(tp,2,REASON_EFFECT)==0 then return end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
		if sg:GetCount()<1 then return end
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(g,tp,0,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end
c9991404.Dazz_name_Aephiex=true