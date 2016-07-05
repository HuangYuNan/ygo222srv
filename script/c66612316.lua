--骗术，虚伪or幸福？
function c66612316.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66612316,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,66612316)
	e1:SetTarget(c66612316.target)
	e1:SetOperation(c66612316.activate)
	c:RegisterEffect(e1)
end
function c66612316.rfilter(c)
	return c:IsSetCard(0x660) and (c:IsAbleToRemove() or  c:IsAbleToGrave())   and c:IsType(TYPE_MONSTER)
end
function c66612316.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.IsExistingMatchingCard(c66612316.rfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c66612316.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)>1 then
	local g=Duel.SelectMatchingCard(tp,c66612316.rfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if not tc:IsAbleToRemove()  or Duel.SelectYesNo(tp,aux.Stringid(66612316,0)) then
			Duel.SendtoGrave(tc,REASON_EFFECT)
		else
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		end
	end
end
end