--Pneuma's Realm
function c9991310.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_FZONE)
	e2:SetHintTiming(0,0x1c0)
	e2:SetCountLimit(1,9991310)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local v1,v2=Duel.CheckReleaseGroup(tp,c9991310.rlsfilter,1,nil),Duel.CheckReleaseGroup(tp,nil,2,nil)
		if chk==0 then
			if v1 or v2 then
				e:SetLabel(1)
				return true
			else
				return false
			end
		end
		e:SetLabel(1)
		local g=nil
		if v1 and (not v2 or Duel.SelectYesNo(tp,aux.Stringid(9991310,0))) then
			g=Duel.SelectReleaseGroup(tp,c9991310.rlsfilter,1,1,nil)
		else
			g=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
		end
		Duel.Release(g,REASON_COST)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then
			if e:GetLabel()~=1 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
				return false
			end
			e:SetLabel(0)
			return Duel.IsExistingMatchingCard(c9991310.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
		end
		e:SetLabel(0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c9991310.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()~=0 then
			Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		end
	end)
	c:RegisterEffect(e2)
end
function c9991310.rlsfilter(c)
	return c:GetLevel()==8 and c:IsRace(RACE_WYRM)
end
function c9991310.spfilter(c,e,tp)
	return c:IsCode(9991301,9991302,9991303,9991304) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c9991310.ConfirmDeck(tp)
	local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	Duel.ConfirmCards(1-tp,cg)
	Duel.ShuffleDeck(tp)
end