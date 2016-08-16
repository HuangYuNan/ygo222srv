--暗魔战姬 天翼
function c04103107.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x1013),4,2)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(04103107,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCost(c04103107.cost)
	e1:SetTarget(c04103107.netg)
	e1:SetOperation(c04103107.neop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(04103107,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c04103107.thcon)
	e2:SetTarget(c04103107.thtg)
	e2:SetOperation(c04103107.thop)
	c:RegisterEffect(e2)
end	
function c04103107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c04103107.filter(c)
	return c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c04103107.netg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c04103107.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c04103107.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c04103107.neop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local atk=tc:GetAttack()
	if tc and tc:IsRelateToEffect(e) then
	    local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_SET_ATTACK)
	    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	    e1:SetValue(atk/2)
	    tc:RegisterEffect(e1)
	    local e2=Effect.CreateEffect(c)
	    e2:SetType(EFFECT_TYPE_SINGLE)
	    e2:SetCode(EFFECT_DISABLE)
	    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	    tc:RegisterEffect(e2)
	    local e3=Effect.CreateEffect(c)
	    e3:SetType(EFFECT_TYPE_SINGLE)
	    e3:SetCode(EFFECT_DISABLE_EFFECT)
	    e3:SetValue(RESET_TURN_SET)
	    e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	    tc:RegisterEffect(e3)
	end	
end	
function c04103107.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and bit.band(c:GetSummonType(),SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
function c04103107.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSetCard(0x1013)
end
function c04103107.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c04103107.cfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
end
function c04103107.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c04103107.cfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
	    Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local tc=g:GetFirst()
		if tc:IsLocation(LOCATION_HAND) then
            local e1=Effect.CreateEffect(c)
            e1:SetType(EFFECT_TYPE_FIELD)
            e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
            e1:SetCode(EFFECT_CANNOT_ACTIVATE)
            e1:SetTargetRange(1,0)
	        e1:SetValue(c04103107.aclimit)
		    e1:SetLabel(tc:GetCode())
            e1:SetReset(RESET_PHASE+PHASE_END)
            Duel.RegisterEffect(e1,tp)
        end
	end	
end	
function c04103107.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end
