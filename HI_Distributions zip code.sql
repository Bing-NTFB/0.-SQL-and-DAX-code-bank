
/*2 Meals
--splash
--non splash
--SNAP
--RDO
*/

/*
SPlash codes
"CSFP","CP","FFF","F4H","MPD","MP","MPT3","MPTFR","MPT4","MPT2","MSK","NN","OSP","NS","P","PD","RP","SNL","MPT"
*/
select x.[Posting Date], x.[Agency No]
,DistributionType = 'Splashed Agency'
, x.Zipcode, DistributionZipCode = case when s.zipcodeout is null then x.Zipcode else s.zipcodeout end 
, [Nutritious Pounds] = x.[Nutritious Pounds] * case when s.splashfactor is null then 1 else s.splashfactor end
, Meals = x.meals * case when s.splashfactor is null then 1 else s.splashfactor end
from (
select it.[Posting Date], it.[Agency No],Zipcode = left(a.[ZIP Code],5),[Nutritious Pounds] = sum(it.[Nutritious Pounds])/-1,  Meals = Sum(it.[Nutritious Pounds]/-1.2)
from [inventory transactions_V] it
inner join agency_v a on it.[agency no] = a.no
where a.[FBC Agency Category Code] in ('CSFP','CP','FFF','F4H','MPD','MP','MPT3','MPTFR','MPT4','MPT2','MSK','NN','OSP','NS','P','PD','RP','SNL','MPT')
and it.[Posting Date] between '7-1-2019' and getdate()
and [Nutritious Pounds] <> 0.0
and len(a.[ZIP Code]) >=5
and it.[Agency No] not in ('1410960','1410958')
group by it.[Posting Date], it.[Agency No],  left(a.[ZIP Code],5)
) x
left join [NTFB-OPS-01].dbo.SplashFactor s on x.[ZIPCode] = s.zipcodein
--where s.splashfactor is null 

union all
/*Non Splash*/
select it.[Posting Date], it.[Agency No]
,DistributionType = 'Normal Agency'
,Zipcode = left(a.[ZIP Code],5),DistributionZipCode = left(a.[ZIP Code],5), [Nutritious Pounds] = sum(it.[Nutritious Pounds])/-1, Meals = Sum(it.[Nutritious Pounds]/-1.2)
from [inventory transactions_V] it
inner join agency_v a on it.[agency no] = a.no
where a.[FBC Agency Category Code] not in ('CSFP','CP','FFF','F4H','MPD','MP','MPT3','MPTFR','MPT4','MPT2','MSK','NN','OSP','NS','P','PD','RP','SNL','MPT')
and it.[Posting Date] between '7-1-2019' and getdate()
and [Nutritious Pounds] <> 0.0
and len(a.[ZIP Code]) >=5
and it.[Agency No] not in ('1410960','1410958')
group by it.[Posting Date], it.[Agency No],  left(a.[ZIP Code],5)


union all
/*RDO agencies*/
select t.DistributionDate, a.AgencyNo, 'RDO Agency',a.Zipcode, a.Zipcode, t.WeightDistributed, t.MealsDistributed
from [NTFB-OPS-01]..RDO_Agency_Transactions t
inner join [NTFB-OPS-01]..RDO_Agency a on t.AgencyNo = a.AgencyNo

--use Hardcoded historical for prior years at county level per Anne -4/20/23


union all
/*SNAP meals  ***NOTE does not match county level data supplied by Alana
**changes by year**
**FY19
App2Meal =>  
Reapp2Meal =>  

**FY20
App2Meal =>  
Reapp2Meal =>  

**FY21
App2Meal =>  971
Reapp2Meal =>  1081.4

**FY22
App2Meal => 1477.3
Reapp2Meal => 1805.5

**FY23
App to meals = 1 => 1913.3
ReApp to meals = 1 => 2093.8
*/


select 
EncounterDate, AgencyNo = 'SNAP'
,DistributionType = 'SNAP'
, Zipcode,Zipcode
,[Nutritious Pounds] = 1.2* sum(Case when EncounterDate between '7-1-2022' and '6-30-2023' then 
									Case when applicationtype = 'Redetermination' then 2093.8 else 1913.3 end
								when EncounterDate between '7-1-2021' and '6-30-2022' then 
									Case when applicationtype = 'Redetermination' then 1805.5 else 1477.3 end
								when EncounterDate between '7-1-2020' and '6-30-2021' then 
									Case when applicationtype = 'Redetermination' then 1081.4 else 971 end
								when EncounterDate between '7-1-2019' and '6-30-2020' then 
									Case when applicationtype = 'Redetermination' then 0.5 else 0.3 end
								else 0 end)
, Meals = sum(Case when EncounterDate between '7-1-2022' and '6-30-2023' then 
									Case when applicationtype = 'Redetermination' then 2093.8 else 1913.3 end
								when EncounterDate between '7-1-2021' and '6-30-2022' then 
									Case when applicationtype = 'Redetermination' then 1805.5 else 1477.3 end
								when EncounterDate between '7-1-2020' and '6-30-2021' then 
									Case when applicationtype = 'Redetermination' then 1081.4 else 971 end
								when EncounterDate between '7-1-2019' and '6-30-2020' then 
									Case when applicationtype = 'Redetermination' then 0.5 else 0.3 end
								else 0 end)
from [NTFB-OPS-01]..SNAP_by_Zipcode 
where EncounterDate>= '7-1-2020'
group by EncounterDate, Zipcode

union

select AppDate, Program =  'SNAP',DistributionType = 'SNAP',Zipcode='75034',Zipcode2='75034', NutLb =  sum([Collin Meals])*1.2, Meals= sum([Collin Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year] in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75217','75217', sum([Dallas Meals])*1.2, sum([Dallas Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75432','75432', sum([Delta Meals])*1.2, sum([Delta Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75067','75067', sum([Denton Meals])*1.2, sum([Denton Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75165','75165', sum([Ellis Meals])*1.2, sum([Ellis Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75418','75418', sum([Fannin Meals])*1.2, sum([Fannin Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75020','75020', sum([Grayson Meals])*1.2, sum([Grayson Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75482','75482', sum([Hopkins Meals])*1.2, sum([Hopkins Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year] in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75401','75401', sum([Hunt Meals])*1.2, sum([Hunt Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75126','75126', sum([Kaufman Meals])*1.2, sum([Kaufman Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75460','75460', sum([Lamar Meals])*1.2, sum([Lamar Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year] in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75110','75110', sum([Navarro Meals])*1.2, sum([Navarro Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
union 
select AppDate, 'SNAP','SNAP','75087','75087', sum([Rockwall Meals])*1.2, sum([Rockwall Meals])
from JetCeres45Dwh..[SNAP By County_V] c
where [Fiscal Year]  in (2020)
group by AppDate
