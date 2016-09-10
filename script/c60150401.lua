--琪亚娜 卡斯兰娜
function c60150401.initial_effect(c)
	--tohand
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TOGRAVE)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e1:SetCountLimit(1,60150401)
    e1:SetTarget(c60150401.target)
    e1:SetOperation(c60150401.operation)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)
	--atk
    local e3=Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetCountLimit(1,60150402)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCost(c60150401.atkcost)
	e3:SetTarget(c60150401.sptg)
    e3:SetOperation(c60150401.spop)
    c:RegisterEffect(e3)
	--act limit
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCode(EFFECT_CANNOT_ACTIVATE)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e4:SetTargetRange(1,1)
	e4:SetCondition(c60150401.descon)
    e4:SetValue(c60150401.aclimit)
    c:RegisterEffect(e4)
	--tohand
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(c60150401.descon)
	e5:SetTarget(c60150401.target2)
    e5:SetOperation(c60150401.thop)
    c:RegisterEffect(e5)
	local e6=e5:Clone()
    e6:SetCode(EVENT_BE_BATTLE_TARGET)
    c:RegisterEffect(e6)
end
function c60150401.filter(c)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end
function c60150401.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c60150401.filter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60150401.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c60150401.filter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
function c60150401.filter2(c)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToGraveAsCost()
end
function c60150401.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return c:GetEquipGroup():IsExists(c60150401.filter2,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=c:GetEquipGroup():FilterSelect(tp,c60150401.filter2,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c60150401.filter3(c,e,tp)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_MONSTER) and not c:IsCode(60150401) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60150401.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c60150401.filter3,tp,LOCATION_DECK,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c60150401.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c60150401.filter3,tp,LOCATION_DECK,0,1,1,nil,e,tp)
    local tc=g:GetFirst()
    if tc then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		e1:SetValue(c60150401.xyzlimit)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
    end
end
function c60150401.xyzlimit(e,c)
    if not c then return false end
    return not c:IsSetCard(0x6b21)
end
function c60150401.filter4(c)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150401.descon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetEquipGroup():FilterCount(c60150401.filter4,nil)>0
end
function c60150401.aclimit(e,re,tp)
    return re:IsActiveType(TYPE_EQUIP) and re:GetHandler():IsOnField()
		and re:GetHandler():IsSetCard(0x6b21) and re:GetHandler():GetEquipTarget()==e:GetHandler()
		and not re:GetHandler():IsImmuneToEffect(e)
end
function c60150401.spfilter(c,e,tp,ec)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:GetEquipTarget()==ec
end
function c60150401.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c60150401.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150401,1))
    local g=Duel.SelectTarget(tp,c60150401.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0,0)
end
function c60150401.thop(e,tp,eg,ep,ev,re,r,rp,chk)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_IMMUNE_EFFECT)
        e1:SetValue(c60150401.efilter)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
        tc:RegisterEffect(e1)
    end
end
function c60150401.efilter(e,re)
    return e:GetHandler()~=re:GetOwner()
end