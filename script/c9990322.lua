--Hixus, Prison Warden
function c9990322.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	--Synchro from Extra
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCountLimit(1,9990322)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetHintTiming(0,0x102e)
	e1:SetCondition(function(e,tp)
		return Duel.GetTurnPlayer()~=tp
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c=e:GetHandler()
		if chk==0 then return c:IsSynchroSummonable(nil) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		Duel.SynchroSummon(tp,c,nil)
	end)
	c:RegisterEffect(e1)
	--Summon Success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9990322,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
	end)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local fil=function(c) return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() end
		if chk==0 then return Duel.IsExistingMatchingCard(fil,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler()) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,fil,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,e:GetHandler())
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
		if sg:GetCount()==0 then return end
		local sg2=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
		sg:Sub(sg2)
		if sg:GetCount()==0 or (sg2:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(9990322,0))) then
			sg=sg2:RandomSelect(tp,1,1,nil)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			sg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
		end
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
	--Standby Phase
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringid(9990322,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetTurnPlayer()==tp
	end)
	c:RegisterEffect(e3)
end