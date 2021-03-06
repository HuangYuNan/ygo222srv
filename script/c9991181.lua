--Warping Wail
require "expansions/script/c9990000"
function c9991181.initial_effect(c)
	--Counter Spell Card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local g=Duel.GetFieldGroup(tp,0,LOCATION_REMOVED)
		if chk==0 then return g:GetCount()>0 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=g:Select(tp,1,1,nil)
		Duel.HintSelection(g)
		Duel.SendtoGrave(g,REASON_COST+REASON_RETURN)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local ex,eg2,ep2,ev2,re2,r2,rp2=Duel.CheckEvent(EVENT_CHAINING,true)
		local v1,v2,v3=
			Duel.IsExistingMatchingCard(c9991181.exilefilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil),
			ex and ep2~=tp and re2:IsActiveType(TYPE_SPELL) and re2:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev2),
			Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Dazz.IsCanCreateEldraziScion(tp)
		if chk==0 then return v1 or v2 or v3 end
		local sel=0
		if v1 and not v2 and not v3 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,0))+1
		elseif v2 and not v1 and not v3 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,1))+2
		elseif v3 and not v1 and not v2 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,2))+3
		elseif v1 and v2 and not v3 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,0),aux.Stringid(9991181,1))+1
		elseif v2 and v3 and not v1 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,1),aux.Stringid(9991181,2))+2
		elseif v1 and v3 and not v2 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,0),aux.Stringid(9991181,2))+1
			if sel==2 then sel=3 end
		elseif v1 and v2 and v3 then
			sel=Duel.SelectOption(tp,aux.Stringid(9991181,0),aux.Stringid(9991181,1),aux.Stringid(9991181,2))+1
		end
		e:SetLabel(sel)
		e:GetHandler():RegisterFlagEffect(9991181,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(9991181,sel-1))
		if sel==1 then
			e:SetCategory(CATEGORY_REMOVE)
			local sg=Duel.GetMatchingGroup(c9991181.exilefilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
			Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
		elseif sel==2 then
			e:SetCategory(CATEGORY_NEGATE)
			Duel.SetTargetParam(ev2)
			Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
		elseif sel==3 then
			e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
			Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
			Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
		end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sel=e:GetLabel()
		if sel==1 then
			local sg=Duel.GetMatchingGroup(c9991181.exilefilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			sg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		elseif sel==2 then
			local ev2=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
			Duel.NegateActivation(ev2)
		elseif sel==3 then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
			if not Dazz.IsCanCreateEldraziScion(tp) then return end
			local token=Dazz.CreateEldraziScion(e,tp)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		end
	end)
	c:RegisterEffect(e1)
end
function c9991181.exilefilter(c)
	return c:IsFacedown() or c:IsAttackBelow(500) or c:IsDefenseBelow(500)
end