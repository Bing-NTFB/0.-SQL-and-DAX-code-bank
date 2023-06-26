
 --Agencies by ZipCode

 ---1. Get Distributions
select x.[Posting Date], x.[Agency No]
,DistributionType = 'Splashed Agency'
, x.Zipcode, DistributionZipCode = case when s.zipcodeout is null then x.Zipcode else s.zipcodeout end 
, [Nutritious Pounds] = x.[Nutritious Pounds] * case when s.splashfactor is null then 1 else s.splashfactor end
, Meals = x.meals * case when s.splashfactor is null then 1 else s.splashfactor end
into #temp1

from 

(
select it.[Posting Date], it.[Agency No],Zipcode = left(a.[ZIP Code],5),[Nutritious Pounds] = sum(it.[Nutritious Pounds])/-1,  Meals = Sum(it.[Nutritious Pounds]/-1.2)
from [inventory transactions_V] it
inner join agency_v a on it.[agency no] = a.no
where a.[FBC Agency Category Code] in ('CSFP','CP','FFF','F4H','MPD','MP','MPT3','MPTFR','MPT4','MPT2','MSK','NN','OSP','NS','P','PD','RP','SNL','MPT')
and it.[Posting Date] between '7-1-2022' and '6-30-2023'
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
and it.[Posting Date] between '7-1-2022' and '6-30-2023'
and [Nutritious Pounds] <> 0.0
and len(a.[ZIP Code]) >=5
and it.[Agency No] not in ('1410960','1410958')
group by it.[Posting Date], it.[Agency No],  left(a.[ZIP Code],5)

---2. Aggregate Meals
 select FiscalYear, DistributionZipCode, [Agency No], AgencyName = b.[Name], Meals, rn_Z 
 into #temp3 
 from (
select 
FiscalYear = year(dateadd(mm,6,[posting date])), [Agency No], DistributionZipCode, Meals = sum(Meals), rn_Z = ROW_NUMBER() over( partition by year(dateadd(mm,6,[posting date])), DistributionZipCode order by sum(Meals) desc)
from #temp1
group by [Agency No], DistributionZipCode,year(dateadd(mm,6,[posting date]))
 ) x
 left join Agency_V b on x.[Agency No] = b.[No]
 where rn_Z <=5
 order by 1,2,rn_Z




---3. Reorder to get top 5
select A.*
, B.Top_2_Agency, B.Top_2_Meals, b.Top_2_No
, c.Top_3_Agency, c.Top_3_Meals, c.Top_3_No
, d.Top_4_Agency, d.Top_4_Meals, d.Top_4_No
, e.Top_5_Agency, e.Top_5_Meals, e.Top_5_No
from 
	 (select FiscalYear, DistributionZipCode
	 , Top_1_Agency = case when rn_Z = 1 then AgencyName end
	 , Top_1_Meals = case when rn_Z = 1 then Meals end
	 , Top_1_No = case when rn_Z = 1 then [Agency No] end
	 from #temp3
	 where rn_Z =1) A
 left join 
	  (select FiscalYear, DistributionZipCode
	 , Top_2_Agency = case when rn_Z = 2 then AgencyName end
	 , Top_2_Meals = case when rn_Z = 2 then Meals end
	 , Top_2_No = case when rn_Z = 2 then [Agency No] end
	from #temp3
	 where rn_Z =2) B on a.FiscalYear = b.FiscalYear and a.DistributionZipCode = b.DistributionZipCode
 left join 
	  (select FiscalYear, DistributionZipCode
	 , Top_3_Agency = case when rn_Z = 3 then AgencyName end
	 , Top_3_Meals = case when rn_Z = 3 then Meals end
	 , Top_3_No = case when rn_Z = 3 then [Agency No] end
	from #temp3
	 where rn_Z =3) C on a.FiscalYear = c.FiscalYear and a.DistributionZipCode = c.DistributionZipCode
   left join 
	  (select FiscalYear, DistributionZipCode
	 , Top_4_Agency = case when rn_Z = 4 then AgencyName end
	 , Top_4_Meals = case when rn_Z = 4 then Meals end
	 , Top_4_No = case when rn_Z = 4 then [Agency No] end
	from #temp3
	 where rn_Z =4) D on a.FiscalYear = D.FiscalYear and a.DistributionZipCode = D.DistributionZipCode
  left join 
	(select FiscalYear, DistributionZipCode
	, Top_5_Agency = case when rn_Z = 5 then AgencyName end
	, Top_5_Meals = case when rn_Z = 5 then Meals end
	, Top_5_No = case when rn_Z = 5 then [Agency No] end
	from #temp3
	where rn_Z =5) E on a.FiscalYear = e.FiscalYear and a.DistributionZipCode = e.DistributionZipCode
