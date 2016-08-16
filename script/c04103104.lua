--魔战姬降临
function c04103104.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(04103104,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,04103104)
	e1:SetCondition(c04103104.spcon)
	e1:SetTarget(c04103104.sptg)
	e1:SetOperation(c04103104.spop)
	c:RegisterEffect(e1)
    --Activate
    local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(04103104,0))
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetCountLimit(1)
    e2:SetTarget(c04103104.settg)
    e2:SetOperation(c04103104.setop)
    c:RegisterEffect(e2)
    --Remove
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_LEAVE_FIELD)
    e3:SetOperation(c04103104.rmop)
    c:RegisterEffect(e3)
end 
function c04103104.setfilter(c)
	return c:IsSetCard(0x1013) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable() and not c:IsCode(04103104)
end
function c04103104.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		and Duel.IsExistingMatchingCard(c04103104.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c04103104.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c04103104.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c04103104.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsSetCard(0x1013) and tc:GetSummonPlayer()==tp then
		e:SetLabel(tc:GetCode())
		return true
	else return false end
end
function c04103104.filter(c,e,tp,code)
	return c:IsSetCard(0x1013) and c:GetCode()~=code and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c04103104.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_DECK+LOCATION_HAND) and c04103104.filter(chkc,e,tp,e:GetLabel()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c04103104.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,e:GetLabel()) end
end
function c04103104.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c04103104.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,e:GetLabel())
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 and c:IsFaceup() and c:IsRelateToEffect(e) then
	    c:SetCardTarget(tc)
		local e2=Effect.CreateEffect(c)
	    e2:SetType(EFFECT_TYPE_SINGLE)
	    e2:SetCode(EFFECT_DISABLE)
	    e2:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e2)
	    local e3=Effect.CreateEffect(c)
	    e3:SetType(EFFECT_TYPE_SINGLE)
	    e3:SetCode(EFFECT_DISABLE_EFFECT)
	    e3:SetValue(RESET_TURN_SET)
	    e3:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e3)
	end
end
function c04103104.rmfilter(c,rc)
    return rc:GetCardTarget():IsContains(c)
end
function c04103104.rmop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:GetCardTargetCount()>0 then
        local rg=Duel.GetMatchingGroup(c04103104.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
        Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
    end
end
