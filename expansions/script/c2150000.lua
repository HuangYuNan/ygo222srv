function BiDiu(c)
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_HAND)
	b:SetCategory(CATEGORY_SPECIAL_SUMMON)
	b:SetCost(BiDiuCob)
	b:SetOperation(BiDiuOpb)
	c:RegisterEffect(b)
	local a=Effect.CreateEffect(c)
	return a
end
function BiDiuF(c)local n=c:GetCode()return n>2149999 and n<2150015 end
function BiDiuUp(c)return BiDiuF(c)and c:IsFaceup()end
function BiDiuSs(c,e,tp)return BiDiuF(c)and c:IsCanBeSpecialSummoned(e,0,tp,false,false)end
function BiDiuCob(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost()and Duel.IsExistingMatchingCard(BiDiuF,tp,LOCATION_MZONE,0,1,nil)and Duel.IsExistingMatchingCard(BiDiuSs,tp,LOCATION_DECK,0,1,nil,e,tp)end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function BiDiuOpb(e,tp)
	local c=Duel.SelectMatchingCard(tp,BiDiuF,tp,LOCATION_MZONE,0,1,1,nil)
	if not c then return end
	local p=c:GetFirst():GetPosition()
	if Duel.SendtoDeck(c,nil,2,REASON_EFFECT)<1 then return end
	Duel.SpecialSummon(Duel.SelectMatchingCard(tp,BiDiuSs,tp,LOCATION_DECK,0,1,1,nil,e,tp),0,tp,tp,false,false,p)
end
if not c2150000 then return end
function c2150000.initial_effect(c)
	local a=BiDiu(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	a:SetCode(EVENT_ADJUST)
	a:SetRange(LOCATION_MZONE)
	a:SetCondition(c2150000.cna)
	a:SetOperation(c2150000.opa)
	c:RegisterEffect(a)
end
function c2150000.cna(e)return Duel.IsExistingMatchingCard(c2150000.fa,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),e)end
function c2150000.opa(e)
	local g=Duel.GetMatchingGroup(c2150000.fa,0,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler(),e)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE)
	local c=g:GetFirst()
	local e=Effect.CreateEffect(e:GetHandler())
	e:SetType(EFFECT_TYPE_SINGLE)
	e:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e:SetValue(0)
	e:SetReset(RESET_PHASE+PHASE_END+RESET_EVENT+RESET_LEAVE+RESET_TURN_SET,2)
	while c do
		c:RegisterEffect(e)
		e=e:Clone()
		c=g:GetNext()
	end
end
function c2150000.fa(c,e)return c:IsPosition(POS_ATTACK)and not c:IsImmuneToEffect(e)end
