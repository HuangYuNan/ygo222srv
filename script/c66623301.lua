--校园偶像JK娜娜
require("/expansions/script/c37564765")
require("/expansions/script/c37564777")
function c66623301.initial_effect(c)
	senya.setreg(c,66623301,66623300)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66623301,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(senya.sesrtg(LOCATION_DECK,c66623301.filter))
	e1:SetOperation(senya.sesrop(LOCATION_DECK,c66623301.filter))
	c:RegisterEffect(e1)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetDescription(aux.Stringid(37564777,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(prim.szcost)
	e2:SetTarget(prim.sethtg)
	e2:SetOperation(prim.sethop)
	c:RegisterEffect(e2)
end
function c66623301.filter(c)
	return c:IsHasEffect(66623300) and c:IsType(TYPE_RITUAL)
end