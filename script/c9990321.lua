--Gideon Jura
function c9990321.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetDescription(aux.Stringid(9990321,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCost(c9990321.cost1)
	e1:SetTarget(c9990321.target1)
	e1:SetOperation(c9990321.operation1)
	c:RegisterEffect(e1)
	--Counter
	local e2=e1:Clone()
	e2:SetCategory(0)
	e2:SetDescription(aux.Stringid(9990321,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetLabel(1)
	e2:SetTarget(c9990321.target2)
	e2:SetOperation(c9990321.operation2)
	c:RegisterEffect(e2)
	--AD
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(function(e,c)
		return c:GetCounter(0x1220)*200
	end)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
function c9990321.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local val=e:GetLabel()==1
	if chk==0 then return val or c:IsCanRemoveCounter(tp,0x1220,15,REASON_COST) end
	if not val then c:RemoveCounter(tp,0x1220,15,REASON_COST) end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9990321,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
end
function c9990321.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c9990321.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c9990321.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c9990321.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and c:IsRelateToEffect(e) and c:IsFaceup() then
		local val=math.max(tc:GetLevel(),tc:GetRank())
		c:AddCounter(0x1220+COUNTER_NEED_ENABLE,val+1)
	end
end