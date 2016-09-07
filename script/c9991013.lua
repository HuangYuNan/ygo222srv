--ＳＡｒｋ（ステラライズ・アークエンジェル）・ベンスレイヤー
function c9991013.initial_effect(c)
	--Xyz
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--To Grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991013,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,19991013)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,1,nil) end
		local sg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,1,0,0)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,0,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local code=0
			if g:GetFirst():IsFaceup() then
				code=g:GetFirst():GetCode()
			end
			Duel.SendtoGrave(g,REASON_EFFECT)
			if code~=0 then
				--negate on this chain
				local lab=0
				for i=1,Duel.GetCurrentChain() do
					local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
					if c9991013.checkfunc(te,code) then
						lab=lab+(2^i)
					end
				end
				if lab~=0 then
					local ge1=Effect.CreateEffect(c)
					ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
					ge1:SetCode(EVENT_CHAIN_SOLVING)
					ge1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,chk)
						if not (Duel.IsChainDisablable(ev)
							and bit.band(e:GetLabel(),2^ev)~=0) then return end
						Duel.NegateEffect(ev)
					end)
					ge1:SetReset(RESET_CHAIN)
					ge1:SetLabel(lab)
					Duel.RegisterEffect(ge1,tp)
				end
				--negate after this chain
				local ge2=Effect.GlobalEffect()
				ge2:SetType(EFFECT_TYPE_FIELD)
				ge2:SetTargetRange(0xff,0xff)
				ge2:SetReset(RESET_PHASE+PHASE_END)
				ge2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
				ge2:SetTarget(function(e,c)
					return c:IsCode(e:GetLabel())
				end)
				ge2:SetLabel(code)
				ge2:SetCode(EFFECT_DISABLE)
				Duel.RegisterEffect(ge2,tp)
				local ge3=Effect.GlobalEffect()
				ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				ge3:SetCode(EVENT_CHAINING)
				ge3:SetReset(RESET_PHASE+PHASE_END)
				ge3:SetLabel(code)
				ge3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
					if not c9991013.checkfunc(re,e:GetLabel()) then return end
					local g1=Effect.GlobalEffect()
					g1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
					g1:SetCode(EVENT_CHAIN_SOLVING)
					g1:SetReset(RESET_CHAIN)
					g1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
						local val=e:GetLabel()
						if ev==val then
							Duel.NegateEffect(val)
						end
					end)
					g1:SetLabel(Duel.GetCurrentChain())
					Duel.RegisterEffect(g1,tp)
				end)
				Duel.RegisterEffect(ge3,tp)
			end
		end
	end)
	c:RegisterEffect(e1)
	--Attack Up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9991013,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e2:SetCountLimit(1)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
	end)
	e2:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.CheckLPCost(tp,1000) end
		Duel.PayLPCost(tp,1000)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(aux.TRUE)
		e1:SetValue(1000)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end)
	c:RegisterEffect(e2)
end
c9991013.Dazz_name_stellaris="Archangel"
function c9991013.checkfunc(re,code)
	return re:IsHasType(0x7f0) and re:GetHandler():IsCode(code)
end
