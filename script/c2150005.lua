require 'expansions.script.c2150000'
function c2150005.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	a:SetCode(EVENT_PHASE+PHASE_END)
	a:SetRange(LOCATION_GRAVE)
	a:SetCountLimit(1)
	a:SetTarget(c2150005.tga)
	a:SetOperation(c2150005.opa)
	a:SetCategory(CATEGORY_SPECIAL_SUMMON)
	c:RegisterEffect(a)
end
function c2150005.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetTurnID()==Duel.GetTurnCount()and Duel.IsExistingMatchingCard(BiDiuF,tp,LOCATION_DECK,0,1,nil)and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_GRAVE)
end
function BiDiuNo5(c)return BiDiuF(c)and c:GetCode()~=2150005 end
function c2150005.opa(e)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e)then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	Duel.SendtoGrave(Duel.SelectMatchingCard(tp,BiDiuNo5,tp,LOCATION_DECK,0,1,1,nil),REASON_EFFECT)
end
