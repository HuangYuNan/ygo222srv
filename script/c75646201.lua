--天之痕 藤花之月
function c75646201.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	----special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75646201,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,75646201)
	e2:SetCondition(c75646201.sumcon)
	e2:SetTarget(c75646201.sumtg)
	e2:SetOperation(c75646201.sumop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75646201,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetRange(LOCATION_MZONE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(c75646201.thcon)
	e3:SetTarget(c75646201.thtg)
	e3:SetOperation(c75646201.thop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(75646201,2))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCondition(c75646201.descon)
	e4:SetTarget(c75646201.destg)
	e4:SetOperation(c75646201.desop)
	c:RegisterEffect(e4)
end
function c75646201.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c75646201.filter(c,e,tp)
	return not c:IsCode(75646201) and c:IsSetCard(0x2c2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75646201.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75646201.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,
	LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c75646201.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75646201.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	end
end
function c75646201.thcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x2c2) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsHasCategory(CATEGORY_ATKCHANGE) 
	and Duel.GetTurnPlayer()==tp
end
function c75646201.thfilter(c)
	return c:IsSetCard(0x2c2) and c:IsAbleToHand()
end
function c75646201.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c75646201.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c75646201.thop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=Duel.SelectMatchingCard(tp,c75646201.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c75646201.descon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x2c2) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsHasCategory(CATEGORY_DAMAGE) 
	and Duel.GetTurnPlayer()==tp
end
function c75646201.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c75646201.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end 