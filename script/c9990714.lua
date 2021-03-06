--Ormendahl, Profane Prince
require "expansions/script/c9990000"
function c9990714.initial_effect(c)
	Dazz.DFCBacksideCommonEffect(c)
	--Indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--Lifelink
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return ep~=tp
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Recover(tp,ev,REASON_EFFECT)
	end)
	c:RegisterEffect(e3)
	--Tribute
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return ep~=tp
	end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.Hint(HINT_CARD,0,9990714)
		local g=Duel.GetReleaseGroup(1-tp)
		if g:GetCount()>0 then
			if g:GetCount()>1 then
				Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_RELEASE)
				g=g:Select(1-tp,1,1,nil)
			end
			Duel.HintSelection(g)
			Duel.Release(g,REASON_RULE)
		else
			local g=Group.CreateGroup()
			Duel.ChangeTargetCard(ev,g)
			Duel.ChangeChainOperation(ev,function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if c:GetType()==TYPE_SPELL or c:GetType()==TYPE_TRAP then
					c:CancelToGrave(false)
				end
				Duel.Damage(tp,1000,REASON_EFFECT)
			end)
		end
	end)
	c:RegisterEffect(e4)
end