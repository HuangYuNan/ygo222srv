local m=66600616
local cm=_G["c"..m]
if not pcall(function() require("expansions/script/c66600601") end) then require("script/c66600601") end
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	--① 
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,66600616)
	e1:SetCost(c66600616.cost)
	e1:SetTarget(c66600616.target)
	e1:SetOperation(c66600616.activate)
	c:RegisterEffect(e1)
end
function c66600616.filter1(c,e,tp)
	return c:IsFaceup() and c:IsHasEffect(66600600) and Duel.IsExistingMatchingCard(c66600616.filter,tp,LOCATION_DECK,0,1,nil,e,tp,c)
end
function c85821180.filter2(c,e,tp,dc)
	return c:IsRace(dc:GetRace()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsHasEffect(66600600) and c:GetLevel()==3
end
function c66600616.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c66600616.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66600616.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c66600616.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g:GetFirst())
end
function c66600616.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66600616.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,e:GetLabelObject())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end