--娜娜的同桌
require("/expansions/script/c37564765")
require("/expansions/script/c37564777")
function c66623303.initial_effect(c)
	senya.setreg(c,66623303,66623300)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66623303,0))
	e2:SetCategory(CATEGORY_LEAVE_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c66623303.target)
	e2:SetOperation(c66623303.activate)
	c:RegisterEffect(e2)
	prim.nn(c,senya.sesrtg(LOCATION_DECK,c66623303.srfilter),senya.sesrop(LOCATION_DECK,c66623303.srfilter),false,CATEGORY_TOHAND+CATEGORY_SEARCH)
end
function c66623303.srfilter(c)
	return c:IsHasEffect(66623300) and not c:IsType(TYPE_RITUAL)
end
function c66623303.filter(c)
	return c:IsHasEffect(66623300) and c:IsType(TYPE_RITUAL)
end
function c66623303.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c66623303.filter(chkc) end
	if chk==0 then
		if not Duel.IsExistingTarget(c66623303.filter,tp,LOCATION_GRAVE,0,1,nil) then return false end
		return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectTarget(tp,c66623303.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c66623303.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
	end
end