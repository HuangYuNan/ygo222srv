--Prim-Mermaid Girl
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564611.initial_effect(c)
	senya.setreg(c,37564611,37564600)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564611,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(senya.delay)
	e1:SetCondition(c37564611.spcon)
	e1:SetTarget(c37564611.sptg)
	e1:SetOperation(c37564611.spop)
	c:RegisterEffect(e1)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(37564611,1))
	e6:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCountLimit(1,37564611)
	e6:SetCondition(c37564611.thcon)
	e6:SetTarget(c37564611.thtg)
	e6:SetOperation(c37564611.thop)
	c:RegisterEffect(e6)
end
function c37564611.cfilter(c)
	return c:IsFaceup() and c:IsHasEffect(37564600)
end
function c37564611.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c37564611.cfilter,1,nil)
end
function c37564611.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c37564611.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c37564611.lfilter(c)
	return c:IsFaceup() and senya.prsyfilter(c)
end
function c37564611.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and Duel.IsExistingMatchingCard(c37564611.lfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c37564611.thfilter(c)
	return c:IsHasEffect(37564600) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(37564611)
end
function c37564611.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564611.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c37564611.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c37564611.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end