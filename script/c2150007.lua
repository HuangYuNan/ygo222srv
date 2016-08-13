if not pcall(function() require("expansions/script/c2150000") end) then require("script/c2150000") end
function c2150007.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	a:SetCode(EVENT_PHASE+PHASE_END)
	a:SetRange(LOCATION_MZONE)
	a:SetProperty(EFFECT_FLAG_CARD_TARGET)
	a:SetCategory(CATEGORY_DESTROY)
	a:SetCountLimit(1)
	a:SetTarget(c2150007.tga)
	a:SetOperation(c2150007.opa)
	c:RegisterEffect(a)
	c2150007[0]=0
	c2150007[1]=0
end
function c2150007.tga(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD)end
	if chk==0 then return Duel.IsExistingTarget(nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)end
	local t=Duel.SelectTarget(tp,nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,t,1,0,0)
end
function c2150007.opa(e,tp)
	local t=Duel.GetFirstTarget()
	if not t:IsRelateToEffect(e)then return end
	Duel.Destroy(t,REASON_EFFECT)
	if c2150007[tp]==0 then c2150007[tp]=1 else c2150007[tp]=0 Duel.Draw(tp,1,REASON_EFFECT)end
end
