
select 
it.[Entry No]
,it.[Posting Date]
,it.[Item No]
,it.[FBC County Code]
,it.[Global Dimension 1 Code]
,it.[Global Dimension 2 Code]
,it.[Location Code]
,it.[Agency No]
,it.[Item Ledger Entry Type]
,it.Quantity
,it.[Cost Amount Actual]
,it.[Gross Weight]
,it.[Nutritious Pounds]
,it.[Shipment Method Code]
,it.[UNC Product Category Code]
,it.[UNC Product Type Code]
,ProgramGroup = case		 when it.[Location Code] <> 'PFC' then 'Retail Direct'
							 when it.[Global Dimension 2 Code] = 'PCPF4K' then 'Food 4 Kids'
							 when it.[Global Dimension 2 Code] = 'PCPSCHPAN' then 'School Pantry'
							 when it.[Global Dimension 2 Code] = 'PSPCSFP' and it.[UNC Product Type Code] = '28'  then 'Senior Produce'
							 when it.[Global Dimension 2 Code] = 'PSPCSFP' and i.[FBC Product Classification] = 'CSFP' then 'Senior'
							 when it.[Global Dimension 2 Code] = 'PSPCSFP' then 'Senior Bonus Boxes'
							 when it.[Global Dimension 2 Code] = 'PMAIN' then 'Partner Agencies'
							 when it.[Global Dimension 2 Code] = 'PMOBILE' then 'Mobile Pantry' 
		else 'Other' end
from [Inventory Transactions_V] it 
left join Item_V i on it.Company = i.Company and it.[Item No] = i.[No]
where [Posting Date] >= '7-1-2019'  
and it.[Item Ledger Entry Type] = 1 