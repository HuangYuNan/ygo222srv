--战场女武神 塞露贝利亚
function c11113013.initial_effect(c)
    --salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11113013,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,11113013)
	e1:SetCondition(c11113013.condition)
	e1:SetTarget(c11113013.target)
	e1:SetOperation(c11113013.operation)
	c:RegisterEffect(e1)
	--to hand
    local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113013,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,11113013)
	e2:SetTarget(c11113013.thtg)
	e2:SetOperation(c11113013.thop)
	c:RegisterEffect(e2)
end
function c11113013.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
	    and e:GetHandler():GetReasonCard():IsSetCard(0x15c)
end
function c11113013.filter(c)
	return c:IsSetCard(0x15c) and (c:GetType()==TYPE_SPELL or c:IsType(TYPE_QUICKPLAY)) and c:IsAbleToHand()
end
function c11113013.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113013.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c11113013.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCondition(c11113013.setcon)
	e1:SetOperation(c11113013.setop)
	Duel.RegisterEffect(e1,tp)
end
function c11113013.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11113013.filter,tp,LOCATION_DECK,0,1,nil)
end 
function c11113013.setop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_CARD,0,11113013)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11113013.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
	    Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end	
function c11113013.thfilter(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_TUNER) and not c:IsType(TYPE_PENDULUM) and not c:IsCode(11113013) and c:IsAbleToHand()
end
function c11113013.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113013.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11113013.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11113013.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
	end
end