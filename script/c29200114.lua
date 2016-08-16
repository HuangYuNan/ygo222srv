--凋叶棕-尽管如此洋馆还是旋转着
function c29200114.initial_effect(c)
    --special summon
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetDescription(aux.Stringid(29200114,1))
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition(aux.exccon)
    e2:SetCost(c29200114.spcost)
    e2:SetTarget(c29200114.sptarget)
    e2:SetOperation(c29200114.spoperation)
    c:RegisterEffect(e2)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1,78785392+EFFECT_COUNT_CODE_OATH)
    e1:SetCost(c29200114.cost)
    e1:SetTarget(c29200114.target)
    e1:SetOperation(c29200114.activate)
    c:RegisterEffect(e1)
    Duel.AddCustomActivityCounter(29200114,ACTIVITY_SUMMON,c29200114.counterfilter)
    Duel.AddCustomActivityCounter(29200114,ACTIVITY_SPSUMMON,c29200114.counterfilter)
end
function c29200114.counterfilter(c)
    return c:IsSetCard(0x53e0)
end
function c29200114.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetCustomActivityCount(29200114,tp,ACTIVITY_SUMMON)==0
        and Duel.GetCustomActivityCount(29200114,tp,ACTIVITY_SPSUMMON)==0 and Duel.IsPlayerCanDiscardDeckAsCost(tp,3) end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
    e1:SetCode(EFFECT_CANNOT_SUMMON)
    e1:SetTargetRange(1,0)
    e1:SetTarget(c29200114.sumlimit)
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    Duel.RegisterEffect(e2,tp)
	Duel.DiscardDeck(tp,3,REASON_COST)
end
function c29200114.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
    return not c:IsSetCard(0x53e0)
end
function c29200114.filter(c)
    return c:IsSetCard(0x53e0) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29200114.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29200114.filter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29200114.activate(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29200114.filter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
function c29200114.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c29200114.sptarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29200114.spoperation(e,tp,eg,ep,ev,re,r,rp)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1)
    local tc=g:GetFirst()
    if (tc:IsType(TYPE_SPELL+TYPE_TRAP) and tc:IsSetCard(0x53e0)) then
	    if Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0x53e0,0x11,500,2200,6,RACE_SPELLCASTER,ATTRIBUTE_DARK)
            and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
            --[[tc:AddMonsterAttribute(TYPE_NORMAL,ATTRIBUTE_EARTH,RACE_FAIRY,4,0,2200)
            tc:AddMonsterAttributeComplete()
            Duel.SpecialSummonComplete()]]
			Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_SET_BASE_ATTACK)
            e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
            e1:SetValue(500)
            --e1:SetReset(RESET_EVENT+0x1fe0000)
            e1:SetReset(RESET_EVENT+0x47c0000)
            tc:RegisterEffect(e1)
            local e2=e1:Clone()
            e2:SetCode(EFFECT_SET_BASE_DEFENSE)
            e2:SetValue(2200)
            tc:RegisterEffect(e2)
            local e3=e1:Clone()
            e3:SetCode(EFFECT_CHANGE_LEVEL)
            e3:SetValue(6)
            tc:RegisterEffect(e3)
            local e4=e1:Clone()
            e4:SetCode(EFFECT_CHANGE_RACE)
            e4:SetValue(RACE_SPELLCASTER)
            tc:RegisterEffect(e4)
            local e5=e1:Clone()
            e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
            e5:SetValue(ATTRIBUTE_DARK)
            tc:RegisterEffect(e5)
            local e6=e1:Clone()
            e6:SetCode(EFFECT_CHANGE_TYPE)
            e6:SetValue(0x11)
            tc:RegisterEffect(e6)
            Duel.SpecialSummonComplete()
        else
            Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
		end
    else
        Duel.MoveSequence(tc,1)
	    --Duel.RaiseSingleEvent(tc,29200000,e,0,0,0,0)
	    Duel.RaiseEvent(tc,EVENT_CUSTOM+29200001,e,0,tp,0,0)
    end
end




