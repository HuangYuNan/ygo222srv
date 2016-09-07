--天界の魔除け
if not pcall(function() require("expansions/script/c9990000") end) then require("script/c9990000") end
function c9991032.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c9991032.target)
	e1:SetOperation(c9991032.operation)
	c:RegisterEffect(e1)
end
function c9991032.filter(c,e,tp)
	if not (c:IsFaceup() and Dazz.IsStellaris(c,nil,"Archangel")) then return false end
	if c:IsAbleToGrave() then
		if Duel.IsPlayerCanDraw(tp,2) then return true end
		if Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) then return true end
	end
	return Duel.IsExistingMatchingCard(c9991032.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c9991032.spfilter(c,e,tp,mc)
	return Dazz.IsStellaris(c,nil,"Gardevoir") and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and mc:IsCanBeXyzMaterial(c)
end
function c9991032.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp)
		and c:IsFaceup() and Dazz.IsStellaris(c,nil,"Archangel") end
	if chk==0 then return Duel.IsExistingTarget(c9991032.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c9991032.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
end
function c9991032.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local v={
			tc:IsAbleToGrave() and Duel.IsPlayerCanDraw(tp,2),
			tc:IsAbleToGrave() and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,tc),
			tc:IsControler(tp) and tc:IsFaceup() and Duel.IsExistingMatchingCard(c9991032.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,tc),
		}
		if not v[1] and not v[2] and not v[3] then return end
		local selt={tp}
		local keyt={}
		for i=1,3 do
			if v[i] then
				table.insert(selt,aux.Stringid(9991032,i-1))
				table.insert(keyt,i)
			end
		end
		local sel=keyt[Duel.SelectOption(table.unpack(selt))+1]
		if tc:IsImmuneToEffect(e) then return end
		if sel~=3 and Duel.SendtoGrave(tc,REASON_EFFECT)==0 then return end
		if sel==1 then
			Duel.Draw(tp,2,REASON_EFFECT)
		elseif sel==2 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,2,nil)
			Duel.HintSelection(g)
			Duel.Destroy(g)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c9991032.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
			local sc=g:GetFirst()
			local mg=tc:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(sc,mg)
			end
			sc:SetMaterial(Group.FromCards(tc))
			Duel.Overlay(sc,Group.FromCards(tc))
			Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(1,0)
			e1:SetTarget(aux.TRUE)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
