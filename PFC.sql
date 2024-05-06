SELECT  
      [Posting Date]
      ,[Document No]
      ,[Item Ledger Entry No]
      ,[FBC Product Category]
      ,[FBC Product Source]
      ,[Item No]
      ,[Location Code]
      ,[UNC Product Type Code]
      ,[UNC Storage Requirement Code]
      ,[FBC Product Type Code]
      ,[Purchase Amount]
      ,[Gross Weight]
      ,[Nutritious Pounds]
      ,
      [newName]  = CASE
                WHEN [UNC Product Type Code] in (05, 11, 21, 24) THEN 'GRAIN'
                WHEN [UNC Product Type Code] in (15) AND [UNC Storage Requirement Code] in ('DRY') THEN 'DRY MEAT'
                WHEN [UNC Product Type Code] in (15) AND [UNC Storage Requirement Code] not in ('DRY') THEN 'FROZEN & REF MEAT'
                WHEN [UNC Product Type Code] in (23) THEN 'PROTEIN'
                WHEN [UNC Product Type Code] in (10, 14) THEN 'FRUIT/JUICE'
                WHEN [UNC Product Type Code] in (27) THEN 'VEGATABLE'
                WHEN [UNC Product Type Code] in (00, 07) AND [UNC Storage Requirement Code] in ('DRY') AND [FBC Product Type Code] in ('MILK') THEN 'DRY MILK'
                WHEN [UNC Product Type Code] in (00, 07) AND [UNC Storage Requirement Code] in ('REF','FROZEN') AND [FBC Product Type Code] in ('MILK') THEN 'FROZEN MILK'
                WHEN [UNC Product Type Code] in (00, 07) AND [FBC Product Type Code]  NOT IN ('MILK') THEN 'OTHER DAIRY'
                WHEN [UNC Product Type Code] in (28) THEN 'PRODUCE'
                WHEN [UNC Product Type Code] in (30) THEN 'SALVAGE'
                WHEN [UNC Product Type Code] in (00, 03) AND [FBC Product Type Code] in ('WATER') THEN 'WATER'
                WHEN [UNC Product Type Code] in (16) THEN 'MIXED & ASSORTED'
                WHEN [UNC Product Type Code] in (02, 04, 06, 29, 31) THEN 'OTHER NUTRITIOUS'
                
END
, [Funding Source] = CASE
                WHEN [Location Code] = 'PFC' 
                AND [Item Ledger Entry No] in(0) 
                AND [FBC Product Source] NOT IN ('PUR-BLUE', 'PUR-YELLOW', 'PUR-LOCAL', 'PUR-FRTBLU', 'PUR-FRTYEL', 'PUR-FRTLOC', 'TDEM', 'TDEM-2', 'TDEM-3', 'CDBG', 'USDA-CDBG') 
                AND [FBC Product Type Code] NOT IN ('USDATEXCAP' , 'USDACSFP') 
                THEN 'PURCHASE'

                WHEN [Location Code] = 'PFC' 
                AND [Item Ledger Entry no] in(0) 
                AND [FBC Product Source] IN ('PUR-BLUE', 'PUR-YELLOW', 'PUR-LOCAL', 'PUR-FRTBLU', 'PUR-FRTYEL', 'PUR-FRTLOC') 
                AND [FBC Product Type Code] NOT IN ('USDATEXCAP' , 'USDACSFP') 
                THEN 'F&VAP' 

                WHEN [Location Code] = 'PFC' 
                AND [Item Ledger Entry no] in(0) 
                AND [FBC Product Source] IN ('TDEM', 'TDEM-2', 'TDEM-3', 'USDA-CDBG', 'CDBG') 
                THEN 'GRANT PURCHASE' 

                WHEN [Location Code] = 'PFC' 
                AND [Item Ledger Entry no] in(12) 
                AND [FBC Product Category] IN ('BONUS', 'TEXCAP', 'CFAP')
                THEN 'USDA-TEFAP' 

                WHEN [Location Code] = 'PFC'
                AND [Item Ledger Entry no] in (12)
                --AND LNT.[FBC Product Category Code] in ()
                AND [FBC Product Category] in ('CSFP')
                THEN 'USDA-CSFP'

                WHEN [Location Code] = 'PFC'
                AND [Item Ledger Entry no] in (12)
                AND [FBC Product Category] in ('MFGD','DONATED')
                --AND LNT.[FBC Product Source Code] in ()
                THEN 'DONATION-NR'

                WHEN [Location Code] = 'PFC'
                AND [Item Ledger Entry no] in (12)
                AND [FBC Product Category] in ('RETAIL')
                --AND LNT.[FBC Product Source Code] in ()
                THEN 'DONATION-R/FB'

                WHEN [Location Code] = 'GR'
                AND [Item Ledger Entry no] in (12)
                --AND LNT.[FBC Product Category Code] in ()
                --AND LNT.[FBC Product Source Code] in ()
                THEN 'AGENCY DIRECT'
                END

  FROM [JetCeres45Dwh].[dbo].[Purchased Food Costs_V]
  where [Posting Date] >='2021-07-01'
