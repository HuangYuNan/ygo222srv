local m=66600617
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c66600601") end) then require("script/c66600601") end
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20366274,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,66617)
	e1:SetTarget(c66600617.target)
	e1:SetOperation(c66600617.activate)
	c:RegisterEffect(e1)
end
function c66600617.filter1(c)
	return c:IsFaceup() and c:IsHasEffect(66600600) and c:IsType(TYPE_MONSTER)
end
function c66600617.filter2(c,e,tp)
	return c:IsHasEffect(66600600) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c66600617.filter3(c,e,tp)
	return c:IsHasEffect(66600600) and c:GetRank()==7 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c66600617.filter4(c,e,tp)
	return c:IsHasEffect(66600600) and c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,CATEGORY_SPECIAL_SUMMON,tp,false,false)
end
function c66600617.filter5(c,e,tp)
	return c:IsHasEffect(66600600) and c:GetRank()==3 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c66600617.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c66600617.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c66600617.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c66600617.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c66600617.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c66600617.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if (tc:IsType(TYPE_XYZ) and tc:GetRank()==3) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66600617.filter3,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
	Duel.BreakEffect()
	sc:SetMaterial(Group.FromCards(tc))
	Duel.Overlay(sc,Group.FromCards(tc))
	Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
	sc:CompleteProcedure()
	end
	elseif (tc:IsType(TYPE_XYZ) and tc:GetRank()==7) then
	if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66600617.filter4,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		end
	end
	elseif tc:IsType(TYPE_SYNCHRO) then
	local g=Duel.SelectMatchingCard(tp,c66600617.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
	Duel.BreakEffect()
	sc:SetMaterial(Group.FromCards(tc))
	Duel.Overlay(sc,Group.FromCards(tc))
	Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
	sc:CompleteProcedure()
	if c:IsRelateToEffect(e) then
	   c:CancelToGrave()
	   Duel.Overlay(sc,Group.FromCards(c))
	   end
	end
	else
	local g=Duel.SelectMatchingCard(tp,c66600617.filter5,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
	Duel.BreakEffect()
	sc:SetMaterial(Group.FromCards(tc))
	Duel.Overlay(sc,Group.FromCards(tc))
	Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
	sc:CompleteProcedure()
	end
	end
end