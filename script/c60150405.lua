--布洛妮娅 扎伊切克
function c60150405.initial_effect(c)
	--special summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c60150405.spcon)
    c:RegisterEffect(e1)
	--boom
    local e3=Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetCountLimit(1,60150405)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCost(c60150405.atkcost)
	e3:SetTarget(c60150405.destg)
    e3:SetOperation(c60150405.desop)
    c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetValue(c60150405.xyzlimit)
    c:RegisterEffect(e2)
	--act limit
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCode(EFFECT_CANNOT_ACTIVATE)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e4:SetTargetRange(1,1)
	e4:SetCondition(c60150405.descon)
    e4:SetValue(c60150405.aclimit)
    c:RegisterEffect(e4)
	--tohand
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(c60150405.descon)
	e5:SetTarget(c60150405.target2)
    e5:SetOperation(c60150405.thop)
    c:RegisterEffect(e5)
	local e6=e5:Clone()
    e6:SetCode(EVENT_BE_BATTLE_TARGET)
    c:RegisterEffect(e6)
end
function c60150405.filter(c)
    return c:IsFaceup() and c:IsSetCard(0x6b21) and c:IsType(TYPE_MONSTER)
end
function c60150405.spcon(e,c)
    if c==nil then return true end
    return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
        Duel.IsExistingMatchingCard(c60150405.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c60150405.xyzlimit(e,c)
    if not c then return false end
    return not c:IsSetCard(0x6b21)
end
function c60150405.filter2(c)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:IsAbleToGraveAsCost()
end
function c60150405.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return c:GetEquipGroup():IsExists(c60150405.filter2,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=c:GetEquipGroup():FilterSelect(tp,c60150405.filter2,1,1,nil)
    Duel.SendtoGrave(g,REASON_COST)
end
function c60150405.filter3(c)
    return c:IsDestructable()
end
function c60150405.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c60150405.filter3,tp,0,LOCATION_ONFIELD,1,nil) end
    local g=Duel.GetMatchingGroup(c60150405.filter3,tp,0,LOCATION_ONFIELD,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c60150405.desop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectMatchingCard(tp,c60150405.filter3,tp,0,LOCATION_ONFIELD,1,1,nil)
    if g:GetCount()>0 then
        Duel.HintSelection(g)
        Duel.Destroy(g,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
    end
end
function c60150405.filter4(c)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP)
end
function c60150405.descon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetEquipGroup():FilterCount(c60150405.filter4,nil)>0
end
function c60150405.aclimit(e,re,tp)
    return re:IsActiveType(TYPE_EQUIP) and re:GetHandler():IsOnField()
		and re:GetHandler():IsSetCard(0x6b21) and re:GetHandler():GetEquipTarget()==e:GetHandler()
		and not re:GetHandler():IsImmuneToEffect(e)
end
function c60150405.spfilter(c,e,tp,ec)
    return c:IsSetCard(0x6b21) and c:IsType(TYPE_EQUIP) and c:GetEquipTarget()==ec
end
function c60150405.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c60150405.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150401,1))
    local g=Duel.SelectTarget(tp,c60150405.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0,0)
end
function c60150405.thop(e,tp,eg,ep,ev,re,r,rp,chk)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_IMMUNE_EFFECT)
        e1:SetValue(c60150405.efilter)
        e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
        tc:RegisterEffect(e1)
    end
end
function c60150405.efilter(e,re)
    return e:GetHandler()~=re:GetOwner()
end