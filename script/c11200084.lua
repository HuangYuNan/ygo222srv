function fcoRemoveQinglan(c)
	local t=c:GetCode()
	return t>11200079 and t<11200087 and t~=11200083 and c:IsAbleToRemoveAsCost()
end
function fRemoveQinglan(c)
	local t=c:GetCode()
	return t>11200079 and t<11200087 and t~=11200083 and c:IsAbleToRemove()
end
function fQinglan(c)
	local t=c:GetCode()
	return t>11200079 and t<11200087 and t~=11200083
end
function fupQinglan(c)
	local t=c:GetCode()
	return t>11200079 and t<11200087 and t~=11200083 and c:IsFaceup()
end
function c11200084.initial_effect(c)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_IGNITION)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_HAND+LOCATION_ONFIELD)
	a:SetCategory(CATEGORY_REMOVE)
	a:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	a:SetCost(c11200080.coa)
	a:SetOperation(c11200080.opa)
	a:SetCountLimit(1,11200084)
	c:RegisterEffect(a)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_IGNITION)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_REMOVED)
	b:SetCategory(CATEGORY_REMOVE)
	b:SetCost(c11200080.cob)
	b:SetOperation(c11200080.opa)
	b:SetCountLimit(1,11200084)
	c:RegisterEffect(b)
end
function c11200080.coa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		e:GetHandler():IsAbleToRemoveAsCost()and
		Duel.IsExistingMatchingCard(fcoRemoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler())and
		Duel.IsExistingMatchingCard(fRemoveQinglan,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil)
	end
	local g=Duel.SelectMatchingCard(tp,fcoRemoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,RESET_COST)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,tp,LOCATION_GRAVE)
end
function c11200080.opa(e,tp)
	Duel.Remove(Duel.SelectMatchingCard(tp,fRemoveQinglan,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil),POS_FACEUP,REASON_EFFECT)
end
function c11200080.cob(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
		Duel.IsExistingMatchingCard(fupQinglan,0,LOCATION_REMOVED,LOCATION_REMOVED,1,e:GetHandler())and
		Duel.IsExistingMatchingCard(fRemoveQinglan,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil)
	end
	local g=Duel.SelectMatchingCard(tp,fupQinglan,0,LOCATION_REMOVED,LOCATION_REMOVED,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST+REASON_RETURN)
end
