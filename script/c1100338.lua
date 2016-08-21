--青鸟千羽·神尾观铃
function c1100338.initial_effect(c)
	c:EnableReviveLimit()
	c:SetSPSummonOnce(1100338)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1) 
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1100338,0))
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetTarget(c1100338.atktg)
	e1:SetOperation(c1100338.atkop)
	c:RegisterEffect(e1)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(1100338,1))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,1100338)
	e4:SetTarget(c1100338.distg)
	e4:SetOperation(c1100338.disop)
	c:RegisterEffect(e4)
	--synchro level
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e3:SetTarget(c1100338.syntg)
	e3:SetValue(1)
	e3:SetOperation(c1100338.synop)
	c:RegisterEffect(e3)
	--ritual material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e3:SetValue(c1100338.mtval)
	c:RegisterEffect(e3) 
end
function c1100338.mtval(e,c)
	return c:IsSetCard(0x5243)
end
function c1100338.filter1(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c1100338.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c1100338.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1100338.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c1100338.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c1100338.filter2(c)
	return c:IsRace(RACE_FAIRY)
end
function c1100338.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=Duel.GetMatchingGroupCount(c1100338.filter2,tp,LOCATION_MZONE,0,nil)
	if ct>0 and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end

function c1100338.cardiansynlevel(c)
	return 3
end
function c1100338.synfilter(c,syncard,tuner,f)
	return c:IsFaceup() and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard,tuner) and (f==nil or f(c))
end
function c1100338.syntg(e,syncard,f,minc,maxc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	local lv2=syncard:GetLevel()-c1100338.cardiansynlevel(c)
	if lv<=0 and lv2<=0 then return false end
	local g=Duel.GetMatchingGroup(c1100338.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
	local res=g:CheckWithSumEqual(Card.GetSynchroLevel,lv,minc,maxc,syncard)
	local res2=g:CheckWithSumEqual(c1100338.cardiansynlevel,lv2,minc,maxc)
	return res or res2
end
function c1100338.synop(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc,maxc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	local lv2=syncard:GetLevel()-c1100338.cardiansynlevel(c)
	local g=Duel.GetMatchingGroup(c1100338.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
	local res=g:CheckWithSumEqual(Card.GetSynchroLevel,lv,minc,maxc,syncard)
	local res2=g:CheckWithSumEqual(c1100338.cardiansynlevel,lv2,minc,maxc)
	local sg=nil
	if (res2 and res and Duel.SelectYesNo(tp,aux.Stringid(1100338,2)))
		or (res2 and not res) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		sg=g:SelectWithSumEqual(tp,c1100338.cardiansynlevel,lv2,minc,maxc)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		sg=g:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv,minc,maxc,syncard)
	end
	Duel.SetSynchroMaterial(sg)
end
function c1100338.disfilter(c)
	return aux.disfilter1(c) and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0
end
function c1100338.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1100338.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1100338.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c1100338.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c1100338.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end