--照雪
function c101169261.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c101169261.target)
	e1:SetOperation(c101169261.activate)
	c:RegisterEffect(e1)
end
function c101169261.filter(c,e)
	return c:IsSetCard(0xf1) and c:IsCanBeEffectTarget(e) and c:IsFaceup()
end
function c101169261.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsCanBeEffectTarget(e) end
	if chk==0 then return Duel.IsExistingTarget(c101169261.filter,tp,LOCATION_MZONE,0,1,nil,e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and Duel.IsPlayerCanSpecialSummonMonster(tp,101169262,0,0x4011,0,0,2,RACE_FAIRY,ATTRIBUTE_FIRE) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c101169261.filter,tp,LOCATION_MZONE,0,1,1,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c101169261.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			if tc:IsType(TYPE_TRAPMONSTER) then
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_SINGLE)
				e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
				e3:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e3)
			end
			Duel.BreakEffect()
			if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
			if Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and Duel.IsPlayerCanSpecialSummonMonster(tp,101169262,0,0x4011,0,0,2,RACE_FAIRY,ATTRIBUTE_FIRE) then
				for i=1,2 do
					local token=Duel.CreateToken(tp,101169262)
					Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
					local e1=Effect.CreateEffect(c)
					e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
					e1:SetType(EFFECT_TYPE_QUICK_F)
					e1:SetRange(LOCATION_MZONE)
					e1:SetCode(EVENT_BECOME_TARGET)
					e1:SetCondition(c101169261.spcon)
					e1:SetTarget(c101169261.sptg)
					e1:SetOperation(c101169261.spop)
					token:RegisterEffect(e1,true)
				end
				Duel.SpecialSummonComplete()
			end
	end
end
function c101169261.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c101169261.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsCanBeEffectTarget(e) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,101169262,0,0x4011,0,0,2,RACE_FAIRY,ATTRIBUTE_FIRE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c101169261.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,101169262,0,0x4011,0,0,2,RACE_FAIRY,ATTRIBUTE_FIRE) then
					local token=Duel.CreateToken(tp,101169262)
					Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
					e1:SetType(EFFECT_TYPE_QUICK_F)
					e1:SetRange(LOCATION_MZONE)
					e1:SetCode(EVENT_BECOME_TARGET)
					e1:SetCondition(c101169261.spcon)
					e1:SetTarget(c101169261.sptg)
					e1:SetOperation(c101169261.spop)
					token:RegisterEffect(e1,true)
					Duel.SpecialSummonComplete()
	end
end
