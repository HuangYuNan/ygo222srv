--fuck four
function c10112015.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10112015.cost)
	e1:SetTarget(c10112015.target)
	e1:SetOperation(c10112015.activate)
	c:RegisterEffect(e1) 
	wocao={}
end

function c10112015.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetFlagEffect(tp,10112015)==0 end
	Duel.RegisterFlagEffect(tp,10112015,0,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(0,1)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end

function c10112015.fgfilter(c)
	return c:IsCanBeRitualMaterial(nil) and c:IsCanBeFusionMaterial(nil) and c:IsCanBeSynchroMaterial() and c:IsCanBeXyzMaterial(nil) and c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0x5331)
end

function c10112015.fusfilter(c,e,tp,mg,ritc)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(mg,nil) and Duel.IsExistingMatchingCard(c10112015.synfilter,tp,LOCATION_EXTRA,0,1,c,mg,tp,ritc,c)
end

function c10112015.synfilter(c,mg,tp,ritc,fusc)
	return c~=ritc and mg:IsExists(c10112015.cfilter,1,nil,c,mg) and Duel.IsExistingMatchingCard(c10112015.xyzfilter,tp,LOCATION_EXTRA,0,1,c,mg,ritc,fusc)
end

function c10112015.cfilter(c,sync,mg)
	return sync:IsSynchroSummonable(c,mg)
end

function c10112015.xyzfilter(c,mg,ritc,fusc)
	return c:IsXyzSummonable(mg) and c~=fusc and c~=ritc
end

function c10112015.ritfilter(c,e,tp,mg,ritc,n)
	if bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) or (c~=ritc and n==1) then return false end
	if c:IsCode(10112014) then return c:ritual_custom_condition2(mg) and Duel.IsExistingMatchingCard(c10112012.fusfilter,tp,LOCATION_EXTRA,0,1,c,e,tp,mg,c) end
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),2,2,c) and Duel.IsExistingMatchingCard(c10112012.fusfilter,tp,LOCATION_EXTRA,0,1,c,e,tp,mg,c)
end

function c10112015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local fg=Duel.GetMatchingGroup(c10112015.fgfilter,tp,LOCATION_MZONE,0,nil)
		local ng=fg:Clone()
		local ngc=nil
		if fg:GetCount()<2 then return false end
		local fgc=fg:GetFirst()
		while fgc do
		  ngc=ng:GetFirst()
		  while ngc do
			if ngc~=fgc and Duel.IsExistingMatchingCard(c10112015.ritfilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp,Group.FromCards(fgc,ngc),nil,0) and Duel.GetLocationCount(tp,LOCATION_MZONE)>=2 then 
			return true 
			end
		  ngc=ng:GetNext() 
		  end
		 fgc=fg:GetNext()
		end
	return false
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,tp,LOCATION_EXTRA+LOCATION_HAND)
end

function c10112015.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	wocao[0]=Group.CreateGroup()
	wocao[0]:KeepAlive()  
		local fg=Duel.GetMatchingGroup(c10112015.fgfilter,tp,LOCATION_MZONE,0,nil)
		local ng=fg:Clone()
		local hg=fg:Clone()
		local sg=fg:Clone() 
		local jg=fg:Clone()  
		local kg=fg:Clone()
		local rg=fg:Clone() 
		local tg=fg:Clone() 
		local yg=fg:Clone()
		local ug=fg:Clone()
		local og=fg:Clone()
		local ngc,sg2,sg3,ygc,sgc,kgc,sg7,ogc,sg9=nil
		local sg1=Group.CreateGroup()
		local sg4=Group.CreateGroup()
		local sg5=Group.CreateGroup()
		local sg6=Group.CreateGroup()
		local sg8=Group.CreateGroup()
		local sgx=Group.CreateGroup()
		local fgc=fg:GetFirst()
		while fgc do
		  ngc=ng:GetFirst()
		  while ngc do
			if ngc~=fgc then 
			  sg2=Duel.GetMatchingGroup(c10112015.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,nil,e,tp,Group.FromCards(fgc,ngc),nil,0)
			  if sg2:GetCount()>0 then
				sg1:Merge(sg2)
			  end
			end
		  ngc=ng:GetNext() 
		  end
		 fgc=fg:GetNext()
		end  
	if sg1:GetCount()<=0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end 
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112015,1))
		local ritc=sg1:Select(tp,1,1,nil):GetFirst()
		local hgc=hg:GetFirst()
		 while hgc do
		   sgc=sg:GetFirst()
		   while sgc do 
			if hgc~=sgc and Duel.IsExistingMatchingCard(c10112015.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,nil,e,tp,Group.FromCards(hgc,sgc),ritc,1) and Duel.IsExistingMatchingCard(c10112015.fusfilter,tp,LOCATION_EXTRA,0,1,ritc,e,tp,Group.FromCards(hgc,sgc),ritc) then
			  sg3=Duel.GetMatchingGroup(c10112015.fusfilter,tp,LOCATION_EXTRA,0,ritc,e,tp,Group.FromCards(sgc,hgc),ritc)
			  sg4:Merge(sg3)
			end
		   sgc=sg:GetNext()
		   end
		 hgc=hg:GetNext()
		 end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112015,2))
		local fusc=sg4:Select(tp,1,1,nil):GetFirst()   
		local tgc=tg:GetFirst()
		 while tgc do
		   ygc=yg:GetFirst()
		   while ygc do 
			if tgc~=ygc and Duel.IsExistingMatchingCard(c10112015.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,nil,e,tp,Group.FromCards(tgc,ygc),ritc,1) and fusc:CheckFusionMaterial(Group.FromCards(tgc,ygc),nil)  and Duel.IsExistingMatchingCard(c10112015.synfilter,tp,LOCATION_EXTRA,0,1,fusc,Group.FromCards(tgc,ygc),tp,ritc,fusc) then
			  sg7=Duel.GetMatchingGroup(c10112015.synfilter,tp,LOCATION_EXTRA,0,fusc,Group.FromCards(tgc,ygc),tp,ritc,fusc)
			  sg8:Merge(sg7)
			end
		   ygc=yg:GetNext()
		   end
		 tgc=tg:GetNext()
		 end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112015,3))
		local sync=sg8:Select(tp,1,1,nil):GetFirst()   
		local ugc=ug:GetFirst()
		 while ugc do
		   ogc=og:GetFirst()
		   while ogc do 
			if ugc~=ogc and Duel.IsExistingMatchingCard(c10112015.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,nil,e,tp,Group.FromCards(ogc,ugc),ritc,1) and fusc:CheckFusionMaterial(Group.FromCards(ugc,ogc),nil) and (sync:IsSynchroSummonable(ogc,Group.FromCards(ugc)) or sync:IsSynchroSummonable(ugc,Group.FromCards(ogc))) and Duel.IsExistingMatchingCard(c10112015.xyzfilter,tp,LOCATION_EXTRA,0,1,sync,Group.FromCards(ugc,ogc),ritc,fusc) then
			  sg9=Duel.GetMatchingGroup(c10112015.xyzfilter,tp,LOCATION_EXTRA,0,sync,Group.FromCards(ugc,ogc),ritc,fusc)
			  sgx:Merge(sg9)
			end
		   ogc=og:GetNext()
		   end
		 ugc=ug:GetNext()
		 end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112015,4))
		local xyzc=sgx:Select(tp,1,1,nil):GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112011,0))
		local jgc=jg:GetFirst()
		 while jgc do
		   kgc=kg:GetFirst()
		   while kgc do 
			if jgc~=kgc and fusc:CheckFusionMaterial(Group.FromCards(jgc,kgc),nil) and Duel.IsExistingMatchingCard(c10112012.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,fusc,e,tp,Group.FromCards(jgc,kgc),ritc,1) and (sync:IsSynchroSummonable(jgc,Group.FromCards(kgc)) or sync:IsSynchroSummonable(kgc,Group.FromCards(jgc))) and xyzc:IsXyzSummonable(Group.FromCards(jgc,kgc)) then
			  sg5:AddCard(kgc)
			  sg5:AddCard(jgc)
			end
		   kgc=kg:GetNext()
		   end
		 jgc=jg:GetNext()
		 end
		local mc1=sg5:Select(tp,1,1,nil):GetFirst()
		sg5:RemoveCard(mc1)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112011,0))
		local rgc=sg5:GetFirst()
		 while rgc do   
			if fusc:CheckFusionMaterial(Group.FromCards(mc1,rgc),nil) and Duel.IsExistingMatchingCard(c10112012.ritfilter,tp,LOCATION_EXTRA+LOCATION_HAND,0,1,fusc,e,tp,Group.FromCards(mc1,rgc),ritc,1) and (sync:IsSynchroSummonable(mc1,Group.FromCards(rgc)) or sync:IsSynchroSummonable(rgc,Group.FromCards(mc1))) and xyzc:IsXyzSummonable(Group.FromCards(mc1,rgc)) then
			sg6:AddCard(rgc)
			end
		 rgc=sg5:GetNext()
		 end
		local mc2=sg6:Select(tp,1,1,nil):GetFirst()
		local bg=Group.FromCards(mc1,mc2)
		  wocao[0]:AddCard(sync)
		  wocao[0]:AddCard(xyzc)
		  ritc:SetMaterial(bg)
		  fusc:SetMaterial(bg)
		  fusc:SetMaterial(bg)
		  xyzc:SetMaterial(bg)
		  Duel.Overlay(xyzc,bg)  
		  Duel.SpecialSummonStep(ritc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		  Duel.SpecialSummonStep(fusc,SUMMON_TYPE_FUSION,tp,tp,false,true,POS_FACEUP)
		  Duel.SpecialSummonStep(sync,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		  Duel.SpecialSummonStep(xyzc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		  Duel.SpecialSummonComplete()
		  ritc:CompleteProcedure()
		  fusc:CompleteProcedure()
		  sync:CompleteProcedure()
		  xyzc:CompleteProcedure()
		  local e1=Effect.CreateEffect(c)
		  e1:SetType(EFFECT_TYPE_FIELD)
		  e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		  e1:SetTargetRange(1,0)
		  e1:SetReset(RESET_PHASE+PHASE_END)
		  Duel.RegisterEffect(e1,tp)
end

