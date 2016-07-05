--Prim-渚之小恶魔Lovely Radio
require "expansions/script/c37564765"
function c37564603.initial_effect(c)
	senya.setreg(c,37564603,37564600)
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.NonTuner(senya.prsyfilter),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c37564603.thcon)
	e1:SetTarget(c37564603.thtg)
	e1:SetOperation(c37564603.thop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return eg:IsExists(c37564603.tfilter,1,e:GetHandler(),tp) end
		local g=eg:Filter(c37564603.tfilter,nil,tp)
		Duel.SetTargetCard(eg)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	end)
	e2:SetOperation(c37564603.op)
	c:RegisterEffect(e2)
end
function c37564603.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c37564603.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c37564603.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c37564603.filter2(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsAbleToRemove() and c:GetSummonPlayer()==1-tp
end
function c37564603.tfilter(c,tp)
	return c:IsAbleToRemove() and c:GetSummonPlayer()==1-tp
end
function c37564603.rfilter(c,e,tp)
	return c:GetFlagEffect(37564603)>0 and (c:IsType(TYPE_RITUAL) or c:IsType(TYPE_SYNCHRO) or c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ)) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c37564603.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():Filter(c37564603.rfilter,nil,e,tp)
	local tc=g:GetFirst()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<g:GetCount() then return end
	Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
end
function c37564603.op(e,tp,eg,ep,ev,re,r,rp)
		local g=eg:Filter(c37564603.filter2,nil,e,tp)
		if g:GetCount()>0 then
			if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 then
				local og=Duel.GetOperatedGroup()
				og:KeepAlive()
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetReset(RESET_PHASE+PHASE_END)
				e1:SetLabelObject(og)
				e1:SetCountLimit(1)
				e1:SetOperation(c37564603.retop)
				Duel.RegisterEffect(e1,tp)
				local tc=og:GetFirst()		
				while tc do
					tc:RegisterFlagEffect(37564603,RESET_EVENT+0x1fe0000,0,1)
					tc=og:GetNext()
				end
			end
		end
end