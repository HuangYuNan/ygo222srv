--八枢罪 无暇之傲慢
function c60159118.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c60159118.xyzcon)
	e1:SetOperation(c60159118.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--cannot target
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetCondition(c60159118.immcon)
    e2:SetValue(c60159118.indval)
    c:RegisterEffect(e2)
	--battle target
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c60159118.immcon)
    e3:SetValue(aux.imval1)
    c:RegisterEffect(e3)
	--immune
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCode(EFFECT_IMMUNE_EFFECT)
    e4:SetCondition(c60159118.immcon2)
    e4:SetValue(c60159118.efilter)
    c:RegisterEffect(e4)
	--
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD)
    e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e5:SetCode(EFFECT_CANNOT_ACTIVATE)
    e5:SetRange(LOCATION_MZONE)
    e5:SetTargetRange(0,1)
	e5:SetCondition(c60159118.immcon3)
    e5:SetValue(c60159118.aclimit)
    c:RegisterEffect(e5)
	--
    local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_IGNITION)
    e6:SetRange(LOCATION_MZONE)
    e6:SetCountLimit(1)
	e6:SetCondition(c60159118.immcon4)
    e6:SetCost(c60159118.thcost)
    e6:SetOperation(c60159118.thop)
    c:RegisterEffect(e6)
end
function c60159118.spfilter(c,sc)
	return c:IsSetCard(0x3b25) and c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsCanBeXyzMaterial(sc)
end
function c60159118.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c60159118.spfilter,tp,LOCATION_MZONE,0,3,nil)
end
function c60159118.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c60159118.spfilter,tp,LOCATION_MZONE,0,3,3,nil)
	local tc=g:GetFirst()
	local sg=Group.CreateGroup()
	while tc do
		sg:Merge(tc:GetOverlayGroup())
		tc=g:GetNext()
	end
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c60159118.spfilter2(c)
	return c:IsSetCard(0x3b25) and c:IsType(TYPE_MONSTER) and c:GetCode()
end
function c60159118.immcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetOverlayGroup():Filter(c60159118.spfilter2,nil)
	return g:GetClassCount(Card.GetCode)>0
end
function c60159118.indval(e,re,tp)
    return tp~=e:GetHandlerPlayer() and re:IsActiveType(TYPE_MONSTER) and aux.TRUE(e,re,rp)
end
function c60159118.immcon2(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetHandler():GetOverlayGroup():Filter(c60159118.spfilter2,nil)
	return g:GetClassCount(Card.GetCode)>1
end
function c60159118.efilter(e,te)
    if te:IsActiveType(TYPE_EFFECT) then return true end
end
function c60159118.immcon3(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetHandler():GetOverlayGroup():Filter(c60159118.spfilter2,nil)
	return g:GetClassCount(Card.GetCode)>2
end
function c60159118.aclimit(e,re,tp)
    local loc=re:GetActivateLocation()
    return (loc==LOCATION_GRAVE or loc==LOCATION_REMOVED) and re:IsActiveType(TYPE_EFFECT) and not re:GetHandler():IsImmuneToEffect(e)
end
function c60159118.immcon4(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetHandler():GetOverlayGroup():Filter(c60159118.spfilter2,nil)
	return g:GetClassCount(Card.GetCode)>3
end
function c60159118.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c60159118.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    --Pos Change
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SET_POSITION)
    e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
    e1:SetTargetRange(0,LOCATION_MZONE)
    e1:SetValue(POS_FACEUP_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
    local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetCode(EFFECT_CANNOT_ACTIVATE)
    e4:SetTargetRange(0,1)
    e4:SetValue(c60159118.aclimit2)
    e4:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e4,tp)
end
function c60159118.distarget(e,c)
    return c~=e:GetHandler() and c:IsType(TYPE_TRAP+TYPE_SPELL)
end
function c60159118.disoperation(e,tp,eg,ep,ev,re,r,rp)
    local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
    if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP+TYPE_SPELL) then
        Duel.NegateEffect(ev)
    end
end
function c60159118.aclimit2(e,re,tp)
    return re:IsActiveType(TYPE_EFFECT) and not re:GetHandler():IsImmuneToEffect(e)
end
