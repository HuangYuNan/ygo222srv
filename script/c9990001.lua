--星象竜ドラグアステル
function c9990001.initial_effect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--NTR Card
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTarget(c9990001.target)
	e1:SetOperation(c9990001.operation)
	c:RegisterEffect(e1)
end
function c9990001.filter(c,tp)
	if c:IsLocation(LOCATION_SZONE) then
		if c:IsControler(tp) and c:GetSequence()>5 then return false end
	end
	return c:IsFaceup() and bit.band(c:GetOriginalType(),TYPE_PENDULUM)~=0 and (c:GetControler()==tp or c:IsAbleToChangeControler())
end
function c9990001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c9990001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c9990001.filter,tp,LOCATION_MZONE,LOCATION_ONFIELD,1,nil,tp)
		and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(9990001,0))
	local g=Duel.SelectTarget(tp,c9990001.filter,tp,LOCATION_MZONE,LOCATION_ONFIELD,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
	if g:GetFirst():GetControler()==1-tp then
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	end
end
function c9990001.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e)
		and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then
		if tc:IsLocation(LOCATION_SZONE) then Duel.Overlay(c,tc) end
		if Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e1=e1:Clone()
			e1:SetCode(EFFECT_DISABLE_EFFECT)
			tc:RegisterEffect(e1)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_CHANGE_LSCALE)
			e3:SetValue(8)
			tc:RegisterEffect(e3)
			local e4=e3:Clone()
			e4:SetCode(EFFECT_CHANGE_RSCALE)
			tc:RegisterEffect(e4)
		end
	end
end