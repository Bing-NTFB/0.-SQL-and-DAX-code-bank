SELECT
       we.[DW_Id]
      ,we.[Bin Code]
      ,we.[Bin Type Code]
      ,we.[Ext Gross Weight]
      ,we.[Item No]
      ,i.[no]
      ,we.[Reason Code]
      ,we.[Entry Type]
      ,we.[Registering Date]
      ,i.[UNC Product Type Code]
      ,i.[FBC Storage Requirement Code]
      ,i.[FBC Product Type Code]
      ,i.[Inventory Posting Group],
        [FBC Food Name] = CASE 
            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 21 AND 
            i.[FBC Product Type Code] = 'PASTA' THEN 
            'Pasta'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 24 AND 
            i.[FBC Product Type Code] = 'RICE' THEN 
            'Rice'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 27 AND 
            i.[FBC Product Type Code] = 'CORN' THEN 
            'Corn'
            
            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 27 AND 
            i.[FBC Product Type Code] = 'MIXED_VEG' THEN 
            'Mixed Vegetables'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 27 AND 
            i.[FBC Product Type Code] = 'GREEN_BEAN' THEN 
            'Green Beans'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 27 AND 
            i.[FBC Product Type Code] = 'PASTA_SAUC' THEN 
            'Pasta Sauce'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] =  27 AND 
            i.[FBC Product Type Code] = 'TOMATOES' THEN 
            'Tomatoes'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 10 AND 
            i.[FBC Product Type Code] = 'APPLESAUCE' THEN 
            'Applesauce'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 10 AND 
            i.[FBC Product Type Code] = 'PEARS' THEN 
            'Pears'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 10 AND 
            i.[FBC Product Type Code] = 'PEACHES' THEN 
            'Peaches'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 10 AND 
            i.[FBC Product Type Code] = 'ORANGS' THEN 
            'Oranges'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 15 AND 
            i.[FBC Product Type Code] = 'TUNA' THEN 
            'Tuna'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 15 AND 
            i.[FBC Product Type Code] = 'CHICKEN' THEN 
            'Chicken'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 15 AND 
            i.[FBC Product Type Code] = 'SALMON' THEN 
            'Salmon'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 23 AND 
            i.[FBC Product Type Code] = 'PB' THEN 
            'Peanut Butter'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 23 AND 
            i.[FBC Product Type Code] = 'PINTO_BEAN' THEN 
            'Pinto Beans'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] = 23 AND 
            i.[FBC Product Type Code] = 'BLACK_BEAN' THEN 
            'Black Beans'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] in (00, 05)  AND 
            i.[FBC Product Type Code] = 'OATS' THEN 
            'Oats'

            WHEN 
            i.[UNC Storage Requirement Code] = 'DRY' AND 
            i.[UNC Product Type Code] in (00,07)  AND 
            i.[FBC Product Type Code] = 'MILK' THEN 
            'Milk (Dry)'

            WHEN 
            i.[UNC Product Type Code] in (00, 05)  AND 
            i.[FBC Product Type Code] = 'CEREAL' THEN 
            'Cereal'

            WHEN 
            i.[UNC Storage Requirement Code] = 'REF' AND 
            i.[UNC Product Type Code] in (00, 07) AND
            i.[FBC Product Type Code] = 'MILK' THEN 
            'Milk (Ref)'

            WHEN 
            i.[UNC Storage Requirement Code] in ('REF', 'FROZEN')  AND 
            i.[UNC Product Type Code] =  23 AND 
            i.[FBC Product Type Code] = 'EGG' THEN 
            'Egg'

            WHEN 
            i.[UNC Storage Requirement Code] = 'FROZEN' AND 
            i.[UNC Product Type Code] =  15 
            THEN 
            'Meat (Frozen)'
            END

  FROM [JetCeres45Dwh].[dbo].[Warehouse Entry_V] we
  LEFT JOIN [JetCeres45Dwh].[dbo].[ITEM_V] i
  on i.[no] = we.[Item No]
  WHERE we.[COMPANY] = 'NORTH TEXAS FOOD BANK LIVE' AND
  we.[Registering Date] >= '2019-01-01' AND
  we.[Bin Code] LIKE '%PROD-%' AND
  we.[entry type] = 0 AND
  i.[Inventory Posting Group] in ('USDATEXCAP', 'RETAIL', 'MAINPURCH','MAINDON')