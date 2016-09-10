senya=senya or {}
local cm=senya
os=require('os')
table=require('table')
io=require('io')
--7CG universal scripts
--test parts
cm.delay=0x14000
cm.fix=0x40400
if not Card.GetDefense then
	Card.GetDefense=Card.GetDefence
	Card.GetBaseDefense=Card.GetBaseDefence
	Card.GetTextDefense=Card.GetTextDefence
	Card.GetPreviousDefenseOnField=Card.GetPreviousDefenceOnField
	Card.IsDefensePos=Card.IsDefencePos
	Card.IsDefenseBelow=Card.IsDefenceBelow
	Card.IsDefenseAbove=Card.IsDefenceAbove
end
--effect setcode tech
cm.setchk=cm.setchk or {}
function cm.setreg(c,cd,setcd)   
	if not cm.setchk[cd] then
		cm.setchk[cd]=true
		local ex=Effect.GlobalEffect()
		ex:SetType(EFFECT_TYPE_FIELD)
		ex:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		ex:SetCode(setcd)
		ex:SetTargetRange(0xff,0xff)
		ex:SetTarget(aux.TargetBoolFunction(Card.IsCode,cd))
		Duel.RegisterEffect(ex,0)
	end
end
function cm.sgreg(c,setcd)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(setcd)
	c:RegisterEffect(e1)
	return e1
end
--xyz summon of prim
function cm.rxyz1(c,rk,f,xm)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(cm.xyzcon1(rk,f))
	e1:SetOperation(cm.xyzop1(rk,f,xm))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	return e1
end
function cm.mfilter(c,xyzc,rk,f)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsCanBeXyzMaterial(xyzc) and (not rk or c:GetRank()==rk) and (not f or f(c))
end
function cm.xyzfilter1(c,g,ct)
	return g:IsExists(cm.xyzfilter2,ct,c,c:GetRank())
end
function cm.xyzfilter2(c,rk)
	return c:GetRank()==rk
end
function cm.xyzcon1(rk,f)
return function(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local minc=2
	local maxc=64
	if min then
		minc=math.max(minc,min)
		maxc=max
	end
	local ct=math.max(minc-1,-ft)
	local mg=nil
	if og then
		mg=og:Filter(cm.mfilter,nil,c,rk,f)
	else
		mg=Duel.GetMatchingGroup(cm.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
	end
	return maxc>=2 and mg:IsExists(cm.xyzfilter1,1,nil,mg,ct)
end
end
function cm.xyzop1(rk,f,xm)
return function(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	if og and not min then
		g=og
	else
		local mg=nil
		if og then
			mg=og:Filter(cm.mfilter,nil,c,rk,f)
		else
			mg=Duel.GetMatchingGroup(cm.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
		end
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local minc=2
		local maxc=64
		if min then
			minc=math.max(minc,min)
			maxc=max
		end
		local ct=math.max(minc-1,-ft)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,cm.xyzfilter1,1,1,nil,mg,ct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:FilterSelect(tp,cm.xyzfilter2,ct,maxc-1,g:GetFirst(),g:GetFirst():GetRank())
		g:Merge(g2)
	end
	local sg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		sg:Merge(tc:GetOverlayGroup())
		tc=g:GetNext()
	end
	if xm then
		Duel.Overlay(c,sg)
	else
		Duel.SendtoGrave(sg,REASON_RULE)
	end
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
end

function cm.rxyz2(c,rk,f,ct,xm)
	ct=ct or 2
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(cm.xyzcon2(rk,f,ct))
	e1:SetOperation(cm.xyzop2(rk,f,ct,xm))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	return e1
end
--reborn for mokou
function cm.xyzcon2(rk,f,ct)
return function(e,c,og)
	local lct=ct-1
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	if og then
		mg=og:Filter(cm.mfilter,nil,c,rk,f)
	else
		mg=Duel.GetMatchingGroup(cm.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
	end
	local lm=0-ct
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>lm
		and mg:IsExists(cm.xyzfilter1,lct,nil,mg,lct)
end
end
function cm.xyzop2(rk,f,ct,xm)
return function(e,tp,eg,ep,ev,re,r,rp,c,og)
	local lct=ct-1
	local g=nil
	local sg=Group.CreateGroup()
	if og then
		g=og
		local tc=og:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=og:GetNext()
		end
	else
		local mg=Duel.GetMatchingGroup(cm.mfilter,tp,LOCATION_MZONE,0,nil,c,rk,f)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,cm.xyzfilter1,1,1,nil,mg,lct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:FilterSelect(tp,cm.xyzfilter2,lct,lct,g:GetFirst(),g:GetFirst():GetRank())
		g:Merge(g2)
		local tc=g:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=g:GetNext()
		end
	end
	if xm then
		Duel.Overlay(c,sg)
	else
		Duel.SendtoGrave(sg,REASON_RULE)
	end
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
end

--mokou reborn
function cm.mk(c,ct,cd,eff,con,exop,excon)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(ct,cd)
	e2:SetCondition(cm.mkcon(eff,con))
	e2:SetTarget(cm.mktg)
	e2:SetOperation(cm.mkop(exop,excon))
	c:RegisterEffect(e2)
	return e2
end
function cm.mkcon(eff,con)
	if eff then
		return function(e,tp,eg,ep,ev,re,r,rp)
			return bit.band(e:GetHandler():GetReason(),0x41)==0x41 and (not con or con(e,tp,eg,ep,ev,re,r,rp))
		end
	else
		return function(e,tp,eg,ep,ev,re,r,rp)
			return e:GetHandler():IsReason(REASON_DESTROY) and (not con or con(e,tp,eg,ep,ev,re,r,rp))
		end
	end
end
function cm.mktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.mkop(exop,excon)
return function(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not c:IsRelateToEffect(e) or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 and exop and (not excon or excon(e,tp,eg,ep,ev,re,r,rp)) then
		exop(e,tp,eg,ep,ev,re,r,rp)
	end
end
end
--chk if is 7cg
function cm.cgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(cm.cgfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
end
function cm.cgfilter(c)
	return cm.unifilter(c) and c:IsFaceup()
end
function cm.unifilter(c)
	return (c:IsSetCard(0x770) or c:IsSetCard(0x772) or c:IsSetCard(0x773) or c:IsSetCard(0x775) or c:IsHasEffect(37564600) or c:IsCode(37564765)) and c:IsType(TYPE_MONSTER)
end
function cm.uniprfilter(c)
	return ((c:IsSetCard(0x770) and c:IsType(TYPE_XYZ)) or (c:IsSetCard(0x775) and c:IsType(TYPE_XYZ)) or (c:IsSetCard(0x776) and c:IsType(TYPE_XYZ)) or c:IsSetCard(0x772) or c:IsSetCard(0x773)) and c:IsType(TYPE_MONSTER)
end
--rm mat cost
function cm.rmovcost(ct)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,ct,ct,REASON_COST)
end
end
--discard hand cost
function cm.discost(ct)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,ct,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,ct,ct,REASON_COST+REASON_DISCARD,e:GetHandler())
end
end
--release cost
function cm.serlcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function cm.sermcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function cm.setdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckOrExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
--for ss effects
function cm.spfilter(c,e,tp,f,ig,stype)
	return c:IsCanBeSpecialSummoned(e,stype,tp,ig,ig) and (not f or f(c,e,tp)) and c:IsType(TYPE_MONSTER)
end
function cm.tgsptg(loc,f,opp,ig,stype)
return function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	stype=stype or 0
	if not ig then ig=false end
	local oploc=0
	if opp then oploc=loc end
	if chkc then return chkc:IsLocation(loc) and cm.spfilter(chkc,e,tp,f,ig,stype) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(cm.spfilter,tp,loc,oploc,1,nil,e,tp,f,ig,stype) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,cm.spfilter,tp,loc,oploc,1,1,nil,e,tp,f,ig,stype)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
end
function cm.tgspop(ig,stype,exop)
return function(e,tp,eg,ep,ev,re,r,rp)
	ig=ig or false
	stype=stype or 0
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,stype,tp,tp,ig,ig,POS_FACEUP) then
		if exop then exop(e,tp,tc,e:GetHandler()) end
		Duel.SpecialSummonComplete()
	end
end
end
function cm.sesptg(loc,f,ig,stype)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	stype=stype or 0
	ig=ig or false
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(cm.spfilter,tp,loc,0,1,nil,e,tp,f,ig,stype) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
end
function cm.sespop(loc,f,ig,stype,exop)
return function(e,tp,eg,ep,ev,re,r,rp)
	stype=stype or 0
	ig=ig or false
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,loc,0,1,1,nil,e,tp,f,ig,stype)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,stype,tp,tp,ig,ig,POS_FACEUP) then
		if exop then exop(e,tp,tc,e:GetHandler()) end
		Duel.SpecialSummonComplete()
	end
end
end
--for search effects
function cm.srfilter(c,f)
	return c:IsAbleToHand() and (not f or f(c))
end
function cm.sesrtg(loc,f)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.srfilter,tp,loc,0,1,nil,f) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,loc)
end
end
function cm.sesrop(loc,f)
return function(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,cm.srfilter,tp,loc,0,1,1,nil,f)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
end
function cm.tgsrtg(loc,f)
return function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()==tp and chkc:GetLocation()==loc and cm.srfilter(chkc,f) end
	if chk==0 then return Duel.IsExistingTarget(cm.srfilter,tp,loc,0,1,nil,f) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,cm.srfilter,tp,loc,0,1,1,nil,f)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
end
function cm.tgsrop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
--arrival condition
function cm.arcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
end
---check date dt="Mon" "Tue" etc
function cm.dtcon(dt,excon)
	return function(e,tp,eg,ep,ev,re,r,rp)
		return dt==os.date("%a") and (not excon or excon(e,tp,eg,ep,ev,re,r,rp))
	end
end
--copy effect c=getcard(nil=orcard) tc=sourcecard ht=showcard(bool) res=reset event(nil=no reset)
function cm.copy(e,c,tc,ht,res)
		c=c or e:GetHandler()
		res=res or RESET_EVENT+0x1fe0000
		local cid=nil
		if tc and c:IsFaceup() and c:IsRelateToEffect(e) then
			local code=tc:GetOriginalCode()
			local atk=tc:GetBaseAttack()
			local def=tc:GetBaseDefense()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(res)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetValue(code)
			c:RegisterEffect(e1)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetReset(res)
			e3:SetCode(EFFECT_SET_BASE_ATTACK)
			e3:SetValue(atk)
			c:RegisterEffect(e3)
			local e4=Effect.CreateEffect(e:GetHandler())
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e4:SetReset(res)
			e4:SetCode(EFFECT_SET_BASE_DEFENSE)
			e4:SetValue(def)
			c:RegisterEffect(e4)
			if not tc:IsType(TYPE_TRAPMONSTER) then
				cid=c:CopyEffect(code,res)
			end
			if ht then
				Duel.Hint(HINT_CARD,0,code)
			end
		end
		return cid
end
--universals for sww

--swwss(ct=discount ls=Lunatic Sprinter)
function cm.sww(c,ct,ctxm,ctsm,ls)
	if ctxm then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		e1:SetValue(1)
		c:RegisterEffect(e1)
	end
	if ctsm then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e3:SetValue(1)
		c:RegisterEffect(e3)
	end
	--ss
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(c:GetOriginalCode(),0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e4:SetCost(cm.swwsscost(ct,ls))
	e4:SetTarget(cm.swwsstg)
	e4:SetOperation(cm.swwssop)
	c:RegisterEffect(e4)
	return e4
end
function cm.swwsscost(ct,ls)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
			   if e:GetHandler():IsLocation(LOCATION_HAND) and Duel.IsPlayerAffectedByEffect(tp,37564218) then return true end
			   if chk==0 then return Duel.IsExistingMatchingCard(cm.swwssfilter,tp,LOCATION_HAND,0,ct,e:GetHandler(),e,ls) end
			   Duel.DiscardHand(tp,cm.swwssfilter,ct,ct,REASON_COST,e:GetHandler(),e,ls)
		   end
end
function cm.swwsstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.swwssop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function cm.swwssfilter(c,e,ls)
	return (c:IsSetCard(0x773) or (ls and c:GetTextAttack()==-2 and c:GetTextAttack()==-2)) and not c:IsCode(e:GetHandler():GetCode()) and c:IsAbleToGraveAsCost()
end
--for judge blank extra
function cm.swwblex(e,tp)
	tp=tp or e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)==0
end
--for sww rm grave
function cm.swwcostfilter(c)
	return c:IsSetCard(0x773) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function cm.swwrmcost(ct)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
			   if chk==0 then return Duel.IsExistingMatchingCard(cm.swwcostfilter,tp,LOCATION_GRAVE,0,ct,nil) end
			   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			   local g=Duel.SelectMatchingCard(tp,cm.swwcostfilter,tp,LOCATION_GRAVE,0,ct,ct,nil)
			   Duel.Remove(g,POS_FACEUP,REASON_COST)
		   end
end

--universals for bm

--bmss ctg=category istg=is-target-effect

function cm.bm(c,tg,op,istg,ctg)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564765,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET) 
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetCost(cm.bmssct(c:GetOriginalCode()))
	e4:SetTarget(cm.bmsstg)
	e4:SetOperation(cm.bmssop)
	c:RegisterEffect(e4)
	local e1=nil
	if op then
		e1=Effect.CreateEffect(c)
		if ctg then e1:SetCategory(ctg) end
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_SPSUMMON_SUCCESS)  
		if istg then
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET+cm.delay)
		else
			e1:SetProperty(cm.delay)
		end
		e1:SetCondition(cm.bmsscon)
		if tg then e1:SetTarget(tg) end
		e1:SetOperation(op)
		c:RegisterEffect(e1)
	end
	return e1
end
function cm.bmssfilter(c)
   return c:IsAbleToHand() and cm.bmchkfilter(c) and c:IsFaceup()
end
function cm.bmssct(cd)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if not cd then return false end
	if chk==0 then return Duel.GetFlagEffect(tp,cd)==0 end
	Duel.RegisterFlagEffect(tp,cd,RESET_PHASE+PHASE_END,0,1)
end
end
function cm.bmsstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and cm.bmssfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingTarget(cm.bmssfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,cm.bmssfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.bmssop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			if Duel.SpecialSummonStep(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP) then
				e:GetHandler():RegisterFlagEffect(37564499,RESET_EVENT+0x1fe0000,0,1)
				Duel.SpecialSummonComplete()
			end
		end
	end
end
function cm.bmsscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(37564499)>0
end
--check if is bm
function cm.bmchkfilter(c)
	return c:IsSetCard(0x775) and c:IsType(TYPE_MONSTER)
end
--damage chk for bm
--1=remove 2=extraattack 3=atk3000 4=draw
function cm.bmdamchkop(e,tp,eg,ep,ev,re,r,rp)
local ct=e:GetLabel()
local c=e:GetHandler()
local bc=c:GetBattleTarget()
if ct==0 then return end
if c:IsRelateToEffect(e) and c:IsFaceup() then
	Duel.ConfirmDecktop(tp,ct)
	local g=Duel.GetDecktopGroup(tp,ct)
	local ag=g:Filter(cm.bmchkfilter,nil)
	if ag:GetCount()>0 then
		local val=0
		local tc=ag:GetFirst()
		while tc do
			val=val+tc:GetTextAttack()
			tc=ag:GetNext()
		end
		local t1=ag:FilterCount(Card.IsCode,nil,37564451)
		local t2=ag:FilterCount(Card.IsCode,nil,37564452)
		local t3=ag:FilterCount(Card.IsCode,nil,37564453)
		local t4=ag:FilterCount(Card.IsCode,nil,37564454)
		if t1>0 and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) then
			Duel.Hint(HINT_CARD,0,37564451)
			if Duel.SelectYesNo(tp,aux.Stringid(37564765,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,t1,c)
				if g:GetCount()>0 then
					Duel.HintSelection(g)
					Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
				end
			end
		end
		if t2>0 then
			Duel.Hint(HINT_CARD,0,37564452)
			for i=1,t2 do
			   c:RegisterFlagEffect(37564498,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			end
		end
		if t3>0 then
			Duel.Hint(HINT_CARD,0,37564453)
			val=val+(t3*1500)
		end
		if t4>0 then
			Duel.Hint(HINT_CARD,0,37564454)
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,t4*2,REASON_EFFECT)
		end
		if val>0 and c:IsRelateToBattle() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
			e1:SetValue(val)
			c:RegisterEffect(e1)
		end  
		if Duel.SelectYesNo(tp,aux.Stringid(37564765,2)) then
			local thg=ag:Filter(cm.adfilter,nil)
			if thg:GetCount()>0 then
				local thc=thg:Select(tp,1,1,nil)
				Duel.SendtoHand(thc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,thc)
			end
		end
	end
	Duel.ShuffleDeck(tp)
end
end
function cm.adfilter(c)
	return c:IsAbleToHand() and c:IsLocation(LOCATION_DECK)
end
--bm attack oppolimit
function cm.bmdamchk(c,lm)
	local e2=nil
	if lm then
	e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(cm.bmaclimit)
	e2:SetCondition(cm.bmactcon)
	c:RegisterEffect(e2)
	end
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(cm.bmexat)
	c:RegisterEffect(e4)
	return e4,e2
end
function cm.bmaclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function cm.bmactcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function cm.bmexat(e,c)
	return c:GetFlagEffect(37564498)
end
--for condition of damchk
function cm.bmdamchkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
--for cost of rmex
function cm.bmrmcostfilter(c)
	return cm.bmchkfilter(c) and c:IsAbleToRemoveAsCost()
end
function cm.bmrmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.bmrmcostfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,cm.bmrmcostfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)

end
--for release bm L5
--fr=must be ssed
function cm.bmrl(c,fr)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564765,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(cm.bmrlcon)
	e1:SetOperation(cm.bmrlop)
	c:RegisterEffect(e1)
	if fr then
		local e2=Effect.CreateEffect(c)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+  EFFECT_FLAG_UNCOPYABLE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SPSUMMON_CONDITION)
		c:RegisterEffect(e2)
	end
	return e1
end
function cm.bmrlfilter(c)
	return cm.bmchkfilter(c) and c:IsFaceup()
end
function cm.bmrlcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,cm.bmrlfilter,1,nil)
end
function cm.bmrlop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	local g=Duel.SelectReleaseGroup(tp,cm.bmrlfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end


--universals for paranoia
function cm.pr1(c,lv,atk,hl,max)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),lv,4,cm.provfilter(atk),aux.Stringid(37564765,3))
	c:EnableReviveLimit()
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(cm.primmcon)
	e5:SetValue(cm.primmfilter(atk,max))
	c:RegisterEffect(e5)
end
function cm.primmcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
--changes
function cm.provfilter(atk)
	return function(c)
		return c:IsFaceup() and c:IsSetCard(0x776) and c:GetAttack()==0 and c:GetDefense()==atk
	end
end
function cm.primmfilter(atk,max,hl)
	if not hl then return aux.TRUE end
	return function(e,te)
		return (te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner() and ((te:GetHandler():GetAttack()<atk and hl==0) or (te:GetHandler():GetAttack()>atk and hl==1))) or (te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and max)
	end
end

function cm.pr2(c,des,tg,op,istg,ctg)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	if des then
		local e3=e2:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e3)
	end
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		return c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP_ATTACK)
	end)
	e4:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_SPSUMMON_CONDITION)
	e5:SetValue(0)
	c:RegisterEffect(e5)
	if op then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(c:GetOriginalCode(),0))
		if ctg then e1:SetCategory(CATEGORY_TOHAND) end
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
		if istg then
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET+cm.delay)
		else
			e1:SetProperty(cm.delay)
		end
		e1:SetCountLimit(1,c:GetOriginalCode())
		if tg then e1:SetTarget(tg) end
		e1:SetOperation(op)
		c:RegisterEffect(e1)
	end
end

--xyz monster atk drain effect
--con(usual)=condition tg(battledcard,card)=filter
--cost=cost
--xm=drain mat
function cm.atkdr(c,con,tg,cost,ctlm,ctlmid,xm)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BATTLE_START)
	if ctlm then e5:SetCountLimit(ctlm,ctlmid) end
	e5:SetCondition(cm.atkdrcon(con,tg))
	if cost then e5:SetCost(cost) end
	if xm then
		e5:SetLabel(2)
	else
		e5:SetLabel(1)
	end
	e5:SetTarget(cm.atkdrtg)
	e5:SetOperation(cm.atkdrop)
	c:RegisterEffect(e5)
end
function cm.atkdrcon(con,tg)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local bc=c:GetBattleTarget()
		return (not con or con(e,tp,eg,ep,ev,re,r,rp)) and bc and (not tg or tg(bc,c)) and not bc:IsType(TYPE_TOKEN)
	end
end
function cm.atkdrtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ) end
end
function cm.atkdrop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToBattle() and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			if e:GetLabel()==2 then
				Duel.Overlay(c,og)
			else
				Duel.SendtoGrave(og,REASON_RULE)
			end
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
--nanahira parts
function cm.nnhr(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_ONFIELD+LOCATION_GRAVE)
	e2:SetValue(37564765)
	c:RegisterEffect(e2)
	cm.nntr(c)
end
function cm.nntr(c)
	cm.sgreg(c,37564765)
end
function cm.nncon(og)
return function(e,tp)
	tp=tp or e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(cm.nnfilter,tp,LOCATION_MZONE,0,1,nil,og)
end
end
function cm.nnfilter(c,og)
	if not c:IsFaceup() then return end
	return c:GetOriginalCode()==37564765 or (c:IsCode(37564765) and not og)
end
--for infinity negate effect
function cm.neg(c,lmct,lmcd,cost,excon,exop,loc,force)
	local e3=Effect.CreateEffect(c)
	loc=loc or LOCATION_MZONE
	e3:SetDescription(aux.Stringid(37564765,5))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	if force then
		e3:SetType(EFFECT_TYPE_QUICK_F)
	else
		e3:SetType(EFFECT_TYPE_QUICK_O)
	end
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(lmct,lmcd)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(loc)
	e3:SetCondition(cm.negcon(excon))
	if cost then e3:SetCost(cost) end
	e3:SetTarget(cm.negtg)
	e3:SetOperation(cm.negop(exop))
	c:RegisterEffect(e3)
	return e3
end
function cm.negcon(excon)
return function(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and (not excon or excon(e,tp,eg,ep,ev,re,r,rp))
end
end
function cm.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function cm.negop(exop)
return function(e,tp,eg,ep,ev,re,r,rp)
	local chk=Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	if chk and exop then
		exop(e,tp,eg,ep,ev,re,r,rp)
	end
end
end
function cm.negtrap(c,lmct,lmcd,cost,excon,exop)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(lmct,lmcd)
	e1:SetCondition(cm.negcon(excon))
	if cost then e1:SetCost(cost) end
	e1:SetTarget(cm.negtg)
	e1:SetOperation(cm.negop(exop))
	c:RegisterEffect(e1)
	return e1
end
function cm.drawtg(ct)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
end
function cm.drawop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function cm.prsyfilter(c)
	return c:IsHasEffect(37564600) and c:IsType(TYPE_SYNCHRO)
end
function cm.prl4(c,cd)
	cm.setreg(c,cd,37564600)
	aux.AddSynchroProcedure(c,nil,aux.FilterBoolFunction(Card.IsHasEffect,37564600),1)
	c:EnableReviveLimit()
end
function cm.xmcon(ct,excon)
return function(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>=ct and (not excon or excon(e,tp,eg,ep,ev,re,r,rp))
end
end
--counter summon effect universals
--n=normal f=flip s=special o=opponent only
function cm.negs(c,tpcode,ctlm,ctlmid,con,cost)
	if not tpcode or bit.band(tpcode,7)==0 then return end
	ctlmid=ctlmid or 1
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564765,4))
	e3:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SPSUMMON)
	if ctlm then e3:SetCountLimit(ctlm,ctlmid) end
	if bit.band(tpcode,8)==8 then
		e3:SetLabel(2)
	else
		e3:SetLabel(1)
	end
	e3:SetCondition(cm.negsdiscon(con))
	if cost then e3:SetCost(cost) end
	e3:SetTarget(cm.negsdistg)
	e3:SetOperation(cm.negsdisop)
	local e2=e3:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	local e1=e3:Clone()
	e1:SetCode(EVENT_SUMMON)
	local t={}
	if bit.band(tpcode,1)==1 then
		c:RegisterEffect(e1)
		table.insert(t,e1)
	end
	if bit.band(tpcode,2)==2 then
		c:RegisterEffect(e2)
		table.insert(t,e2)
	end
	if bit.band(tpcode,4)==4 then
		c:RegisterEffect(e3)
		table.insert(t,e3)
	end
	return table.unpack(t)
end
function cm.negsfilter(c,tp,e)
	return c:GetSummonPlayer()==tp or e:GetLabel()==1
end
function cm.negsdiscon(con)
return function(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:IsExists(cm.negsfilter,1,nil,e,1-tp) and (not con or con(e,tp,eg,ep,ev,re,r,rp))
end
end
function cm.negsdistg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(cm.filter,nil,e,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function cm.negsdisop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(cm.negsfilter,nil,e,1-tp)
	Duel.NegateSummon(g)
	Duel.Destroy(g,REASON_EFFECT)
end
function cm.rxyz3(c,rf,desc,f,lv,ct)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetValue(SUMMON_TYPE_XYZ)
	e4:SetCondition(cm.xyzcon3(rf,f,lv,ct,mct))
	e4:SetOperation(cm.xyzop3(rf,desc,f,lv,ct,mct))
	c:RegisterEffect(e4)
	c:EnableReviveLimit()
end
function cm.xyzfilter3(c,xyzcard,f,lv)
	return c:IsFaceup() and c:IsCanBeXyzMaterial(xyzcard) and c:IsXyzLevel(xyzcard,lv) and (not f or f(c))
end
function cm.xyzfilter3_kobato(c,xyzcard,rf,f,lv)
	return cm.xyzfilter3(c,xyzcard,f,lv) and rf and rf(c)
end
function cm.xyzcon3(rf,f,lv,ct)
return function(e,c,og,min,max)
	if c==nil then return true end
	if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
	if og then
		if min then
			if min>ct or max<ct then return false end
			if og:IsExists(cm.xyzfilter3,ct,nil,c,f,lv) then return true end
			if min==ct-1 then
				local tg=og:Filter(cm.xyzfilter3,nil,c,f,lv)
				if tg:GetCount()>=ct-1 and tg:IsExists(cm.xyzfilter3_kobato,1,nil,c,rf,f,lv) then return true end
			end
			return false
		else
			local count=og:GetCount()
			if count==ct-1 then
				return og:FilterCount(cm.xyzfilter3,nil,c,f,lv)==ct-1 and og:IsExists(cm.xyzfilter3_kobato,1,nil,c,rf,f,lv)
			elseif count==ct then
				return og:FilterCount(cm.xyzfilter3,nil,c,f,lv)==ct
			end
			return false
		end
	end
	local tg=Duel.GetMatchingGroup(cm.xyzfilter3,c:GetControler(),LOCATION_MZONE,0,nil,c,f,lv)
	if tg:GetCount()<ct-1 then return false end
	return tg:GetCount()>=ct or tg:IsExists(cm.xyzfilter3_kobato,1,nil,c,rf,f,lv)
end
end
function cm.xyzop3(rf,desc,f,lv,ct)
return function(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local mg=og or Duel.GetMatchingGroup(cm.xyzfilter3,tp,LOCATION_MZONE,0,nil,c,f,lv)
	if not og or min then
		local mg1=mg:Filter(cm.xyzfilter3,nil,c,f,lv)
		local mg2=mg:Filter(cm.xyzfilter3_kobato,nil,c,rf,f,lv)
		if (not min or min<ct) and (mg1:GetCount()==ct-1 or mg2:GetCount()>0 and Duel.SelectYesNo(tp,desc)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local tg=mg2:Select(tp,1,1,nil)
			mg1:Sub(tg)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			mg=mg1:Select(tp,ct-1,ct-1,nil)
			mg:Merge(tg)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			mg=mg1:Select(tp,ct,ct,nil)
		end
	end
	local sg=Group.CreateGroup()
	local tc=mg:GetFirst()
	while tc do
		local sg1=tc:GetOverlayGroup()
		sg:Merge(sg1)
		tc=mg:GetNext()
	end
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(mg)
	Duel.Overlay(c,mg)
end
end

--for copying spell
function cm.scopy(c,loc1,loc2,f,con,cost,ctlm,ctlmid,eloc,x)
	local e2=Effect.CreateEffect(c)
	eloc=eloc or LOCATION_MZONE
	cost=cost or aux.TRUE
	con=con or aux.TRUE
	local desc=aux.Stringid(37564765,6)
	ctlmid=ctlmid or 1
	e2:SetDescription(desc)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(eloc)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0x3c0)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	if ctlm then e3:SetCountLimit(ctlm,ctlmid) end
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return not Duel.CheckEvent(EVENT_CHAINING) and con(e,tp,eg,ep,ev,re,r,rp)
	end)
	e2:SetCost(cost)
	e2:SetTarget(cm.scopytg1(loc1,loc2,f,x))
	e2:SetOperation(cm.scopyop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(desc)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	if ctlm then e3:SetCountLimit(ctlm,ctlmid) end
	e3:SetCost(cost)
	e3:SetCondtion(con)
	e3:SetTarget(cm.scopytg2(loc1,loc2,f,x))
	e3:SetOperation(cm.scopyop)
	c:RegisterEffect(e3)
	return e2,e3
end
function cm.scopyf1(c,f,e,tp)
	return (c:GetType()==TYPE_SPELL or c:GetType()==TYPE_SPELL+TYPE_QUICKPLAY
		or c:GetType()==TYPE_TRAP or c:GetType()==TYPE_TRAP+TYPE_COUNTER) 
		and c:IsAbleToRemoveAsCost() and c:CheckActivateEffect(true,true,false) and (not f or f(c,e,tp))
end
function cm.scopytg1(loc1,loc2,f,x)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	local og=Duel.GetFieldGroup(tp,loc1,loc2)
	if x then og:Merge(e:GetHandler():GetOverlayGroup()) end
	if chk==0 then
		return og:IsExists(cm.scopyf1,1,nil,f,e,tp)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=og:FilterSelect(tp,cm.scopyf1,1,1,nil,f,e,tp)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(true,true,true)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
end
end
function cm.scopyop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
function cm.scopyf2(c,e,tp,eg,ep,ev,re,r,rp,f)
	if (c:GetType()==TYPE_SPELL or c:GetType()==TYPE_SPELL+TYPE_QUICKPLAY
		or c:GetType()==TYPE_TRAP or c:GetType()==TYPE_TRAP+TYPE_COUNTER) and c:IsAbleToRemoveAsCost() and (not f or f(c,e,tp,eg,ep,ev,re,r,rp)) then
		if c:CheckActivateEffect(true,true,false) then return true end
		local te=c:GetActivateEffect()
		if te:GetCode()~=EVENT_CHAINING then return false end
		local tg=te:GetTarget()
		if tg and not tg(e,tp,eg,ep,ev,re,r,rp,0) then return false end
		return true
	else return false end
end
function cm.scopytg2(loc1,loc2,f,x)
return function(e,tp,eg,ep,ev,re,r,rp,chk)
	local og=Duel.GetFieldGroup(tp,loc1,loc2)
	if x then og:Merge(e:GetHandler():GetOverlayGroup()) end
	if chk==0 then
		return og:IsExists(cm.scopyf2,1,nil,e,tp,eg,ep,ev,re,r,rp,f)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=og:FilterSelect(tp,cm.scopyf2,1,1,nil,e,tp,eg,ep,ev,re,r,rp,f)
	local tc=g:GetFirst()
	local te,ceg,cep,cev,cre,cr,crp
	local fchain=cm.scopyf1(tc)
	if fchain then
		te,ceg,cep,cev,cre,cr,crp=tc:CheckActivateEffect(true,true,true)
	else
		te=tc:GetActivateEffect()
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then
		if fchain then
			tg(e,tp,ceg,cep,cev,cre,cr,crp,1)
		else
			tg(e,tp,eg,ep,ev,re,r,rp,1)
		end
	end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
end
end
function cm.icopy(c,lmct,lmcd,cost,excon,loc)
	local e3=Effect.CreateEffect(c)
	loc=loc or LOCATION_MZONE
	e3:SetDescription(aux.Stringid(37564765,7))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(lmct,lmcd)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(loc)
	e3:SetCondition(cm.iccon(excon))
	if cost then e3:SetCost(cost) end
	e3:SetTarget(cm.ictg)
	e3:SetOperation(cm.scopyop)
	c:RegisterEffect(e3)
	return e3
end
function cm.iccon(excon)
return function(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and (not excon or excon(e,tp,eg,ep,ev,re,r,rp))
end
end
function cm.ictg(e,tp,eg,ep,ev,re,r,rp,chk)
	local te=re:Clone()
	local tg=te:GetTarget()
	if chk==0 then
		local res=false
		if not tg then return true end
		if not pcall(function() res=tg(e,tp,eg,ep,ev,re,r,rp,0) end) then return false end
		return res
	end
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
end
function cm.cneg(c,con,cost,exop,desc,des,loc)
	loc=loc or LOCATION_MZONE
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(loc)
	e3:SetCondition(cm.negcon(con))
	e3:SetOperation(cm.cnegop(cost,exop))
	c:RegisterEffect(e3)
end
function cm.cnegcon(con)
return function(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainDisablable(ev) and (not con or con(e,tp,eg,ep,ev,re,r,rp))
end
end
function cm.cnegop(cost,exop,desc,des)
return function(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectYesNo(tp,desc) then return end
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	if cost then cost(e,tp,eg,ep,ev,re,r,rp) end
	local chk=Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) and des then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	if chk and exop then
		exop(e,tp,eg,ep,ev,re,r,rp)
	end
end
end
