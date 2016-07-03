--战场女武神 谜之瓦尔基里
function c11113029.initial_effect(c)
	c:SetUniqueOnField(1,0,11113029)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,11113009,c11113029.ffilter,1,true,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetValue(c11113029.splimit)
	c:RegisterEffect(e1)
	--destroy & remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113029,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,11113029)
	e2:SetCost(c11113029.cost)
	e2:SetTarget(c11113029.target)
	e2:SetOperation(c11113029.operation)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11113029,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,111130290)
	e3:SetCondition(c11113029.thcon)
	e3:SetCost(c11113029.thcost)
	e3:SetTarget(c11113029.thtg)
	e3:SetOperation(c11113029.thop)
	c:RegisterEffect(e3)
end
function c11113029.ffilter(c)
	return c:IsFusionSetCard(0x15c) and c:IsType(TYPE_TUNER)
end
function c11113029.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c11113029.dfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsAbleToDeckAsCost()
end	
function c11113029.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113029.dfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c11113029.dfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c11113029.desfilter(c,tp)
	return c:GetSummonPlayer()~=tp and c:IsFaceup() and c:GetSummonLocation()==LOCATION_EXTRA
		and c:IsLocation(LOCATION_MZONE) and c:IsDestructable() and c:IsAbleToRemove()
end
function c11113029.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=eg:Filter(c11113029.desfilter,nil,tp)
	local ct=g:GetCount()
	if chk==0 then return ct>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,ct,0,0)
end
function c11113029.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c11113029.desfilter,nil,tp):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
	    Duel.Destroy(g,REASON_EFFECT,LOCATION_REMOVED)
	end	
end
function c11113029.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c11113029.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c11113029.thfilter1(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_TUNER) and c:IsAbleToHand()
end
function c11113029.thfilter2(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_PENDULUM)
end
function c11113029.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    lpc,rpc=Duel.GetFieldCard(tp,LOCATION_SZONE,6),Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local b1=Duel.IsExistingMatchingCard(c11113029.thfilter1,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(c11113029.thfilter2,tp,LOCATION_DECK,0,1,nil) and (lpc==nil or rpc==nil)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(11113029,2),aux.Stringid(11113029,3))
	elseif b1 then op=Duel.SelectOption(tp,aux.Stringid(11113029,2))
	else op=Duel.SelectOption(tp,aux.Stringid(11113029,3))+1 end
	e:SetLabel(op)
	if op==0 then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
end
function c11113029.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	    local g=Duel.SelectMatchingCard(tp,c11113029.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	    if g:GetCount()>0 then
		    Duel.SendtoHand(g,nil,REASON_EFFECT)
		    Duel.ConfirmCards(1-tp,g)
	    end
	else	
		lpc,rpc=Duel.GetFieldCard(tp,LOCATION_SZONE,6),Duel.GetFieldCard(tp,LOCATION_SZONE,7)
		if lpc and rpc then return end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11113029,4))
		local g=Duel.GetMatchingGroup(c11113029.thfilter2,tp,LOCATION_DECK,0,nil)
	    if g:GetCount()>0 then
			local tg=g:Select(tp,1,1,nil)
			local tc=tg:GetFirst()
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end