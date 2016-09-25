function c73201011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCountLimit(1,73201011+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c73201011.cost)
	e1:SetTarget(c73201011.target)
	e1:SetOperation(c73201011.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73201011,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c73201011.drcon)
	e2:SetTarget(c73201011.drtg)
	e2:SetOperation(c73201011.drop)
	c:RegisterEffect(e2)
end
function c73201011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c73201011.costfilter(c,e,dg)
	if not c:IsSetCard(0x730) then return false end
	local a=0
	if dg:IsContains(c) then a=1 end
	if c:GetEquipCount()==0 then return dg:GetCount()-a>=2 end
	local eg=c:GetEquipGroup()
	local tc=eg:GetFirst()
	while tc do
		if dg:IsContains(tc) then a=a+1 end
		tc=eg:GetNext()
	end
	return dg:GetCount()-a>=2
end
function c73201011.tgfilter(c,e)
	return c:IsDestructable() and c:IsCanBeEffectTarget(e)
end
function c73201011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then
		if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
		if e:GetLabel()==1 then
			e:SetLabel(0)
			local rg=Duel.GetReleaseGroup(tp)
			local dg=Duel.GetMatchingGroup(c73201011.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler(),e)
			local res=rg:IsExists(c73201011.costfilter,1,e:GetHandler(),e,dg)
			return res
		else
			return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,e:GetHandler())
		end
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local rg=Duel.GetReleaseGroup(tp)
		local dg=Duel.GetMatchingGroup(c73201011.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler(),e)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local sg=rg:FilterSelect(tp,c73201011.costfilter,1,1,e:GetHandler(),e,dg)
		Duel.Release(sg,REASON_COST)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,2,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c73201011.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end
function c73201011.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(r,0x41)==0x41 and rp~=tp and c:GetPreviousControler()==tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
end
function c73201011.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c73201011.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end