--幽邃教教徒 迪得莉
function c29201209.initial_effect(c)
	--recover
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(29201209,0))
	e6:SetCategory(CATEGORY_DRAW)
    e6:SetType(EFFECT_TYPE_QUICK_O)
    e6:SetCode(EVENT_FREE_CHAIN)
    e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e6:SetRange(LOCATION_HAND)
	e6:SetCountLimit(1,29201209)
	e6:SetCost(c29201209.reccost)
	e6:SetTarget(c29201209.rectg)
	e6:SetOperation(c29201209.recop)
	c:RegisterEffect(e6)
    --extra summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetOperation(c29201209.sumop)
    c:RegisterEffect(e1)
    --synchro effect
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(29201209,2))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
    e2:SetCountLimit(1)
    e2:SetCondition(c29201209.sccon)
    e2:SetTarget(c29201209.sctg)
    e2:SetOperation(c29201209.scop)
    c:RegisterEffect(e2)
end
function c29201209.sccon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then return false end
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c29201209.mfilter(c)
	return c:IsSetCard(0x63e1)
end
function c29201209.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c29201209.mfilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29201209.scop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(c29201209.mfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
	end
end
function c29201209.sumop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetFlagEffect(tp,29201209)~=0 then return end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
    e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
    e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x63e1))
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
    Duel.RegisterFlagEffect(tp,29201209,RESET_PHASE+PHASE_END,0,1)
end
function c29201209.costfilter(c)
    return c:IsSetCard(0x63e1) and (c:IsAbleToDeckAsCost() or c:IsAbleToExtraAsCost())
end
function c29201209.costfilter1(c)
    return c:IsSetCard(0x63e1) and not c:IsPublic()
end
function c29201209.reccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() and Duel.IsExistingMatchingCard(c29201209.costfilter,tp,LOCATION_GRAVE,0,4,nil)
	  and Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0 and Duel.IsExistingMatchingCard(c29201209.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) 
      and not e:GetHandler():IsPublic() end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local g=Duel.SelectMatchingCard(tp,c29201209.costfilter1,tp,LOCATION_HAND,0,1,1,e:GetHandler())
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g1=Duel.SelectMatchingCard(tp,c29201209.costfilter,tp,LOCATION_GRAVE,0,4,4,nil)
    Duel.SendtoDeck(g1,nil,2,REASON_COST)
    local tc=g:GetFirst()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_PUBLIC)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e:GetHandler():RegisterEffect(e1)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_PUBLIC)
    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e2)
	--
    local e10=Effect.CreateEffect(e:GetHandler())
    e10:SetType(EFFECT_TYPE_FIELD)
    e10:SetCode(EFFECT_CANNOT_SUMMON)
    e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e10:SetReset(RESET_PHASE+PHASE_END)
    e10:SetTargetRange(1,0)
    Duel.RegisterEffect(e10,tp)
    local e12=e10:Clone()
    e12:SetCode(EFFECT_CANNOT_MSET)
    Duel.RegisterEffect(e12,tp)
	Duel.ShuffleHand(tp)
end
function c29201209.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(2)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c29201209.recop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end
