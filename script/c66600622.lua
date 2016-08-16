local m=66600622
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c66600601") end) then require("script/c66600601") end
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74822425,0))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCountLimit(1,66600622)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c66600622.condition)
	e3:SetTarget(c66600622.target)
	e3:SetOperation(c66600622.activate)
	c:RegisterEffect(e3)
end
function c66600622.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c66600622.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end   
end
function c66600622.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local tc=Duel.GetFirstTarget()
	local dc=re:GetHandler()
	if dc:IsRelateToEffect(re) and Duel.Destroy(dc,REASON_EFFECT)>0 and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local sid=aux.Stringid(m,0)
		local s=Duel.SelectOption(tp,sid,sid+1,sid+2)
		if s==2 then
			local atk=dc:GetAttack()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(atk)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e2)
		else
			local rc=dc:GetRace()*0x1000
			local at=dc:GetAttribute()*0x10
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_IMMUNE_EFFECT)
			if Duel.GetTurnPlayer()==tp then
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
			else
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
			end
			e1:SetLabel(rc+at+s)
			e1:SetValue(c66600622.efilter)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e2:SetValue(c66600622.bfilter)
			tc:RegisterEffect(e2)
		end
	end
end
function c66600622.efilter(e,te)
	return te:GetOwner()~=e:GetOwner() and te:IsActiveType(TYPE_MONSTER) and te:GetHandlerPlayer()~=e:GetHandlerPlayer() and c66600622.bfilter(e,te:GetHandler())
end
function c66600622.bfilter(e,c)
	local v=e:GetLabel()
	local s=bit.band(v,0xf)
	local at=bit.band(v,0xff0)/0x10
	local rc=bit.band(v,RACE_ALL*0x1000)/0x1000
	return (s==0 and c:IsAttribute(at)) or (s==1 and c:IsRace(rc))
end