--ÑÝ×àÕß µç¼ªËû
function c3201004.initial_effect(c)
	--tohand
local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3201004,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c3201004.cost)
	e1:SetTarget(c3201004.target)
	e1:SetOperation(c3201004.operation)
	c:RegisterEffect(e1)
end
function c3201004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()and Duel.IsExistingTarget(c3201004.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c3201004.filter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x321) and not c:IsCode(3201004)
end
function c3201004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c3201004.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c3201004.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c3201004.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c3201004.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end