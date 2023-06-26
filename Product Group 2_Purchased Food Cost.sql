SELECT 
    it.[DW_Id],
    lni.DW_Id,
    it.[Posting Date], 
    it.[Gross Weight], 
    a.[no],
    a.[FBC County Code],
    it.[Global dimension 1 code],
    it.[Global dimension 2 code],
    it.[location code], 
    i.[UNC Product Type Code], 
    it.[Product Posting Group], 
    lni.[FBC Product Source Code], 
    i.[product Group Code],
    CASE
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] = '07|00' THEN 'Dairy'
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] NOT IN ('07', '28') AND it.[Product Posting Group] NOT IN ('USDA', 'PURCHASE') AND lni.[FBC Product Source Code] <> 'KITTED BOX' THEN 'Donated'
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] = '28' THEN 'Produce'
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] NOT IN ('07', '28') AND it.[Product Posting Group] = 'PURCHASE' AND lni.[FBC Product Source Code] IN ('TDEM', 'TDEM-2') AND i.[Product Group Code] <> 'KITTED BOX' THEN 'TDEM'
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] NOT IN ('07', '28') AND it.[Product Posting Group] = 'PURCHASE' AND lni.[FBC Product Source Code] NOT IN ('TDEM', 'TDEM-2') AND i.[Product Group Code] <> 'KITTED BOX' THEN 'Purchased'
        WHEN it.[Location code] = 'GR' THEN 'Retail Direct'
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] NOT IN ('07', '28') AND it.[Product Posting Group] = 'USDA' AND i.[Product Group Code] <> 'KITTED BOX' THEN 'USDA'
        WHEN it.[Location code] = 'PFC' AND i.[UNC Product Type Code] <> '28' AND i.[Product Group Code] = 'KITTED BOX' THEN 'Kitted Box (Dry)'
        ELSE 'Unknown'
    END AS 'Fee Group'
FROM 
    [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it
LEFT JOIN 
    [JetCeres45Dwh].[dbo].[Agency_V] a 
ON 
    it.[Agency No] = a.[No]
LEFT JOIN 
    [JetCeres45Dwh].[dbo].[Item_V] i
ON 
    ON it.[Item No] = i.[no]
LEFT JOIN 
    [JetCeres45Dwh].[dbo].[Lot No Information_V] lni
ON 
    it.[Lot No] = lni.[Lot No]
WHERE it.[Company] = 'north texas food bank live' 
AND it.[Posting Date] >='2023-03-01' 
AND it.[Posting Date] <='2023-03-31'
AND it.[Global Dimension 1 Code] = '2300' 
AND it.[Global Dimension 2 Code] <> 'PMOBILE'
AND a.[FBC Agency Category Code] <> 'RDO'
AND a.No NOT IN ('1410958','1410960')
AND a.[FBC County Code] in ('COLLIN','DALLAS','DELTA','DENTON','ELLIS','FANNIN','GRAYSON','HOPKINS','HUNT','KAUFMAN','LAMAR','NAVARRO','ROCKWALL')
AND it.[Gross Weight] != 0 