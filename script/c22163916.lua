--傲娇master远坂凛
function c22163916.initial_effect(c)
    --synchro summon
    aux.AddSynchroProcedure(c,aux.FilterBoolFunction(c22163916.syfilter),aux.NonTuner(nil),1)
    c:EnableReviveLimit()
    --synchro success
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_COUNTER+CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c22163916.addcc)
    e1:SetTarget(c22163916.addct)
    e1:SetOperation(c22163916.addc)
    c:RegisterEffect(e1)
	--atk
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(22163916,0))
    e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCost(c22163916.descost)
    e2:SetTarget(c22163916.destg)
    e2:SetOperation(c22163916.desop)
    c:RegisterEffect(e2)
	--im
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(22163916,1))
    e3:SetType(EFFECT_TYPE_QUICK_O)
    e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetCost(c22163916.descost)
    e3:SetTarget(c22163916.destg)
    e3:SetOperation(c22163916.desop2)
    c:RegisterEffect(e3)
	--im
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(22163916,2))
    e4:SetType(EFFECT_TYPE_QUICK_O)
    e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCost(c22163916.descost)
    e4:SetTarget(c22163916.destg)
    e4:SetOperation(c22163916.desop3)
    c:RegisterEffect(e4)
	--cannot be battle target
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
    e5:SetCondition(c22163916.atkcon)
    e5:SetValue(aux.imval1)
    c:RegisterEffect(e5)
	--immune
    local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_SINGLE)
    e6:SetCode(EFFECT_IMMUNE_EFFECT)
    e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e6:SetRange(LOCATION_MZONE)
    e6:SetCondition(c22163916.atkcon)
    e6:SetValue(c22163916.efilter)
    c:RegisterEffect(e6)
end
function c22163916.syfilter(c)
    return (c:IsSetCard(0x370) or (c:IsSetCard(0x2e0) or c:IsSetCard(0x2e1)))
end
function c22163916.addcc(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c22163916.filter(c,e,tp)
    return c:IsCode(99999971) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c22163916.addct(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c22163916.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,2,0,0x1222)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c22163916.addc(e,tp,eg,ep,ev,re,r,rp)
    if e:GetHandler():IsRelateToEffect(e) then
        if e:GetHandler():AddCounter(0x1222,2) then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c22163916.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
			local tc=g:GetFirst()
			if tc then
				Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
				tc:CompleteProcedure()
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
				e1:SetValue(1)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
				local e2=Effect.CreateEffect(e:GetHandler())
				e2:SetDescription(aux.Stringid(22163916,3))
				e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e2:SetCode(EVENT_PHASE+PHASE_END)
				e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CLIENT_HINT)
				e2:SetRange(LOCATION_MZONE)
				e2:SetCountLimit(1)
				e2:SetCondition(c22163916.tdcon)
				e2:SetOperation(c22163916.tdop)
				e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
				tc:RegisterEffect(e2)
				tc:RegisterFlagEffect(22163916,RESET_EVENT+0x1fe0000,0,1)
			end
		end
    end
end
function c22163916.tdcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()~=tp
end
function c22163916.tdop(e,tp,eg,ep,ev,re,r,rp)
    Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end
function c22163916.descost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1222,1,REASON_COST) end
    e:GetHandler():RemoveCounter(tp,0x1222,1,REASON_COST)
    Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c22163916.desfilter(c)
    return c:GetFlagEffect(22163916)>0 and c:IsFaceup()
end
function c22163916.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then return Duel.IsExistingTarget(c22163916.desfilter,tp,LOCATION_MZONE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    local g=Duel.SelectTarget(tp,c22163916.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE,g,1,0,0)
end
function c22163916.desop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsFaceup() and tc:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(22163916,0))
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        e1:SetValue(500)
        tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        e2:SetValue(500)
        tc:RegisterEffect(e2)
    end
end
function c22163916.desop2(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsFaceup() and tc:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(22163916,1))
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        e1:SetValue(1)
        tc:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
        tc:RegisterEffect(e2)
    end
end
function c22163916.desop3(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsFaceup() and tc:IsRelateToEffect(e) then
        local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetDescription(aux.Stringid(22163916,2))
        e4:SetType(EFFECT_TYPE_SINGLE)
        e4:SetCode(EFFECT_IMMUNE_EFFECT)
		e4:SetProperty(EFFECT_FLAG_CLIENT_HINT)
        e4:SetValue(c22163916.efilter)
        e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        e4:SetOwnerPlayer(tp)
        tc:RegisterEffect(e4)
    end
end
function c22163916.efilter(e,re)
    return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c22163916.atkfilter(c)
    return c:IsFaceup() and c:GetFlagEffect(22163916)>0
end
function c22163916.atkcon(e)
    return Duel.IsExistingMatchingCard(c22163916.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end