	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c66619911.desreptg)
	c:RegisterEffect(e4)


function c66619911.repfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToGraveAsCost() and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
end
function c66619911.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(48739166,1)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end



	--attack up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(58712976,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c66619911.cost)
	e3:SetOperation(c66619911.operation)
	c:RegisterEffect(e3)

function c66619911.cffilter(c)
	return c:IsFaceup() and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToGraveAsCost()
end
function c66619911.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66619911.cffilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c66619911.cffilter,tp,LOCATION_SZONE,0,1,99,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c66619911.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ct*1000)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
end



	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c66619901.thtg)
	e1:SetOperation(c66619901.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)


function c66619901.filter1(c)

end
function c66619901.filter2(c)

end
function c66619901.cfilter(c)

end
function c66619901.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK+LOCATION_GRAVE) and chkc:IsControler(tp) and c66619901.filter1(chkc) end


	local b1=Duel.IsExistingTarget(c66619901.filter1,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)

	local b2=Duel.IsExistingMatchingCard(c66619901.filter2,tp,LOCATION_DECK,0,1,nil) and Duel.IsExistingTarget(c66619901.darwfilter,tp,LOCATION_ONFIELD,0,1,nil)

	if chk==0 then return b1 or b2 and Duel.IsExistingMatchingCard(c66619901.filter2,tp,LOCATION_ONFIELD,0,1,nil) end

	local op=0
	if b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(66619901,1),aux.Stringid(66619911,2))
	elseif b1 then op=Duel.SelectOption(tp,aux.Stringid(66619901,1))
	else op=Duel.SelectOption(tp,aux.Stringid(66619901,2))+1 end
	e:SetLabel(op)

	if op==0 then
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	else
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		local g=Duel.SelectMatchingCard(tp,c66619901.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.SendtoGrave(g,REASON_EFFECT)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end

end

function c66619901.thop(e,tp,eg,ep,ev,re,r,rp)

	if e:GetLabel()==0 then

	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66619911,3))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c66619911.atktg)
	e1:SetValue(c66619911.atkval)
	e1:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e1)

	else
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c66619911.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	end
end