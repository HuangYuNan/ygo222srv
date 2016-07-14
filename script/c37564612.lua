--Prim-胧
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564612.initial_effect(c)
	senya.setreg(c,37564612,37564600)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564612,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,37564612)
	e1:SetCost(c37564612.rmcost)
	e1:SetTarget(c37564612.thtg)
	e1:SetOperation(c37564612.rmop)
	c:RegisterEffect(e1)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(37564612,1))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetRange(LOCATION_GRAVE)
	e6:SetCost(c37564612.cost)
	e6:SetTarget(c37564612.target)
	e6:SetOperation(c37564612.activate)
	c:RegisterEffect(e6)
end
function c37564612.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c37564612.thfilter(c)
	return c:IsHasEffect(37564600) and c:IsAbleToHand() and (not c:IsCode(37564612))
end
function c37564612.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564612.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c37564612.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c37564612.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c37564612.swwcostfilter(c)
	return c:IsHasEffect(37564600) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c37564612.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	 if chk==0 then return Duel.IsExistingMatchingCard(c37564612.swwcostfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) and e:GetHandler():IsAbleToRemoveAsCost() end
	 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	 local g=Duel.SelectMatchingCard(tp,c37564612.swwcostfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	 g:AddCard(e:GetHandler())
	 Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37564612.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end
function c37564612.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c37564612.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c37564612.filter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c37564612.filter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c37564612.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end