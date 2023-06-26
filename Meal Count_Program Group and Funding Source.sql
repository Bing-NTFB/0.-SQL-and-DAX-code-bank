select 
it.[Entry No]
,it.[Reason Code]
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
   
, FundingSource = CASE
        WHEN it.[Product Posting Group] = 'PURCHASE' AND lni.[FBC Product Source Code] IN ('PUR-BLUE', 'PUR-YELLOW') THEN 'Purchase - Freight & VAP'
        WHEN it.[Product Posting Group] = 'PURCHASE' AND lni.[FBC Product Source Code] NOT IN ('TDEM', 'TDEM-2', 'PUR-BLUE', 'PUR-YELLOW') THEN 'Purchase - Other'
        WHEN it.[Product Posting Group] = 'PURCHASE' AND lni.[FBC Product Source Code] = 'USDA-CDBG' THEN 'Grant Purchase - CDBG'
        WHEN it.[Product Posting Group] = 'PURCHASE' AND lni.[FBC Product Source Code] IN ('TDEM', 'TDEM-2') THEN 'Grant Purchase - TDEM'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA' AND lni.[FBC Product Category Code] <> 'CSFP' THEN 'Government - TEFAP-ENT'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA-BONUS' AND lni.[FBC Product Category Code] <> 'CSFP' THEN 'Government - TEFAP-BON'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA-TM' AND lni.[FBC Product Category Code] <> 'CSFP' THEN 'Government - TEFAP-TM'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA' AND lni.[FBC Product Category Code] <> 'CSFP' THEN 'CGovernment - ARES'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA' AND lni.[FBC Product Category Code] = 'CSFP' THEN 'Government - CSFP'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA-CFAP' AND lni.[FBC Product Category Code] <> 'CSFP' THEN 'Government - CFAP'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] = 'USDA-FFCRA ' AND lni.[FBC Product Category Code] <> 'CSFP' THEN 'Government - FFCRA'
        WHEN it.[Product Posting Group] = 'USDA' AND lni.[FBC Product Source Code] NOT IN ('USDA', 'USDA-BONUS', 'USDA-TM', 'USDA-CARES', 'USDA-CFAP', 'USDA-FFCRA') THEN 'Other'
        WHEN it.[Product Posting Group] = 'DONATED' THEN 'DONATED'
        ELSE 'Other'
    END 


from [Inventory Transactions_V] it 
left join Item_V i on it.Company = i.Company and it.[Item No] = i.[No]
 LEFT JOIN [Lot No Information_V] lni ON it.[lot No] = lni.[lot No]
where [Posting Date] >= '7-1-2019'  
--and it.[Item Ledger Entry Type] = 1 