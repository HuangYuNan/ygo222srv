--空明-御前
function c101169263.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xf1),aux.NonTuner(nil),1)
	--p summon
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_SPSUMMON_PROC)
	e10:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e10:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e10:SetRange(LOCATION_PZONE)
	e10:SetCondition(c101169263.pcondition)
	e10:SetTarget(c101169263.ptarget)
	e10:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e10)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--spsummon(p)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101169263,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c101169263.sptg)
	e1:SetOperation(c101169263.spop)
	c:RegisterEffect(e1)
	--catch
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101169263,2))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetCondition(c101169263.catchcon)
	e2:SetOperation(c101169263.catch)
	c:RegisterEffect(e2)
	--release
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101169263,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_RELEASE)
	e3:SetTarget(c101169263.pentg)
	e3:SetOperation(c101169263.penop)
	c:RegisterEffect(e3)
	--antiactivate
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCode(EFFECT_CANNOT_ACTIVATE)
	e22:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e22:SetTargetRange(0,1)
	e22:SetValue(c101169263.aclimit)
	c:RegisterEffect(e22)
end
function c101169263.tunerfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0xf1) and Duel.IsExistingMatchingCard(c101169263.nontunerfilter,tp,LOCATION_DECK,0,1,nil,10-c:GetLevel()) and c:IsAbleToGrave()
end
function c101169263.nontunerfilter(c,lv)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and c:GetLevel()==lv and c:IsAbleToGrave()
end
function c101169263.pcondition(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		return Duel.IsExistingMatchingCard(c101169263.tunerfilter,tp,LOCATION_DECK,0,1,nil) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c101169263.ptarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c101169263.tunerfilter,tp,LOCATION_DECK,0,1,nil) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	local c=e:GetHandler()
	local mg=Duel.SelectMatchingCard(tp,c101169263.tunerfilter,tp,LOCATION_DECK,0,1,1,nil)
	local ma=Duel.SelectMatchingCard(tp,c101169263.nontunerfilter,tp,LOCATION_DECK,0,1,1,nil,10-mg:GetFirst():GetLevel())
	mg:Merge(ma)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	Duel.SendtoGrave(mg,REASON_EFFECT)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
--------------------
function c101169263.cfilter(c)
	return c:IsRace(RACE_SPELLCASTER)
end
function c101169263.catchcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(101169263)==0
end
function c101169263.eqlimit(e,c)
	return e:GetOwner()==c
end
function c101169263.catch(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=eg:Filter(c101169263.cfilter,nil)
	local tc=ct:GetFirst()
	while tc do
		if not Duel.Equip(tp,tc,e:GetHandler(),false) then 
		return end
		tc:RegisterFlagEffect(101169263,RESET_EVENT+0x1fe0000,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c101169263.eqlimit)
		tc:RegisterEffect(e1)
		--tohand
		local e4=Effect.CreateEffect(c)
		e4:SetDescription(aux.Stringid(101169263,3))
		e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e4:SetCategory(CATEGORY_TOHAND)
		e4:SetCode(EVENT_TO_GRAVE)
		e4:SetCondition(c101169263.retcon)
		e4:SetTarget(c101169263.rettg)
		e4:SetOperation(c101169263.retop)
		tc:RegisterEffect(e4)
		tc=ct:GetNext()
	end
	return
end
-----------------------
function c101169263.retcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	return c:IsReason(REASON_LOST_TARGET) and ec and c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c101169263.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c101169263.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-c:GetControler(),c)
	end
end
-------------------------
function getlvrank(c)
	if not c:IsType(TYPE_MONSTER) then return 1000 end
	if c:IsType(TYPE_XYZ) then return c:GetRank()
	else return c:GetLevel() end
end

function c101169263.aclimit(e,re,tp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	local tc=g:GetFirst()
	local i=0
	while tc do
		if tc:GetFlagEffect(101169263)~=0 and tc:GetEquipTarget()==e:GetHandler() then
			i=i+1
		end
		tc=g:GetNext()
	end
	return re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsImmuneToEffect(e) and getlvrank(re:GetHandler())<=i*3
end
----------------
function c101169263.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c101169263.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
--------------
function c101169263.spfilter(c,e,tp)
	return c:IsSetCard(0xf1) and c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c101169263.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c83190280.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c101169263.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c101169263.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c101169263.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
	end
	Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	Duel.SendtoDeck(c,tp,0,REASON_EFFECT)
end
