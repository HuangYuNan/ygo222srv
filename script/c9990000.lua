Dazz=Dazz or {}

function Dazz.StellarisPendulumEffect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	c:RegisterEffect(e1)
	--Special Pendulum
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(9991000)
	e2:SetCondition(function(e)
		local c=e:GetHandler()
		return c:GetSequence()>5 and c:IsLocation(LOCATION_SZONE)
	end)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC_G)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,10000000)
	e3:SetCondition(Dazz.StellarisPendulumCondition)
	e3:SetOperation(Dazz.StellarisPendulumOperation)
	e3:SetValue(SUMMON_TYPE_PENDULUM)
	c:RegisterEffect(e3)
	--Recover
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
		Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	end)
	e4:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1000)
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
	end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Recover(p,d,REASON_EFFECT)
	end)
	c:RegisterEffect(e4)
	--Pendulum Set
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local fil=function(c) return c:GetLevel()==4 and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToRemoveAsCost() end
		if chk==0 then return Duel.IsExistingMatchingCard(fil,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,fil,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	end)
	e5:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
	end)
	e5:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if e:GetHandler():IsRelateToEffect(e)
			and (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then
			Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end)
	c:RegisterEffect(e5)
end
function Dazz.StellarisPendulumFilter(c,e,tp,lscale,rscale)
	if not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_PENDULUM,tp,false,false) or c:IsForbidden() then return false end
	local lv=0
	if c.pendulum_level then
		lv=c.pendulum_level
	else
		lv=c:GetLevel()
	end
	if lv<=lscale or lv>=rscale then return false end
	if c:IsLocation(LOCATION_HAND) then return true end
	if c:IsLocation(LOCATION_EXTRA) and not (c:IsFaceup() and c:IsType(TYPE_PENDULUM)) then return false end
	if not Dazz.IsStellaris(c,nil,"Warrior") then return false end
	local c1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local c2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	return c1 and c2 and (Dazz.IsStellaris(c1,nil,"Warrior") and c2:IsHasEffect(9991000)
		or c1:IsHasEffect(9991000) and Dazz.IsStellaris(c2,nil,"Warrior"))
end
function Dazz.StellarisPendulumCondition(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	if c:GetSequence()~=6 then return false end
	local rpz=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	if rpz==nil then return false end
	local lscale=c:GetLeftScale()
	local rscale=rpz:GetRightScale()
	if lscale>rscale then lscale,rscale=rscale,lscale end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return false end
	if og then
		return og:IsExists(Dazz.StellarisPendulumFilter,1,nil,e,tp,lscale,rscale)
	else
		return Duel.IsExistingMatchingCard(Dazz.StellarisPendulumFilter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp,lscale,rscale)
	end
end
function Dazz.StellarisPendulumOperation(e,tp,eg,ep,ev,re,r,rp,c,sg,og)
	local rpz=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	local lscale=c:GetLeftScale()
	local rscale=rpz:GetRightScale()
	if lscale>rscale then lscale,rscale=rscale,lscale end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local tg=nil
	if og then
		tg=og:Filter(tp,Dazz.StellarisPendulumFilter,nil,e,tp,lscale,rscale)
	else
		tg=Duel.GetMatchingGroup(Dazz.StellarisPendulumFilter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA,0,nil,e,tp,lscale,rscale)
	end
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if ect and (ect<=0 or ect>ft) then ect=nil end
	if ect==nil or tg:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA)<=ect then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=tg:Select(tp,1,ft,nil)
		sg:Merge(g)
	else
		repeat
			local ct=math.min(ft,ect)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=tg:Select(tp,1,ct,nil)
			tg:Sub(g)
			sg:Merge(g)
			ft=ft-g:GetCount()
			ect=ect-g:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA)
		until ft==0 or ect==0 or not Duel.SelectYesNo(tp,210)
		local hg=tg:Filter(Card.IsLocation,nil,LOCATION_HAND+LOCATION_GRAVE)
		if ft>0 and ect==0 and hg:GetCount()>0 and Duel.SelectYesNo(tp,210) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=hg:Select(tp,1,ft,nil)
			sg:Merge(g)
		end
	end
	Duel.HintSelection(Group.FromCards(c))
	Duel.HintSelection(Group.FromCards(rpz))
end

--Simulated Setcodes
function Dazz.SimulatedSetCodeCore(c,f,v,func,...)
	local cf=f
	if type(cf)~="function" then cf=Card.GetCode end
	local t={cf(c)}
	for i,code in pairs(t) do
		for i,code2 in ipairs{...} do
			if code==code2 then return true end
		end
		local m=_G["c"..code]
		if m then
			local val=func(m)
			if val and (not v or val==v) then return true end
		end
	end
	return false
end
function Dazz.IsStellaris(c,f,v)
	return Dazz.SimulatedSetCodeCore(c,f,v,function(m) return m.Dazz_name_stellaris end)
end