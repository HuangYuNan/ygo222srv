function c73203094.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73203094,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,73203094)
	e1:SetCost(c73203094.hspcost)
	e1:SetTarget(c73203094.hsptg)
	e1:SetOperation(c73203094.hspop)
	c:RegisterEffect(e1)
end
function c73203094.rfilter(c)
	return c:IsSetCard(0x732) and not c:IsCode(73203094) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c73203094.thfilter(c)
  return c:IsSetCard(0x732) and c:GetLevel()==4 and c:IsAbleToSpecialSummon(e,0,tp,false,false)
end
function c73203094.hspcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73203094.rfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c73203094.rfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c73203094.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c73203094.hspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
   if c:IsRelateToEffect(e) then
     Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
     Duel.BreakEffect()
     if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux,Stringid(73203094,1)) then
          Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPECIAL_SUMMON)
          local sg=DuelSelectMatchingCard(tp,73203094,thfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
          if sg:GetCount()>0 then 
             Duel.SpecialSummon(sg:GetFirst(),c,0,tp,tp,false,false,POS_FACEUP)
          end
      end
   end
end