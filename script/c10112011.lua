--二重蒸馏
function c10112011.initial_effect(c) 
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10112011+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c10112011.target)
	e1:SetOperation(c10112011.activate)
	c:RegisterEffect(e1)
	wocao={}
end

function c10112011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c10112011.mfilter,tp,LOCATION_MZONE,0,nil)
		if mg:GetCount()<2 then return false end
		local tg=mg:Clone()
		local tgc=nil
		local mgc=mg:GetFirst()
		while mgc do
		   tgc=tg:GetFirst()
		  while tgc do 
			if mgc~=tgc and Duel.IsExistingMatchingCard(c10112011.synfilter,tp,LOCATION_EXTRA,0,1,nil,Group.FromCards(mgc,tgc),tp) then
			return true
			end
		   tgc=tg:GetNext()
		  end
		 mgc=mg:GetNext()
		end
		return false
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end

function c10112011.activate(e,tp,eg,ep,ev,re,r,rp)
	wocao[0]=Group.CreateGroup()
	wocao[0]:KeepAlive()
	local mg=Duel.GetMatchingGroup(c10112011.mfilter,tp,LOCATION_MZONE,0,nil)
	local fg=mg:Clone()
	local jg=mg:Clone()
	local kg=mg:Clone()
	local tg=mg:Clone()
	local ng=mg:Clone()
	local hg=mg:Clone()
		local sg1=Group.CreateGroup()
		local sg4=Group.CreateGroup()
		local sg5=Group.CreateGroup()
		local sg6=Group.CreateGroup()
		local tgc,ngc,hgc,kgc,sg3,sg2=nil
		local mgc=mg:GetFirst()
		while mgc do
		   tgc=tg:GetFirst()
		  while tgc do 
			if mgc~=tgc then
			  sg2=Duel.GetMatchingGroup(c10112011.synfilter,tp,LOCATION_EXTRA,0,nil,Group.FromCards(mgc,tgc),tp)
			  if sg2:GetCount()>0 then
				sg6:Merge(sg2)
			  end
			end
		   tgc=tg:GetNext()
		  end
		 mgc=mg:GetNext()
		end 
	if sg6:GetCount()<=0 then return end 
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112011,1))
		local sync=sg6:Select(tp,1,1,nil):GetFirst()
		local ngc=ng:GetFirst()
		 while ngc do
		   hgc=hg:GetFirst()
		   while hgc do 
			if ngc~=hgc and (sync:IsSynchroSummonable(hgc,Group.FromCards(ngc)) or sync:IsSynchroSummonable(ngc,Group.FromCards(hgc))) and Duel.IsExistingMatchingCard(c10112011.xyzfilter,tp,LOCATION_EXTRA,0,1,sync,Group.FromCards(hgc,ngc)) then
			  sg3=Duel.GetMatchingGroup(c10112011.xyzfilter,tp,LOCATION_EXTRA,0,sync,Group.FromCards(ngc,hgc))
			  sg1:Merge(sg3)
			end
		   hgc=hg:GetNext()
		   end
		 ngc=ng:GetNext()
		 end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112011,2))
		local xyzc=sg1:Select(tp,1,1,nil):GetFirst()	 
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112011,0))
		local jgc=jg:GetFirst()
		 while jgc do
		   kgc=kg:GetFirst()
		   while kgc do 
			if jgc~=kgc and (sync:IsSynchroSummonable(jgc,Group.FromCards(kgc)) or sync:IsSynchroSummonable(kgc,Group.FromCards(jgc))) and xyzc:IsXyzSummonable(Group.FromCards(kgc,jgc)) then
			  sg4:AddCard(kgc)
			  sg4:AddCard(jgc)
			end
		   kgc=kg:GetNext()
		   end
		 jgc=jg:GetNext()
		 end
		local mc1=sg4:Select(tp,1,1,nil):GetFirst()
		sg4:RemoveCard(mc1)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10112011,0))
		local fgc=sg4:GetFirst()
		 while fgc do   
			if (sync:IsSynchroSummonable(mc1,Group.FromCards(fgc)) or sync:IsSynchroSummonable(fgc,Group.FromCards(mc1))) and xyzc:IsXyzSummonable(Group.FromCards(mc1,fgc)) then
			sg5:AddCard(fgc)
			end
		 fgc=sg4:GetNext()
		 end
		local mc2=sg5:Select(tp,1,1,nil):GetFirst()
		local bg=Group.FromCards(mc1,mc2)
		  wocao[0]:AddCard(sync)
		  wocao[0]:AddCard(xyzc)
		  sync:SetMaterial(bg)
		  xyzc:SetMaterial(bg)
		  Duel.Overlay(xyzc,bg)  
		  Duel.SpecialSummonStep(sync,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		  Duel.SpecialSummonStep(xyzc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		  Duel.SpecialSummonComplete()
		  sync:CompleteProcedure()
		  xyzc:CompleteProcedure() 
end

function c10112011.mfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN+TYPE_XYZ) and c:IsCanBeSynchroMaterial() and c:IsCanBeXyzMaterial(nil) 
end

function c10112011.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg)
end

function c10112011.cfilter(c,sync,mg)
	return sync:IsSynchroSummonable(c,mg)
end

function c10112011.synfilter(c,mg,tp)
	return mg:IsExists(c10112011.cfilter,1,nil,c,mg) and Duel.IsExistingMatchingCard(c10112011.xyzfilter,tp,LOCATION_EXTRA,0,1,c,mg)
end

