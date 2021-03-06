--聖なる天秤（セイクリッド・スケール）
function c9990807.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local v1,v2=bit.band(Duel.GetCurrentPhase(),PHASE_END)~=0,c9990807.condition(e,tp)
		if chk==0 then return c9990807.target(e,tp,nil,nil,nil,nil,nil,nil,0) and (v1 or v2) end
		if v1 or (v2 and Duel.SelectYesNo(tp,94)) then
			c9990807.target(e,tp,nil,nil,nil,nil,nil,nil,1)
			Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(9990807,0))
			e:GetHandler():RegisterFlagEffect(9990807,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9990807,0))
		end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if e:GetHandler():GetFlagEffect(9990807)~=0 then
			c9990807.operation(e,tp)
		end
	end)
	c:RegisterEffect(e1)
	--Forced
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c9990807.target)
	e2:SetOperation(c9990807.operation)
	c:RegisterEffect(e2)
	--Objetive
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCondition(c9990807.condition)
	c:RegisterEffect(e3)
end
function c9990807.condition(e,tp)
	local g1,g2=Duel.GetFieldGroup(tp,LOCATION_MZONE,0),Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	return g1:GetCount()~=g2:GetCount() and bit.band(Duel.GetCurrentPhase(),PHASE_END)==0
end
function c9990807.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,9990807)==0 end
	Duel.RegisterFlagEffect(tp,9990807,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c9990807.operation(e,tp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1,g2=Duel.GetFieldGroup(tp,LOCATION_MZONE,0),Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local sg=nil
	if g1:GetCount()==g2:GetCount() then
		return
	elseif g1:GetCount()>g2:GetCount() then
		sg=g1:RandomSelect(tp,1)
	elseif g1:GetCount()<g2:GetCount() then
		sg=g2:RandomSelect(tp,1)
	end
	Duel.SendtoGrave(sg,REASON_RULE)
end