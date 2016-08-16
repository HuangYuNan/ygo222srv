--傲娇桐乃
function c22163907.initial_effect(c)

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,22163903)
	e1:SetTarget(c22163907.thtg)
	e1:SetOperation(c22163907.thop)
	c:RegisterEffect(e1)
end
function c22163907.filter(c)
	return c:IsSetCard(0x370) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c22163907.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c22163907.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.GetFlagEffect(tp,22163907)==0 end
	local g=Duel.SelectTarget(tp,c22163907.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.RegisterFlagEffect(tp,22163907,0,0,1)
end
function c22163907.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c22163907.efilter)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		--disable spsummon
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
		tc:RegisterEffect(e3)
		local e4=e2:Clone()
		e4:SetCode(EFFECT_CANNOT_SUMMON)
		tc:RegisterEffect(e4)
	end 
end
function c22163907.efilter(e,re)
	return e:GetHandlerPlayer()~=re:GetOwnerPlayer()
end 
