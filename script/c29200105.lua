--凋叶棕-为了hakanakihito们
function c29200105.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,29200105+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c29200105.condition)
	e1:SetTarget(c29200105.target)
	e1:SetOperation(c29200105.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c29200105.thcon)
	e2:SetTarget(c29200105.thtg)
	e2:SetOperation(c29200105.thop)
	c:RegisterEffect(e2)
end
function c29200105.filter8(c)
	return c:IsFaceup() and c:IsSetCard(0x53e0)
end
function c29200105.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c29200105.filter8,tp,LOCATION_REMOVED,0,5,nil)
end
function c29200105.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c29200105.filter8(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c29200105.filter8,tp,LOCATION_REMOVED,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(29200105,0))
	local g=Duel.SelectTarget(tp,c29200105.filter8,tp,LOCATION_REMOVED,0,3,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,3,0,0)
end
function c29200105.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
	end
end
function c29200105.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_DECK) 
	and re:GetHandler():IsSetCard(0x53e0) and bit.band(r,REASON_EFFECT)~=0
end
function c29200105.filter(c,e,tp)
	return c:IsSetCard(0x53e0) and c:IsType(TYPE_SPELL+TYPE_TRAP)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),0x53e0,0x11,7,2500,2000,0x4,0x10)
end
function c29200105.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c29200105.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c29200105.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c29200105.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if g:GetCount()>0 then
		if Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0x53e0,0x11,7,2500,2000,0x4,0x10) then
			--[[tc:AddMonsterAttribute(TYPE_NORMAL,ATTRIBUTE_EARTH,RACE_FAIRY,4,0,2200)
			tc:AddMonsterAttributeComplete()
			Duel.SpecialSummonComplete()]]
			Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(2500)
			--e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetReset(RESET_EVENT+0x47c0000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_BASE_DEFENSE)
			e2:SetValue(2000)
			tc:RegisterEffect(e2)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_CHANGE_LEVEL)
			e3:SetValue(7)
			tc:RegisterEffect(e3)
			local e4=e1:Clone()
			e4:SetCode(EFFECT_CHANGE_RACE)
			e4:SetValue(0x4)
			tc:RegisterEffect(e4)
			local e5=e1:Clone()
			e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			e5:SetValue(0x10)
			tc:RegisterEffect(e5)
			local e6=e1:Clone()
			e6:SetCode(EFFECT_CHANGE_TYPE)
			e6:SetValue(0x11)
			tc:RegisterEffect(e6)
			local e7=Effect.CreateEffect(e:GetHandler())
			e7:SetType(EFFECT_TYPE_SINGLE)
			e7:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e7:SetValue(1)
			e7:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e7)
			local e8=e7:Clone()
			e8:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			tc:RegisterEffect(e8)
			Duel.SpecialSummonComplete()
		end
	end
end



