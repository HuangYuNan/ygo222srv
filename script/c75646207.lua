--天之痕 琳影
function c75646207.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,75646207)
	e1:SetTarget(c75646207.destg1)
	e1:SetOperation(c75646207.desop1)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646207,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,7564627)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
		Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	end)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetCurrentChain()>2 
		and re:IsActiveType(TYPE_SPELL) and Duel.IsChainDisablable(ev)  and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
		Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if not Duel.NegateActivation(ev) then return end
		Duel.Draw(tp,1,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75646207,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1,7564627)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return re and re:GetHandler():IsSetCard(0x2c2) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsHasCategory(CATEGORY_RECOVER) and Duel.GetTurnPlayer()==tp
	end)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if sg and sg:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
			Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(75646207,2))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCountLimit(1,7564627)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return re and re:GetHandler():IsSetCard(0x2c2) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsHasCategory(CATEGORY_TOHAND) and Duel.GetTurnPlayer()==tp
	end)
	e4:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(c75646207.rfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	end)
	e4:SetOperation(c75646207.atop)
	c:RegisterEffect(e4)
end
function c75646207.rfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c2) and c:IsType(TYPE_MONSTER) 
end
function c75646207.atop(e,tp,eg,ep,ev,re,r,rp)
		if not e:GetHandler():IsRelateToEffect(e) then return end
		if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		local g=Duel.GetMatchingGroup(c75646207.rfilter,tp,LOCATION_MZONE,0,nil)
		if g:GetCount()==0 then return end
		local tc=g:GetFirst()
		while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(600)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
function c75646207.desfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c75646207.thfilter(c)
	return c:IsSetCard(0x2c2) and c:IsAbleToHand()
end
function c75646207.destg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c75646202.desfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c75646207.desfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c75646207.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c75646207.desfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75646207.desop1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c75646207.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end