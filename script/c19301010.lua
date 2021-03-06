--希望的恋心
function c19301010.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c19301010.condition)
	e1:SetCost(c19301010.cost)
	e1:SetTarget(c19301010.target)
	e1:SetOperation(c19301010.activate)
	c:RegisterEffect(e1)
end
function c19301010.cfilter(c)
	return not c:IsRace(RACE_PSYCHO) and c:IsType(TYPE_MONSTER)
end
function c19301010.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c19301010.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c19301010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,19301010)==0 end
	Duel.RegisterFlagEffect(tp,19301010,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c19301010.filter(c)
	return c:IsSetCard(0x190) or c:IsSetCard(0x933) and c:IsAbleToHand()
end
function c19301010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19301010.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c19301010.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c19301010.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetTarget(c19301010.tg)
	e1:SetValue(-1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c19301010.tg(e,c)
	return c:IsRace(RACE_PSYCHO)
end