SELECT 
--*
it.[Posting Date], 
a.No ,
a.[FBC Agency Category Code], 
it.[Item Ledger Entry Type] ,
it.[Gross Weight], 
it.[Location Code] , 
i.[UNC Product Type Code] , 
it.[Product Posting Group] , 
lni.[FBC Product Source Code], 
i.[Product Group Code]
,
  CASE
    WHEN it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] in ('07','00') 
    THEN 'Dairy'

    WHEN it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] NOT IN ('07','28') 
    AND it.[Product Posting Group] in ('USDA', 'PURCHASE') 
    AND i.[Product Group Code] != 'KITTED BOX' 
    THEN 'Donated'

    WHEN it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] = '28' 
    THEN 'Produce'

    When it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] NOT IN ('07', '28') 
    AND it.[Product Posting Group] = 'PURCHASE' 
    AND lni.[fbc product source code] in ('TDEM', 'TDEM-2') 
    And i.[Product Group Code] != 'KITTED BOX' 
    THEN 'TDEM'

    When it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] NOT IN ('07', '28') 
    AND it.[Product Posting Group] = 'PURCHASE' 
    AND lni.[FBC Product Source Code] NOT in ('TDEM', 'TDEM-2') 
    AND i.[Product Group Code] != 'KITTED BOX' 
    THEN 'PURCHASED'

    When it.[Location Code] = 'GR' 
    THEN 'Retail Direct' 
    
    When it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] NOT IN ('07', '28') 
    AND it.[Product Posting Group] = 'USDA' 
    AND i.[Product Group Code] != 'KITTED BOX' 
    THEN 'USDA'

    When it.[Location Code] = 'PFC' 
    AND i.[UNC Product Type Code] !='28' 
    AND i.[Product Group Code] = 'KITTED BOX' 
    THEN 'Kitted BOX (DRY)'

  END AS 'FEE GROUP'  
  FROM [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it
  LEFT JOIN [JetCeres45Dwh].[dbo].[Agency_V] a 
  on it.[Agency No] = a.[No]
  LEFT JOIN [JetCeres45Dwh].[dbo].[Item_V] i
  ON it.[UNC Product Type Code] = i.[UNC Product Type Code]
  LEFT JOIN [JetCeres45Dwh].[dbo].[Lot No Information_V] lni
  ON it.[Lot No] = lni.[Lot No]
  where it.[Company] = 'North Texas Food Bank Live' 
  /*
  AND it.[Global Dimension 1 Code] = '2300' 
  AND it.[Global Dimension 2 Code] != 'PMOBILE'
  AND a.[FBC Agency Category Code] != 'RDO'
  */