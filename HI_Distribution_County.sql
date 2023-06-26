--2.Meals (NO SPLASH)

	select it.[Posting Date], it.[Agency No], DistributionType = 'No Splash'
	,DistributionCounty = it.[FBC County Code]
	, [Nutritious Pounds_County]= sum(-1*it.[Nutritious Pounds])
	,Meals_County = sum(it.[Nutritious Pounds]/-1.2)
	from [inventory transactions_V] it
	where it.[Agency No] not in ('1410960','1410958') -- remove hubs and add back RDO distributions
	and it.[Posting Date] between '7-1-2019' and getdate()
	and it.[Item Ledger Entry Type] = 1
	and it.[Nutritious Pounds] <> 0 
	group by it.[Posting Date], it.[Agency No],it.[FBC County Code]

	/*RDO*/
	union all 
	select t.DistributionDate, a.AgencyNo, 'RDO Agency'
	,a.CountyName
	,WeightDistributed = sum(t.WeightDistributed), MealsDistributed=sum(t.MealsDistributed)
	from [NTFB-OPS-01]..RDO_Agency_Transactions t
	inner join [NTFB-OPS-01]..RDO_Agency a on t.AgencyNo = a.AgencyNo
	where t.DistributionDate between '7-1-2019' and getdate()
	group by t.DistributionDate, a.AgencyNo,a.CountyName

	/*SNAP*/
	union all
		select AppDate, Program =  'SNAP',DistributionType = 'SNAP','Collin', NutLb =  sum([Collin Meals])*1.2, Meals= sum([Collin Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Dallas', sum([Dallas Meals])*1.2, sum([Dallas Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Delta', sum([Delta Meals])*1.2, sum([Delta Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where [Fiscal Year]  in (2020)
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Denton', sum([Denton Meals])*1.2, sum([Denton Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Ellis', sum([Ellis Meals])*1.2, sum([Ellis Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Fannin', sum([Fannin Meals])*1.2, sum([Fannin Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Grayson', sum([Grayson Meals])*1.2, sum([Grayson Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Hopkins', sum([Hopkins Meals])*1.2, sum([Hopkins Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Hunt', sum([Hunt Meals])*1.2, sum([Hunt Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Kaufman', sum([Kaufman Meals])*1.2, sum([Kaufman Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Lamar', sum([Lamar Meals])*1.2, sum([Lamar Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Navarro', sum([Navarro Meals])*1.2, sum([Navarro Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where [Fiscal Year]  in (2020)
		group by AppDate
		union 
		select AppDate, 'SNAP','SNAP','Rockwall', sum([Rockwall Meals])*1.2, sum([Rockwall Meals])
		from JetCeres45Dwh..[SNAP By County_V] c
		where AppDate >= '7-1-2019'
		group by AppDate