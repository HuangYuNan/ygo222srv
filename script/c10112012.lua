--双重蒸馏·固结
function c10112012.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10112012+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c10112012.target)
	e1:SetOperation(c10112012.activate)
	c:RegisterEffect(e1)	
end

function c10112012.fgfilter(c)
	return c:IsCanBeRitualMaterial(nil) and c:IsCanBeFusionMaterial(nil) and c:IsFaceup() and c:GetLevel()>0
end

function c10112012.fusfilter(c,e,tp,mg)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(mg,nil)
end

function c10112012.ritfilter(c,e,tp,mg,ritc,n)
	if bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) or (c~=ritc and n==1) then return false end
	if c:IsCode(10112014) then return c:ritual_custom_condition2(mg) and Duel.IsExistingMatchingCard(c10112012.fusfilter,tp,LOCATION_EXTRA,0,1,c,e,tp,mg) end
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),2,2,c) and Duel.IsExistingMatchingCard(c10112012.fusfilter,tp,LOCATION_EXTRA,0,1,c,e,tp,mg)
end

function c10112012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local fg=Duel.GetMatchingGroup(c10112012.fgfilter,tp,LOCATION_MZONE,0,nil)
		local ng=fg:Clone()
		local ngc=nil
		if fg:GetCount()<2 then return false end
		local fgc=fg:GetFirst()
		while fgc do
		  ngc=ng:GetFirst()
		  while ngc do
			if ngc~=fgc and Duel.IsExistingMatchingCard(c10112012.ritfilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp,Group.FromCards(fgc,ngc),nil,0) then 
			return true 
			end
		  ngc=ng:GetNext() 
		  end
		 fgc=fg:GetNext()
		end
	return false
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA+LOCATION_HAND)
end

function c10112012.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		local fg=Duel.GetMatchingGroup(c10112012.fgfilter,tp,LOCATION_MZONE,0,nil)
		local ng=fg:Clone()
		local hg=fg:Clone()
		local sg=fg:Clone() 
		local jg=fg:Clone()  
		local kg=fg:Clone()
		local rg=fg:Clone()  
		local ngc,sg2,sg3,sgc,kgc=nil
		local sg1=Group.CreateGroup()
		local sg4=Group.CreateGroup()
		local sg5=Group.CreateGroup()
		local sg6=Group.CreateGroup()
		local fgc=fg:GetFirst()
		while fgc do
		  ngc=ng:GetFirst()
		  while ngc do
			if ngc~=fgc then 
			  sg2=Duel.GetMatchingGroup(c10112012.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,nil,e,tp,Group.FromCards(fgc,ngc),nil,0)
			  if sg2:GetCount()>0 then
				sg1:Merge(sg2)
			  end
			end
		  ngc=ng:GetNext() 
		  end
		 fgc=fg:GetNext()
		end  
	if sg1:GetCount()<=0 then return end 
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112012,1))
		local ritc=sg1:Select(tp,1,1,nil):GetFirst()
		local hgc=hg:GetFirst()
		 while hgc do
		   sgc=sg:GetFirst()
		   while sgc do 
			if hgc~=sgc and Duel.IsExistingMatchingCard(c10112012.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,nil,e,tp,Group.FromCards(hgc,sgc),ritc,1) and Duel.IsExistingMatchingCard(c10112012.fusfilter,tp,LOCATION_EXTRA,0,1,ritc,e,tp,Group.FromCards(hgc,sgc)) then
			  sg3=Duel.GetMatchingGroup(c10112012.fusfilter,tp,LOCATION_EXTRA,0,ritc,e,tp,Group.FromCards(sgc,hgc))
			  sg4:Merge(sg3)
			end
		   sgc=sg:GetNext()
		   end
		 hgc=hg:GetNext()
		 end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112012,2))
		local fusc=sg4:Select(tp,1,1,nil):GetFirst()   
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112012,0))
		local jgc=jg:GetFirst()
		 while jgc do
		   kgc=kg:GetFirst()
		   while kgc do 
			if jgc~=kgc and fusc:CheckFusionMaterial(Group.FromCards(jgc,kgc),nil) and Duel.IsExistingMatchingCard(c10112012.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,fusc,e,tp,Group.FromCards(jgc,kgc),ritc,1) then
			  sg5:AddCard(kgc)
			  sg5:AddCard(jgc)
			end
		   kgc=kg:GetNext()
		   end
		 jgc=jg:GetNext()
		 end
		local mc1=sg5:Select(tp,1,1,nil):GetFirst()
		sg5:RemoveCard(mc1)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112012,0))
		local rgc=sg5:GetFirst()
		 while rgc do   
			if fusc:CheckFusionMaterial(Group.FromCards(mc1,rgc),nil) and Duel.IsExistingMatchingCard(c10112012.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,fusc,e,tp,Group.FromCards(mc1,rgc),ritc,1) then
			sg6:AddCard(rgc)
			end
		 rgc=sg5:GetNext()
		 end
		local mc2=sg6:Select(tp,1,1,nil):GetFirst()
		local bg=Group.FromCards(mc1,mc2)
		  ritc:SetMaterial(bg)
		  fusc:SetMaterial(bg)
		  Duel.Release(bg,REASON_COST+REASON_FUSION+REASON_RITUAL+REASON_MATERIAL)
		  Duel.SpecialSummonStep(ritc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		  Duel.SpecialSummonStep(fusc,SUMMON_TYPE_FUSION,tp,tp,false,true,POS_FACEUP)
		  Duel.SpecialSummonComplete()
		  ritc:CompleteProcedure()
		  fusc:CompleteProcedure()
end


