--イーフィックスの騎士
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991402.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
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
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
			or not (tc:IsLevelBelow(4) and Dazz.IsAephiex(tc) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false))
			or not Duel.SelectYesNo(tp,aux.Stringid(9991402,0)) then
			return
		end
		Duel.DisableShuffleCheck()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end)
	c:RegisterEffect(e1)
	--Recycle
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,9991402)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c9991402.recyclefilter(chkc) and chkc:IsControler(tp) end
		if chk==0 then return Duel.IsExistingTarget(c9991402.recyclefilter,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c9991402.recyclefilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Draw(tp,1,REASON_EFFECT)
		local tc=Duel.GetFirstTarget()
		if not tc or not tc:IsRelateToEffect(e) then return end
		Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end
c9991402.Dazz_name_Aephiex=true
function c9991402.recyclefilter(c)
	return c:IsAbleToDeck() and Dazz.IsAephiex(c)
end