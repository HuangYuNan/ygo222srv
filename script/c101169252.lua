--空明-巽策
function c101169252.initial_effect(c)
	--セイヴァー・スター・ドラゴン
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101169252,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,101169252)
	e3:SetTarget(c101169252.target)
	e3:SetOperation(c101169252.operation)
	c:RegisterEffect(e3)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101169252,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CHAIN_UNIQUE,EFFECT_FLAG2_NAGA)---wanjia
	e1:SetCode(EVENT_TO_DECK)
	e1:SetTarget(c101169252.target2)
	e1:SetOperation(c101169252.operation2)
	c:RegisterEffect(e1)
end
function c101169252.filter(c)
	return c:GetCode()~=c:GetOriginalCode()
end
function c101169252.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c101169252.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c101169252.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local cc=Duel.SelectTarget(tp,c101169252.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c101169252.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.MajesticCopy(c,tc)
		Debug.ReloadFieldBegin(DUEL_PSEUDO_SHUFFLE)
	end
end

function c101169252.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_HAND
end
function c101169252.filter2(c)
	return c:IsCode(101169252) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c101169252.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101169252.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c101169252.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c101169252.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end