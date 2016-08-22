--card parts
local cm=c66600601
local m=66600601
if cm and not cm.chk then
cm.chk=true
function cm.initial_effect(c)
	sixth.setreg(c,m,66600600)
	sixth.tgeff(c,nil,nil,cm.sptg,cm.spop,1,nil,nil,CATEGORY_SPECIAL_SUMMON,nil)
	sixth.bm(c)
end
function cm.filter(c,e,tp)
	return c:IsHasEffect(66600600) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and e:GetHandler():IsAbleToGrave() end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e) or Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end







--end card parts
end
--uni parts
sixth=sixth or {}
sixth.setchk=sixth.setchk or {}
function sixth.setreg(c,cd,setcd)   
	if not sixth.setchk[cd] then
		sixth.setchk[cd]=true
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD)
		ex:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		ex:SetCode(setcd)
		ex:SetTargetRange(0xff,0xff)
		ex:SetTarget(aux.TargetBoolFunction(Card.IsCode,cd))
		Duel.RegisterEffect(ex,0)
	end
end
function sixth.tgeff(c,con,cost,tg,op,ctlm,ctlmid,istg,ctg,range)
	con=con or aux.TRUE
	cost=cost or aux.TRUE
	tg=tg or aux.TRUE
	op=op or aux.TRUE
	range=range or LOCATION_ONFIELD
	local tgid=0
	if istg then
		tgid=EFFECT_FLAG_CARD_TARGET
	end
	local g=Group.CreateGroup()
	g:KeepAlive()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BECOME_TARGET)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCondition(con)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetHandler():RegisterFlagEffect(66600601,RESET_EVENT+0x1fe0000+RESET_CHAIN,0,1)
		local g=e:GetLabelObject()
		g:AddCard(re:GetHandler())
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex:SetCode(EVENT_CHAIN_END)
		ex:SetLabelObject(g)
		ex:SetOperation(function(e)
			local g=e:GetLabelObject()
			g:Clear()
			e:Reset()
		end)
		Duel.RegisterEffect(ex,tp)
	end)
	e3:SetLabelObject(g)
	c:RegisterEffect(e3)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(ctg)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(range)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(ctlm,ctlmid)
	e1:SetLabelObject(g)
	e1:SetProperty(tgid+EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetFlagEffect(66600601)>0
	end)
	e1:SetCost(cost)
	e1:SetTarget(tg)
	e1:SetOperation(op)
	c:RegisterEffect(e1)
end
function sixth.sixf(c,f,e,tp)
	return c:IsHasEffect(66600600) and (not f or f(c,e,tp)) and c:IsFaceup()
end
function sixth.sixtg(f,excon,ctg,fr)
return function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and sixth.sixf(chkc,f,e,tp) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(sixth.sixf,tp,LOCATION_MZONE,0,1,nil,f,e,tp) and (not excon or excon(e,tp,eg,ep,ev,re,r,rp)) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,sixth.sixf,tp,LOCATION_MZONE,0,1,1,nil,f,e,tp)
	if ctg then Duel.SetOperationInfo(0,ctg,g,1,0,0) end
	if fr then Duel.SetChainLimit(aux.FALSE) end
end
end
function sixth.bm(c)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET) 
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetTarget(sixth.bmsstg)
	e4:SetOperation(sixth.bmssop)
	c:RegisterEffect(e4)
end
function sixth.bmssfilter(c)
   return c:IsAbleToGrave() and c:IsHasEffect(66600600) and c:IsFaceup()
end
function sixth.bmsstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and cm.bmssfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingTarget(sixth.bmssfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,sixth.bmssfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function sixth.bmssop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) then
		if Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)>0 and tc:IsRelateToEffect(e) then
			--Duel.BreakEffect()
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end
function sixth.gtgf(c,f)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsHasEffect(66600600) and (not f or f(c))
end
sixth.gtg=sixth.gtg or {}
function sixth.gtgeff(c,f,cost,tg,op,ctlm,ctlmid,istg,ctg,range)
	local cd=c:GetOriginalCode()
	--con=con or aux.TRUE
	cost=cost or aux.TRUE
	tg=tg or aux.TRUE
	op=op or aux.TRUE
	range=range or LOCATION_ONFIELD
	local tgid=0
	if istg then
		tgid=EFFECT_FLAG_CARD_TARGET
	end
	if not sixth.gtg[cd] then
		sixth.gtg[cd]=Group.CreateGroup()
		sixth.gtg[cd]:KeepAlive()
		local e3=Effect.GlobalEffect()
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_BECOME_TARGET)
		e3:SetLabelObject(sixth.gtg[cd])
		e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
			return eg:IsExists(sixth.gtgf,1,nil,f)
		end)
		e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local g=eg:Filter(sixth.gtgf,nil,f)
			local tc=g:GetFirst()
			while tc do
				local p=tc:GetControler()
				Duel.RegisterFlagEffect(p,66600602,RESET_CHAIN,0,1)
				e:GetLabelObject():AddCard(tc)
				tc=g:GetNext()
			end
		end)
		Duel.RegisterEffect(e3,0)
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ex:SetCode(EVENT_CHAIN_END)
		ex:SetLabelObject(sixth.gtg[cd])
		ex:SetOperation(function(e)
			local g=e:GetLabelObject()
			g:Clear()
		end)
		Duel.RegisterEffect(ex,0)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(ctg)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(range)
	e1:SetLabelObject(sixth.gtg[cd])
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(ctlm,ctlmid)
	e1:SetProperty(tgid+EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.GetFlagEffect(tp,66600602)>0
	end)
	e1:SetCost(cost)
	e1:SetTarget(tg)
	e1:SetOperation(op)
	c:RegisterEffect(e1)
end
function sixth.rldes(c,m)
	sixth.setreg(c,m,66600600)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78651105,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(sixth.ntcon)
	c:RegisterEffect(e1)
end
function sixth.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.IsPlayerAffectedByEffect(c:GetControler(),66600615)
end