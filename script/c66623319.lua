--Idol Heart·永恒的物语
require("/expansions/script/c37564765")
function c66623319.initial_effect(c)
	c:SetUniqueOnField(1,0,66623319)
	senya.setreg(c,66623319,66623399)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c66623319.sptg)
	e1:SetOperation(c66623319.spop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c66623319.target)
	e2:SetOperation(c66623319.activate)
	c:RegisterEffect(e2)
end
function c66623319.filter1(c,e,tp)
	return c:IsHasEffect(66623300) and bit.band(c:GetOriginalType(),0x81)==0x81 and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c66623319.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66623319.filter1,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE)
end
function c66623319.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66623319.filter1,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c66623319.filter(c,tp)
	return c:IsHasEffect(66623300) and c:IsType(TYPE_RITUAL) and c:GetPreviousControler()==tp and c:GetReasonPlayer()==1-tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c66623319.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c66623319.filter,nil,tp)
	local ct=g:GetCount()
	if chk==0 then
		return ct>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>=ct
	end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c66623319.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c66623319.filter,nil,tp)
	local ct=g:GetCount()
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<ct then return end
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
end