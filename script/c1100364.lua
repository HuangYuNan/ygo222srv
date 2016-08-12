--铁血·热血·冷血的吸血鬼杀手
function c1100364.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c1100364.fscon)
	e1:SetOperation(c1100364.fsop)
	c:RegisterEffect(e1)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c1100364.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c1100364.spcon)
	e2:SetOperation(c1100364.spop)
	c:RegisterEffect(e2) 
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1100364,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c1100364.discon)
	e3:SetTarget(c1100364.distg)
	e3:SetOperation(c1100364.disop)
	c:RegisterEffect(e3)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1100364,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,1100364)
	e2:SetCondition(c1100364.condition)
	e2:SetTarget(c1100364.target)
	e2:SetOperation(c1100364.operation)
	c:RegisterEffect(e2)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
   --disable and atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c1100364.adcon)
	e3:SetTarget(c1100364.adtg)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_SET_ATTACK_FINAL)
	e5:SetValue(c1100364.atkval)
	c:RegisterEffect(e5)
	--atk up
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_ATKCHANGE)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e6:SetCondition(c1100364.atkcon)
	e6:SetTarget(c1100364.atktg)
	e6:SetOperation(c1100364.atkop)
	c:RegisterEffect(e6)
end
function c1100364.filter1(c)
	return c:GetOriginalLevel()<=4 and c:IsFusionSetCard(0x6243) and c:IsType(TYPE_MONSTER)
end
function c1100364.filter2(c)
	return c:IsSetCard(0x6243) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_SYNCHRO)
end
function c1100364.fscon(e,g,gc,chkfnf)
	if g==nil then return true end
	local f1=c1100364.filter1
	local f2=c1100364.filter2
	local minc=2
	local chkf=bit.band(chkfnf,0xff)
	local tp=e:GetHandlerPlayer()
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		g:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler(),true) then return false end
		if aux.FConditionFilterFFR(gc,f1,f2,mg,minc,chkf) then
			return true
		elseif f2(gc) then
			mg:RemoveCard(gc)
			if aux.FConditionCheckF(gc,chkf) then chkf=PLAYER_NONE end
			return mg:IsExists(aux.FConditionFilterFFR,1,nil,f1,f2,mg,minc-1,chkf)
		else return false end
	end
	return mg:IsExists(aux.FConditionFilterFFR,1,nil,f1,f2,mg,minc,chkf)
end
function c1100364.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local f1=c1100364.filter1
	local f2=c1100364.filter2
	local chkf=bit.band(chkfnf,0xff)
	local fg=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,0,nil,77693536)
	local fc=fg:GetFirst()
	while fc do
		eg:Merge(fc:GetEquipGroup():Filter(Card.IsControler,nil,tp))
		fc=fg:GetNext()
	end
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler(),true)
	local minct=2
	local maxct=2
	if gc then
		g:RemoveCard(gc)
		if aux.FConditionFilterFFR(gc,f1,f2,g,minct,chkf) then
			if aux.FConditionCheckF(gc,chkf) then chkf=PLAYER_NONE end
			local g1=Group.CreateGroup()
			if f2(gc) then
				local mg1=g:Filter(aux.FConditionFilterFFR,nil,f1,f2,g,minct-1,chkf)
				if mg1:GetCount()>0 then
					--if gc fits both, should allow an extra material that fits f1 but doesn't fit f2
					local mg2=g:Filter(f2,nil)
					mg1:Merge(mg2)
					if chkf~=PLAYER_NONE then
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local sg=mg1:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
						g1:Merge(sg)
						mg1:Sub(sg)
						minct=minct-1
						maxct=maxct-1
						if not f2(sg:GetFirst()) then
							if mg1:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
								if minct<=0 then minct=1 end
								Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
								local sg=mg1:FilterSelect(tp,f2,minct,maxct,nil)
								g1:Merge(sg)
							end
							Duel.SetFusionMaterial(g1)
							return
						end
					end
					if maxct>1 and (minct>1 or Duel.SelectYesNo(tp,93)) then
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local sg=mg1:FilterSelect(tp,f2,minct-1,maxct-1,nil)
						g1:Merge(sg)
						mg1:Sub(sg)
						local ct=sg:GetCount()
						minct=minct-ct
						maxct=maxct-ct
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
					local sg=mg1:Select(tp,1,1,nil)
					g1:Merge(sg)
					mg1:Sub(sg)
					minct=minct-1
					maxct=maxct-1
					if mg1:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
						if minct<=0 then minct=1 end
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
						local sg=mg1:FilterSelect(tp,f2,minct,maxct,nil)
						g1:Merge(sg)
					end
					Duel.SetFusionMaterial(g1)
					return
				end
			end
			local mg=g:Filter(f2,nil)
			if chkf~=PLAYER_NONE then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg=mg:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
				g1:Merge(sg)
				mg:Sub(sg)
				minct=minct-1
				maxct=maxct-1
			end
			if mg:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
				if minct<=0 then minct=1 end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local sg=mg:Select(tp,minct,maxct,nil)
				g1:Merge(sg)
			end
			Duel.SetFusionMaterial(g1)
			return
		else
			if aux.FConditionCheckF(gc,chkf) then chkf=PLAYER_NONE end
			minct=minct-1
			maxct=maxct-1
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=g:FilterSelect(tp,aux.FConditionFilterFFR,1,1,nil,f1,f2,g,minct,chkf)
	local mg=g:Filter(f2,g1:GetFirst())
	if chkf~=PLAYER_NONE and not aux.FConditionCheckF(g1:GetFirst(),chkf) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local sg=mg:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
		g1:Merge(sg)
		mg:Sub(sg)
		minct=minct-1
		maxct=maxct-1
	end
	if mg:GetCount()>0 and maxct>0 and (minct>0 or Duel.SelectYesNo(tp,93)) then
		if minct<=0 then minct=1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local sg=mg:Select(tp,minct,maxct,nil)
		g1:Merge(sg)
	end
	Duel.SetFusionMaterial(g1)
end
function c1100364.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c1100364.rmfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(nil,true)
end
function c1100364.rmfilter1(c,mg,ft)
	local mg2=mg:Clone()
	mg2:RemoveCard(c)
	local ct=ft
	if c:IsLocation(LOCATION_MZONE) then ct=ct+1 end
	return c:GetOriginalLevel()<=4 and c:IsFusionSetCard(0x6243) and c:IsType(TYPE_MONSTER) and mg2:IsExists(c1100364.rmfilter2,1,nil,mg2,ct)
end
function c1100364.rmfilter2(c,mg,ft)
	local mg2=mg:Clone()
	mg2:RemoveCard(c)
	local ct=ft
	if c:IsLocation(LOCATION_MZONE) then ct=ct+1 end
	return c:IsFusionSetCard(0x6243) and c:IsType(TYPE_SYNCHRO) and mg2:IsExists(c1100364.rmfilter3,1,nil,ct)
end
function c1100364.rmfilter3(c,ft)
	local ct=ft
	if c:IsLocation(LOCATION_MZONE) then ct=ct+1 end
	return c:IsFusionSetCard(0x6243) and c:IsType(TYPE_SYNCHRO) and ct>0
end
function c1100364.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<-2 then return false end
	local mg=Duel.GetMatchingGroup(c1100364.rmfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	return mg:IsExists(c1100364.rmfilter1,1,nil,mg,ft)
end
function c1100364.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local mg=Duel.GetMatchingGroup(c1100364.rmfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=mg:FilterSelect(tp,c1100364.rmfilter1,1,1,nil,mg,ft)
	local tc1=g1:GetFirst()
	mg:RemoveCard(tc1)
	if tc1:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=mg:FilterSelect(tp,c1100364.rmfilter2,1,1,nil,mg,ft)
	local tc2=g2:GetFirst()
	if tc2:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	mg:RemoveCard(tc2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=mg:FilterSelect(tp,c1100364.rmfilter3,1,1,nil,ft)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c1100364.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c1100364.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c1100364.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c1100364.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp
end
function c1100364.filter(c,e,tp)
	return c:IsSetCard(0x6243) and not c:IsCode(1100364) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1100364.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1100364.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK)
	local rec=e:GetHandler():GetBaseAttack()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c1100364.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1100364.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK,0,1,1,nil,e,tp)
	local c=e:GetHandler()
	if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
	Duel.BreakEffect()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
	end
end
function c1100364.adcon(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c and c:GetBattleTarget()
		and (Duel.GetCurrentPhase()==PHASE_DAMAGE or Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL)
end
function c1100364.adtg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c1100364.atkval(e,c)
	return math.ceil(c:GetBaseAttack()/2)
end
function c1100364.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker() or c==Duel.GetAttackTarget()
end
function c1100364.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,c)
		if g:GetCount()==0 then return false end
		local g1,atk=g:GetMaxGroup(Card.GetBaseAttack)
		return c:GetAttack()~=atk and c:GetFlagEffect(1100364)==0
	end
	c:RegisterFlagEffect(1100364,RESET_CHAIN,0,1)
end
function c1100364.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	if g:GetCount()==0 then return end
	local g1,atk=g:GetMaxGroup(Card.GetBaseAttack)
	if c:IsRelateToEffect(e) and c:IsFaceup() and atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end