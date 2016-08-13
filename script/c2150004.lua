require 'script.c2150000'
function c2150004.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_QUICK_O)
	a:SetCode(EVENT_FREE_CHAIN)
	a:SetRange(LOCATION_MZONE)
	a:SetCountLimit(1,2150004+EFFECT_COUNT_CODE_DUEL)
	a:SetTarget(c2150004.tga)
	a:SetOperation(c2150004.opa)
	a:SetProperty(EFFECT_FLAG_CARD_TARGET)
	c:RegisterEffect(a)
end
function c2150004.tga(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD)and chkc:IsControler(1-tp)end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil)end
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function c2150004.opa(e,tp)
	local t=Duel.GetFirstTarget()
	if not t:IsRelateToEffect(e)then return end
	t:RegisterFlagEffect(2150004,RESET_EVENT+RESET_LEAVE,0,1)
	local c=e:GetHandler()
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_SINGLE)
	a:SetCode(EFFECT_INDESTRUCTABLE)
	a:SetRange(LOCATION_MZONE)
	a:SetValue(function(e)return e:GetLabelObject():GetFlagEffect(2150004)>0 end)
	a:SetReset(RESET_EVENT+RESET_LEAVE)
	a:SetLabelObject(t)
	a:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	c:RegisterEffect(a)
	a:SetCode(EFFECT_IMMUNE_EFFECT)
	c:RegisterEffect(a)
	a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	a:SetCode(EVENT_PHASE+PHASE_END)
	a:SetCountLimit(1)
	a:SetOperation(function(e)
		if e:GetLabelObject():GetFlagEffect(2150004)<1 then return end
		Duel.ChangePosition(Duel.GetMatchingGroup(function(c)return c:GetLocation()==LOCATION_MZONE or c:GetSequence()<6 end,e:GetHandler(),0,LOCATION_ONFIELD,nil),POS_FACEDOWN)
	end)
	a:SetLabelObject(t)
	Duel.RegisterEffect(a,tp)
end
