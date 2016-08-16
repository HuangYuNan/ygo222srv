--Nanahira & 3L
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564519.initial_effect(c)
	senya.nnhr(c)
	senya.neg(c,1,37560519,senya.setdcost,senya.nncon(true),nil,LOCATION_ONFIELD+LOCATION_GRAVE,false)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_HAND)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCode(EVENT_BECOME_TARGET)
	e4:SetCountLimit(1,37561519)
	e4:SetCondition(c37564519.discon)
	e4:SetTarget(c37564519.distg)
	e4:SetOperation(c37564519.disop)
	c:RegisterEffect(e4)
end
function c37564519.discon(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then return end
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg then return false end
	return Duel.IsChainNegatable(ev) and tg:IsExists(c37564519.f,1,nil,tp)
end
function c37564519.f(c,tp)
	return c:IsCode(37564765) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsFaceup()
end
function c37564519.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c37564519.disop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(re:GetHandler(),REASON_EFFECT)
		end
	end 
end