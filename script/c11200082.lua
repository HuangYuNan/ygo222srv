function c11200082.fqinglanMon(c)
	local t=c:GetCode()
	return t>11200079 and t<11200083
end
function fqinglan(c)
	local t=c:GetCode()
	return t>11200079 and t<11200083
end
function c11200082.fremoveQinglan(c)
	local t=c:GetCode()
	return t>11200079 and t<11200087 and t~=11200083 and c:IsAbleToRemoveAsCost()
end
function c11200082.initial_effect(c)
	aux.AddFusionProcFun2(c,fqinglan,fqinglan,true)
	c:EnableReviveLimit()
	local b=Effect.CreateEffect(c)
	b:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	b:SetCode(EVENT_FREE_CHAIN)
	b:SetRange(LOCATION_EXTRA)
	b:SetCategory(CATEGORY_SPECIAL_SUMMON)
	b:SetTarget(c11200082.tgb)
	b:SetOperation(c11200082.opb)
	b:SetCountLimit(1,11200082)
	c:RegisterEffect(b)
	local a=Effect.CreateEffect(c)
	a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	a:SetCode(EVENT_ATTACK_ANNOUNCE)
	a:SetRange(LOCATION_MZONE)
	a:SetTarget(c11200082.tga)
	a:SetOperation(c11200082.opa)
	c:RegisterEffect(a)
	local e=Effect.CreateEffect(c)
	e:SetType(EFFECT_TYPE_SINGLE)
	e:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e:SetRange(255)
	e:SetValue(true)
	e:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	c:RegisterEffect(e)
	local d=Effect.CreateEffect(c)
	d:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	d:SetCode(EVENT_FREE_CHAIN)
	d:SetRange(LOCATION_GRAVE)
	d:SetCost(c11200082.cod)
	d:SetCountLimit(1,11200087)
	d:SetCategory(CATEGORY_SPECIAL_SUMMON)
	d:SetOperation(c11200082.opd)
	c:RegisterEffect(d)
end
function c11200082.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c11200082.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c11200082.tgb(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetTurnPlayer()~=tp or Duel.GetCurrentPhase()<PHASE_BATTLE_START or Duel.GetCurrentPhase()>PHASE_BATTLE then return false end
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c11200082.filter1,tp,LOCATION_MZONE,0,nil,e)
		local res=c11200082.filter2(e:GetHandler(),e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=c11200082.filter2(e:GetHandler(),e,tp,mg2,mf,chkf)
			end
		end
		return res
	end	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c11200082.opb(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e)then return end
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c11200082.filter1,tp,LOCATION_MZONE,0,nil,e)
	local sg1=Group.FromCards(c11200082.filter2(e:GetHandler(),e,tp,mg1,nil,chkf)and e:GetHandler()or nil)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Group.FromCards(c11200082.filter2(e:GetHandler(),e,tp,mg2,mf,chkf)and e:GetHandler()or nil)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		local tg=Group.FromCards(e:GetHandler())
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
function c11200082.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c11200082.opa(e,tp)
	Duel.NegateAttack()
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)-1100)
end
function c11200082.cod(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then return Duel.IsExistingMatchingCard(c11200082.fremoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,2,e:GetHandler())end
		return Duel.IsExistingMatchingCard(c11200082.fremoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,2,e:GetHandler())and Duel.IsExistingMatchingCard(c11200082.fremoveQinglan,tp,LOCATION_MZONE,0,2,e:GetHandler())
	end
	local c,g
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1
	then g=Duel.SelectMatchingCard(tp,c11200082.fremoveQinglan,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
		c=1
	else g=Group.CreateGroup()
		c=2
	end
	g:Merge(Duel.SelectMatchingCard(tp,c11200082.fremoveQinglan,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,c,c,e:GetHandler()))
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_GRAVE)
end
function c11200082.opd(e,tp)
	if not e:GetHandler():IsRelateToEffect(e)then return end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
end
