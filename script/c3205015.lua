--¡°ÊéÎÌ¡±
function c3205015.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c3205015.ffilter,4,2)
	c:EnableReviveLimit()
     --to deck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,3205015)
	e1:SetCost(c3205015.spcost)
	e1:SetTarget(c3205015.sptg)
	e1:SetOperation(c3205015.spop)
	c:RegisterEffect(e1)
	--target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3205015,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c3205015.cost)
	e2:SetTarget(c3205015.target)
	e2:SetOperation(c3205015.operation)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e3:SetTarget(c3205015.indtg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	end
	function c3205015.ffilter(c)
	return  c:IsSetCard(0x109e) and not c:IsCode(3205015)
end
	function c3205015.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end     
	Duel.SendtoDeck(c,nil,2,REASON_COST)
end
function c3205015.filter(c,e,tp)
	local lv=c:GetLevel()
	return c:IsSetCard(0x109e) and lv==4 and c:IsCanBeSpecialSummoned(e,105,tp,false,false)
end
function c3205015.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c3205015.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c3205015.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c3205015.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,105,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
	end
end
function c3205015.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c3205015.filter1(c,ec)
	return c:IsSetCard(0x109e) and not c:IsCode(3205015) and not ec:IsHasCardTarget(c)
end
function c3205015.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc~=c and c3205015.filter1(chkc,c) end
	if chk==0 then return Duel.IsExistingTarget(c3205015.filter1,tp,LOCATION_ONFIELD,0,1,c,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c3205015.filter1,tp,LOCATION_ONFIELD,0,1,1,c,c)
end
function c3205015.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		tc:RegisterFlagEffect(3205015,RESET_EVENT+0x1fe0000,0,0)
	end
end
function c3205015.indtg(e,c)
	return e:GetHandler():IsHasCardTarget(c) and c:GetFlagEffect(3205015)~=0
end
	