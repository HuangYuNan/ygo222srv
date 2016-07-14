--Prim-梦见
if not pcall(function() require("expansions/script/c37564765") end) then require("script/c37564765") end
function c37564613.initial_effect(c)
	senya.setreg(c,37564613,37564600)
	senya.bmdamchk(c,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c37564613.spcon)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564613,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(senya.bmdamchkcon)
	e3:SetCost(c37564613.atkcost)
	e3:SetOperation(c37564613.atkop)
	c:RegisterEffect(e3)
end
function c37564613.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0,nil)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c37564613.swwcostfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsHasEffect(37564600) and not c:IsPublic()
end
function c37564613.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=1
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c37564613.swwcostfilter,tp,LOCATION_HAND,0,1,nil) and c:GetFlagEffect(37564613)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c37564613.swwcostfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabel(g:GetFirst():GetTextAttack())
	c:RegisterFlagEffect(37564613,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c37564613.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and bc then
		local val=e:GetLabel()
		if not val then return end
		if val<0 then val=0 end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(val)
		c:RegisterEffect(e1)
	end
end