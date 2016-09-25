--空明-未寅爱爱爱
function c101169161.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101169161,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c101169161.target)
	e1:SetOperation(c101169161.operation)
	c:RegisterEffect(e1)
end
function c101169161.filter(c)
	return c:IsFaceup()
end
function c101169161.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c101169161.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c101169161.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c101169161.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c101169161.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e3:SetValue(tc:GetBaseDefense())
		tc:RegisterEffect(e3)
		local fid=c:GetFieldID()
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetLabel(fid)
		e2:SetCondition(c101169161.rmcon)
		e2:SetOperation(c101169161.rmop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c101169161.rmfilter(c,fid)
	return c:GetFlagEffectLabel(101169161)==fid
end
function c101169161.dfilter(c,g)
	return g:IsContains(c)
end
function c101169161.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget()
	return eg:FilterCount(c101169161.dfilter,nil,g)>0
		and not Duel.IsExistingMatchingCard(c101169161.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,g)
end
function c101169161.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local dg=g:Filter(c101169161.rmfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.Destroy(dg,REASON_EFFECT)
end