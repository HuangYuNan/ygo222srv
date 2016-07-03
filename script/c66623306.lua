--超级偶像娜娜
require("/expansions/script/c37564765")
require("/expansions/script/c37564777")
function c66623306.initial_effect(c)
	senya.setreg(c,66623306,66623300)
	c:EnableReviveLimit()
	prim.nnr(c,c66623306.con,senya.sesrop(LOCATION_DECK,c66623306.filter),aux.Stringid(66623306,2),CATEGORY_TOHAND+CATEGORY_SEARCH)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66623306,1))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(senya.discost(1))
	e2:SetTarget(c66623306.tdtg)
	e2:SetOperation(c66623306.tdop)
	c:RegisterEffect(e2)
end
function c66623306.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66623306.filter,tp,LOCATION_DECK,0,1,nil)
end
function c66623306.filter(c)
	return c:IsHasEffect(66623399) and c:IsAbleToHand()
end
function c66623306.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,0,0)
end
function c66623306.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tc=g:RandomSelect(tp,1):GetFirst()
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end