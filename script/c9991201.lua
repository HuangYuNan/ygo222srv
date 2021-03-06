--神天竜－ヘリテイジ
require "expansions/script/c9990000"
function c9991201.initial_effect(c)
	Dazz.GodraMainCommonEffect(c)
	--Hand Fusion
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991201,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,19991201)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c=e:GetHandler()
		if chk==0 then return c:IsRace(RACE_WYRM) and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)~=0 and Duel.IsExistingMatchingCard(c9991201.filter1,tp,LOCATION_HAND,0,1,e:GetHandler(),e,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
		Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e)
			or not c:IsCanBeFusionMaterial() or c:IsImmuneToEffect(e) then return end
		if not Duel.IsExistingMatchingCard(c9991201.filter1,tp,LOCATION_HAND,0,1,e:GetHandler(),e,tp) then
			local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
			local cg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
			if cg1:GetCount()>1 and cg2:IsExists(Card.IsFacedown,1,nil)
				and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
				Duel.ConfirmCards(1-tp,cg1)
				Duel.ConfirmCards(1-tp,cg2)
				Duel.ShuffleHand(tp)
			end
			return
		end
		local fm=Group.CreateGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=Duel.SelectMatchingCard(tp,c9991201.filter1,tp,LOCATION_HAND,0,1,1,e:GetHandler(),e,tp)
		Duel.ConfirmCards(1-tp,g1)
		g1:AddCard(e:GetHandler())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c9991201.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,g1)
		g2:GetFirst():SetMaterial(g1)
		Duel.SendtoGrave(g1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
		Duel.BreakEffect()
		Duel.SpecialSummon(g2,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		g2:GetFirst():CompleteProcedure()
	end)
	c:RegisterEffect(e1)
	--Recycle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9991201,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,29991201)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return e:GetHandler():IsAbleToDeck() and Duel.IsPlayerCanDraw(tp,2)
			and Duel.IsExistingMatchingCard(c9991201.tdfilter,tp,LOCATION_GRAVE,0,2,nil) end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,0,LOCATION_GRAVE)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
		Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not (c:IsRelateToEffect(e) and c:IsAbleToDeck() and Duel.IsPlayerCanDraw(tp,2)
			and Duel.IsExistingMatchingCard(c9991201.tdfilter,tp,LOCATION_GRAVE,0,2,nil)) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,c9991201.tdfilter,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.HintSelection(g)
		g:AddCard(c)
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
		if Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)>0 then
			Duel.ShuffleDeck(tp)
		end
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end
c9991201.Dazz_name_godra=true
function c9991201.filter1(c,e,tp)
	return c:IsRace(RACE_WYRM) and c:IsCanBeFusionMaterial()
		and Duel.IsExistingMatchingCard(c9991201.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,Group.FromCards(c,e:GetHandler()))
end
function c9991201.filter2(c,e,tp,mg)
	return Dazz.IsGodra(c) and c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(mg)
end
function c9991201.tdfilter(c)
	return Dazz.IsGodra(c) and c:IsAbleToDeck()
end