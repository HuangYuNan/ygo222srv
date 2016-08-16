--The Last Miracle
function c10957795.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,10957795+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c10957795.condition)
	e1:SetCost(c10957795.cost)
	e1:SetTarget(c10957795.target)
	e1:SetOperation(c10957795.activate)
	c:RegisterEffect(e1) 
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c10957795.reptg)
	e2:SetValue(c10957795.repval)
	e2:SetOperation(c10957795.repop)
	c:RegisterEffect(e2)   
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e3:SetCondition(c10957795.handcon)
	c:RegisterEffect(e3) 
end
function c10957795.hdfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x239) and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c10957795.handcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10957795.hdfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c10957795.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x239) and c:IsType(TYPE_XYZ)
end
function c10957795.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and Duel.IsExistingMatchingCard(c10957795.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c10957795.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c10957795.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10957795.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c10957795.aclimit)
	e1:SetLabel(re:GetHandler():GetCode())
	Duel.RegisterEffect(e1,tp)
end
function c10957795.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end
function c10957795.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x239) and c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_MZONE)
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c10957795.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c10957795.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(10957795,0))
end
function c10957795.repval(e,c)
	return c10957795.repfilter(c,e:GetHandlerPlayer())
end
function c10957795.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
