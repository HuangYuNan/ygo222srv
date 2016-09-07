--ＳＡｒｋ（ステラライズ・アークエンジェル）・アスセティック
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991011.initial_effect(c)
	--Xyz
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_PENDULUM),4,2)
	c:EnableReviveLimit()
	--SSet
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,9991011)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_XYZ)~=0
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
			and Duel.IsExistingMatchingCard(c9991011.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,c9991011.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			Duel.SSet(tp,tc)
			Duel.ConfirmCards(1-tp,g)
			tc:SetStatus(STATUS_SET_TURN,false)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(9991011,0))
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetReset(RESET_EVENT+0x47e0000)
			e1:SetValue(LOCATION_REMOVED)
			tc:RegisterEffect(e1,true)
		end
	end)
	c:RegisterEffect(e1)
	--Grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_MAIN_END)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
			and not e:GetHandler():IsStatus(STATUS_CHAINING)
	end)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3) end
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(3)
		Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.DiscardDeck(p,d,REASON_EFFECT)
		local g=Duel.GetOperatedGroup()
		if g:FilterCount(function(c)
			return Dazz.IsStellaris(c,nil,"Warrior") and c:IsLocation(LOCATION_GRAVE) end,nil)>0 then
			Duel.BreakEffect()
			Duel.Recover(tp,1000,REASON_EFFECT)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e2)
end
c9991011.Dazz_name_stellaris="Archangel"
function c9991011.filter(c)
	return c:IsCode(9991031,9991032) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
