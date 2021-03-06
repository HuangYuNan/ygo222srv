--幻想曲T致命旋律 杀戮机器
function c60150917.initial_effect(c)
	 --synchro summon
    aux.AddSynchroProcedure(c,c60150917.tfilter,aux.NonTuner(c60150917.tfilter),1)
    c:EnableReviveLimit()
	--special summon rule
    local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60150917,1))
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c60150917.spcon2)
    e2:SetOperation(c60150917.spop2)
    c:RegisterEffect(e2)
	 --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(60150917,2))
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c60150917.descon)
    e1:SetTarget(c60150917.destg)
    e1:SetOperation(c60150917.desop)
    c:RegisterEffect(e1)
	 --disable
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(54702678,0))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_BATTLE_DESTROYING)
    e3:SetCondition(c60150917.discon)
    e3:SetOperation(c60150917.disop)
    c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(60150503,0))
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e4:SetCategory(CATEGORY_DECKDES)
    e4:SetCode(EVENT_BATTLE_DESTROYING)
    e4:SetCondition(c60150917.eqcon)
    e4:SetTarget(c60150917.eqtg)
    e4:SetOperation(c60150917.activate)
    c:RegisterEffect(e4)
	--spsummon2
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(58069384,2))
    e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_CAL)
    e5:SetCode(EVENT_TO_GRAVE)
    e5:SetCondition(c60150917.spcon)
    e5:SetTarget(c60150917.sptg)
    e5:SetOperation(c60150917.spop)
    c:RegisterEffect(e5)
end
function c60150917.tfilter(c)
    return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c60150917.sprfilter1(c,tp)
    local lv=c:GetLevel()
    return c:IsFaceup() and c:IsType(TYPE_TOKEN) and c:IsSetCard(0x6b23) and c:IsCanBeSynchroMaterial()
        and Duel.IsExistingMatchingCard(c60150917.sprfilter2,tp,LOCATION_MZONE,0,1,nil,lv) 
		or (c:IsFaceup() and c:IsType(TYPE_TOKEN) and c:IsSetCard(0x6b23) and lv==7)
end
function c60150917.sprfilter2(c,lv)
    return c:IsFaceup() and c:GetLevel()~=lv and c:GetLevel()+lv==7 and c:IsType(TYPE_TOKEN)
	and c:IsSetCard(0x6b23) and c:IsCanBeSynchroMaterial()
end
function c60150917.spcon2(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
        and Duel.IsExistingMatchingCard(c60150917.sprfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c60150917.spop2(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
    local g1=Duel.SelectMatchingCard(tp,c60150917.sprfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
    local g2=Duel.SelectMatchingCard(tp,c60150917.sprfilter2,tp,LOCATION_MZONE,0,1,1,nil,g1:GetFirst():GetLevel())
    g1:Merge(g2)
    Duel.Release(g1,REASON_COST)
end
function c60150917.descon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c60150917.filter(c)
    return c:IsDestructable()
end
function c60150917.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150917.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,nil) end
    local g=Duel.GetMatchingGroup(c60150917.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c60150917.desop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectMatchingCard(tp,c60150917.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,2,nil)
    if g:GetCount()>0 then
        Duel.HintSelection(g)
        Duel.Destroy(g,REASON_EFFECT)
    end
end
function c60150917.discon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local bc=c:GetBattleTarget()
    return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsStatus(STATUS_OPPO_BATTLE) 
end
function c60150917.disop(e,tp,eg,ep,ev,re,r,rp)
    local bc=e:GetHandler():GetBattleTarget()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DISABLE)
    e1:SetReset(RESET_EVENT+0x57a0000)
    bc:RegisterEffect(e1)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_DISABLE_EFFECT)
    e2:SetReset(RESET_EVENT+0x57a0000)
    bc:RegisterEffect(e2)
end
function c60150917.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c60150917.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetBattleTarget() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c60150917.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetHandler():GetBattleTarget():GetCode()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_DECK+LOCATION_EXTRA,nil,code)
	Duel.Destroy(g,REASON_EFFECT)
		Duel.BreakEffect()
		local c=e:GetHandler()
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE+LOCATION_REMOVED)
		if ct>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			e1:SetValue(ct*300)
			c:RegisterEffect(e1)
		end
		local deck=Duel.GetFieldGroup(tp,0,LOCATION_DECK+LOCATION_EXTRA)
		if deck:GetCount()~=0 then Duel.ShuffleDeck(1-tp) end
end
function c60150917.spcon(e,tp,eg,ep,ev,re,r,rp)
    return rp~=tp and bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():GetPreviousControler()==tp
end
function c60150917.spfilter(c,e,tp)
    return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x6b23) and c:IsFaceup()
end
function c60150917.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.IsExistingMatchingCard(c60150917.spfilter,tp,0,LOCATION_DECK,1,nil) end
end
function c60150917.spop(e,tp,eg,ep,ev,re,r,rp)
    local cg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
    Duel.ConfirmCards(tp,cg)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60150917,3))
    local g=Duel.SelectMatchingCard(tp,c60150917.spfilter,tp,0,LOCATION_DECK,1,1,nil)
    local tc=g:GetFirst()
    if tc then
        Duel.ShuffleDeck(1-tp)
        Duel.MoveSequence(tc,0)
        Duel.ConfirmDecktop(1-tp,1)
    end
end