--封解主 星宮六喰
function c18706070.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0xabb),1)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetDescription(aux.Stringid(18706070,0))
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c18706070.sprcon)
	e2:SetOperation(c18706070.sprop)
	c:RegisterEffect(e2)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c18706070.sumsuc)
	c:RegisterEffect(e3)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52687916,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c18706070.con)
	e1:SetTarget(c18706070.target)
	e1:SetOperation(c18706070.operation)
	c:RegisterEffect(e1)
end
function c18706070.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetSummonType()~=SUMMON_TYPE_SYNCHRO then return end
	Duel.SetChainLimitTillChainEnd(c18706070.chlimit)
end
function c18706070.chlimit(e,ep,tp)
	return tp==ep 
end
function c18706070.sprfilter(c,tp)
	return  c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsReleasable()
		and c:GetLevel()==3
end
function c18706070.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c18706070.sprfilter,tp,LOCATION_MZONE,0,2,nil,tp)
end
function c18706070.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c18706070.sprfilter,tp,LOCATION_MZONE,0,2,2,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c18706070.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c18706070.filter(c)
	return c:IsFacedown() and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP) )
end
function c18706070.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsFacedown() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c18706070.filter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,c18706070.filter,tp,0,LOCATION_SZONE,1,2,nil)
end
function c18706070.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	while tc do
		if c:IsRelateToEffect(e) and tc:IsFacedown() and tc:IsRelateToEffect(e) then
			c:SetCardTarget(tc)
			e:SetLabelObject(tc)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_TRIGGER)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetCondition(c18706070.rcon)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
function c18706070.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end