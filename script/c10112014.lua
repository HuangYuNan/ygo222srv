--炼金生命体·念动体
function c10112014.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(c10112014.fufilter),2,true)  
	--Destroy1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10112014,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c10112014.descon)
	e1:SetTarget(c10112014.destg)
	e1:SetOperation(c10112014.desop)
	c:RegisterEffect(e1)  
	--Destroy2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10112014,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c10112014.descon2)
	e2:SetTarget(c10112014.destg2)
	e2:SetOperation(c10112014.desop2)
	c:RegisterEffect(e2)  
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10112014,2))
	e3:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c10112014.drcost)
	e3:SetTarget(c10112014.drtg)
	e3:SetOperation(c10112014.drop)
	c:RegisterEffect(e3)
end

function c10112014.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end

function c10112014.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function c10112014.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.Draw(tp,1,REASON_EFFECT)
	if ct==0 then return end
	local dc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,dc)
	if dc:IsSetCard(0x5331) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and dc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SelectYesNo(tp,aux.Stringid(10112014,3)) then
		Duel.SpecialSummon(dc,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.ShuffleHand(tp)
end

function c10112014.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION 
end

function c10112014.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(c10112014.desfilter2,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end

function c10112014.desop2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c10112014.desfilter2,tp,0,LOCATION_SZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end

function c10112014.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL
end

function c10112014.desfilter2(c)
	return c:IsFacedown() and c:IsDestructable() 
end

function c10112014.desfilter1(c)
	return c:IsFaceup() and c:IsDestructable()
end

function c10112014.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c10112014.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	local tg=g:GetMaxGroup(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,tg:GetCount(),0,0)
end

function c10112014.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10112014.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if g:GetCount()>0 then
		local tg=g:GetMaxGroup(Card.GetAttack)
		Duel.Destroy(tg,REASON_EFFECT)
	end
end

function c10112014.fufilter(c)
	return c:IsFusionSetCard(0x5331) and c:GetLevel()==4
end

function c10112014.ritual_custom_condition(c,mg)
	local tp=c:GetControler()
	local ng=mg:Filter(Card.IsSetCard,nil,0x5331)
	return ng:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end

function c10112014.ritual_custom_condition2(c,mg)
	local tp=c:GetControler()
	local ng=mg:Filter(Card.IsSetCard,nil,0x5331)
	return ng:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),2,2,c)
end

function c10112014.ritual_custom_operation(c,mg)
	local tp=c:GetControler()
	local lv=c:GetLevel()
	local ng=mg:Filter(Card.IsSetCard,nil,0x5331)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local mat=ng:SelectWithSumEqual(tp,Card.GetRitualLevel,c:GetLevel(),1,99,c)
	c:SetMaterial(mat)
end
