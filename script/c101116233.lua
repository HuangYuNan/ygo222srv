--require("script.1011set")
function isFletcher(c)
	return c:GetCode()>101116230 and c:GetCode()<101116237
end
function c101116233.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--specialsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101116233,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c101116233.sptg)
	e2:SetOperation(c101116233.spop)
	c:RegisterEffect(e2)
	--setspell
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetTarget(c101116233.target)
	e3:SetOperation(c101116233.op)
	c:RegisterEffect(e3)
end

function c101116233.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local rpz=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local lpz=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	if not (rpz and lpz) then return false end
	local lscale=lpz:GetLeftScale()
	local rscale=rpz:GetRightScale()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and lscale==rscale end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c101116233.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end



function c101116233.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)
	if chk==0 then return b1
		and Duel.IsExistingMatchingCard(c101116233.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c101116233.filter(c)
	return isFletcher(c) and not c:IsCode(101116233) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c101116233.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local b1=2
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) then b1=b1-1 end
	if not Duel.CheckLocation(tp,LOCATION_SZONE,7) then b1=b1-1 end
	if b1==0 then return end
	if not (c:IsPreviousLocation(LOCATION_SZONE) and (c:GetPreviousSequence()==6 or c:GetPreviousSequence()==7)) then return end
	local g1=Duel.GetMatchingGroup(c101116233.filter,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg1=g1:Select(tp,b1,b1,nil)
	Duel.ShuffleDeck(tp)
	local tc=sg1:GetFirst()
	while tc do
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		if Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
		tc=sg1:GetNext()
	end
end
