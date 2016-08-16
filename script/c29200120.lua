--凋叶棕-献歌-彼岸归航交响曲-
function c29200120.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,29200120+EFFECT_COUNT_CODE_OATH)
    e1:SetCost(c29200120.cost)
    e1:SetTarget(c29200120.target)
    e1:SetOperation(c29200120.activate)
    c:RegisterEffect(e1)
    --token
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition(aux.exccon)
    e2:SetCost(c29200120.tkcost)
    e2:SetTarget(c29200120.tktg)
    e2:SetOperation(c29200120.tkop)
    c:RegisterEffect(e2)
    Duel.AddCustomActivityCounter(29200120,ACTIVITY_SUMMON,c29200120.counterfilter)
    Duel.AddCustomActivityCounter(29200120,ACTIVITY_SPSUMMON,c29200120.counterfilter)
end
function c29200120.counterfilter(c)
    return c:IsSetCard(0x53e0)
end
function c29200120.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetCustomActivityCount(29200120,tp,ACTIVITY_SUMMON)==0
        and Duel.GetCustomActivityCount(29200120,tp,ACTIVITY_SPSUMMON)==0 end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
    e1:SetCode(EFFECT_CANNOT_SUMMON)
    e1:SetTargetRange(1,0)
    e1:SetTarget(c29200120.sumlimit)
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    Duel.RegisterEffect(e2,tp)
end
function c29200120.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsSetCard(0x53e0)
end
function c29200120.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(3)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,2)
end
function c29200120.activate(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    if Duel.Draw(p,d,REASON_EFFECT)==3 then
        Duel.ShuffleHand(p)
        Duel.BreakEffect()
        local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
        if g:GetCount()>1 and g:IsExists(Card.IsSetCard,1,nil,0x53e0) then
            Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
            local sg1=g:FilterSelect(p,Card.IsSetCard,1,1,nil,0x53e0)
            Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
            local sg2=g:Select(p,1,1,sg1:GetFirst())
            sg1:Merge(sg2)
            Duel.ConfirmCards(1-p,sg1)
            Duel.SendtoDeck(sg1,nil,0,REASON_EFFECT)
            Duel.SortDecktop(p,p,2)
        else
            local hg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
            Duel.ConfirmCards(1-p,hg)
            local ct=Duel.SendtoDeck(hg,nil,0,REASON_EFFECT)
            Duel.SortDecktop(p,p,ct)
        end
    end
end
function c29200120.tkcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c29200120.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsPlayerCanSpecialSummonMonster(tp,29200116,0x53e0,0x5011,1000,1000,2,0x4,0x10) end
    Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c29200120.tkop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
        or not Duel.IsPlayerCanSpecialSummonMonster(tp,29200116,0x53e0,0x5011,1000,1000,2,0x4,0x10) then return end
    local token=Duel.CreateToken(tp,29200116)
    Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UNRELEASABLE_SUM)
    e1:SetValue(1)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    token:RegisterEffect(e1,true)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
    token:RegisterEffect(e2,true)
    Duel.SpecialSummonComplete()
end


