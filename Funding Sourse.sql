  SELECT 
IT.[DW_Id] 
, IT.[DW_TimeStamp]
, IT.[COMPANY]
, IT.[Lot No]
, IT.[Item No]
, IT.[Item Ledger Entry Type]
, IT.[Posting Date]
, IT.[FBC County Code]
, IT.[Location Code]
, IT.[Cost Amount Actual]
, IT.[Gross Weight]
, IT.[Nutritious Pounds]
, IT.[UNC Product Type Code]
, LNT.[UNC Storage Requirement Code]
, LNT.[FBC Product Type Code] 
, 
[newName]  = CASE
                WHEN IT.[UNC Product Type Code] in (05, 11, 21, 24) THEN 'GRAIN'
                WHEN IT.[UNC Product Type Code] in (15) AND LNT.[UNC Storage Requirement Code] in ('DRY') THEN 'DRY MEAT'
                WHEN IT.[UNC Product Type Code] in (15) AND LNT.[UNC Storage Requirement Code] not in ('DRY') THEN 'FROZEN & REF MEAT'
                WHEN IT.[UNC Product Type Code] in (23) THEN 'PROTEIN'
                WHEN IT.[UNC Product Type Code] in (10, 14) THEN 'FRUIT/JUICE'
                WHEN IT.[UNC Product Type Code] in (27) THEN 'VEGATABLE'
                WHEN IT.[UNC Product Type Code] in (00, 07) AND LNT.[UNC Storage Requirement Code] in ('DRY') AND LNT.[FBC Product Type Code] in ('MILK') THEN 'DRY MILK'
                WHEN IT.[UNC Product Type Code] in (00, 07) AND LNT.[UNC Storage Requirement Code] in ('REF','FROZEN') AND LNT.[FBC Product Type Code] in ('MILK') THEN 'FROZEN MILK'
                WHEN IT.[UNC Product Type Code] in (00, 07) AND LNT.[FBC Product Type Code]  NOT IN ('MILK') THEN 'OTHER DAIRY'
                WHEN IT.[UNC Product Type Code] in (28) THEN 'PRODUCE'
                WHEN IT.[UNC Product Type Code] in (30) THEN 'SALVAGE'
                WHEN IT.[UNC Product Type Code] in (00, 03) AND LNT.[FBC Product Type Code] in ('WATER') THEN 'WATER'
                WHEN IT.[UNC Product Type Code] in (16) THEN 'MIXED & ASSORTED'
                WHEN IT.[UNC Product Type Code] in (02, 04, 06, 29, 31) THEN 'OTHER NUTRITIOUS'
                
END
, [Funding Source] = CASE
                WHEN IT.[Location Code] = 'PFC' 
                AND IT.[Item Ledger Entry Type] in(0) 
                AND lnt.[FBC Product Source Code] NOT IN ('PUR-BLUE', 'PUR-YELLOW', 'PUR-LOCAL', 'PUR-FRTBLU', 'PUR-FRTYEL', 'PUR-FRTLOC', 'TDEM', 'TDEM-2', 'TDEM-3', 'CDBG', 'USDA-CDBG') 
                AND lnt.[FBC Product Type Code] NOT IN ('USDATEXCAP' , 'USDACSFP') 
                THEN 'PURCHASE'

                WHEN IT.[Location Code] = 'PFC' 
                AND IT.[Item Ledger Entry Type] in(0) 
                AND lnt.[FBC Product Source Code] IN ('PUR-BLUE', 'PUR-YELLOW', 'PUR-LOCAL', 'PUR-FRTBLU', 'PUR-FRTYEL', 'PUR-FRTLOC') 
                AND lnt.[FBC Product Type Code] NOT IN ('USDATEXCAP' , 'USDACSFP') 
                THEN 'F&VAP' 

                WHEN IT.[Location Code] = 'PFC' 
                AND IT.[Item Ledger Entry Type] in(0) 
                AND lnt.[FBC Product Source Code] IN ('TDEM', 'TDEM-2', 'TDEM-3', 'USDA-CDBG', 'CDBG') 
                THEN 'GRANT PURCHASE' 

                WHEN IT.[Location Code] = 'PFC' 
                AND IT.[Item Ledger Entry Type] in(12) 
                AND lnt.[FBC Product Category Code] IN ('BONUS', 'TEXCAP', 'CFAP')
                THEN 'USDA-TEFAP' 

                WHEN IT.[Location Code] = 'PFC'
                AND IT.[Item Ledger Entry Type] in (12)
                --AND LNT.[FBC Product Category Code] in ()
                AND LNT.[FBC Product Category Code] in ('CSFP')
                THEN 'USDA-CSFP'

                WHEN IT.[Location Code] = 'PFC'
                AND IT.[Item Ledger Entry Type] in (12)
                AND LNT.[FBC Product Category Code] in ('MFGD','DONATED', 'PRODUCE')
                --AND LNT.[FBC Product Source Code] in ()
                THEN 'DONATION-NR'

                WHEN IT.[Location Code] = 'PFC'
                AND IT.[Item Ledger Entry Type] in (12)
                AND LNT.[FBC Product Category Code] in ('RETAIL')
                --AND LNT.[FBC Product Source Code] in ()
                THEN 'DONATION-R/FB'

                WHEN IT.[Location Code] = 'GR'
                AND IT.[Item Ledger Entry Type] in (12)
                --AND LNT.[FBC Product Category Code] in ()
                --AND LNT.[FBC Product Source Code] in ()
                THEN 'AGENCY DIRECT'
                
END

  FROM [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it
  LEFT JOIN [JetCeres45Dwh].[dbo].[Lot No Information_V] lnt ON
  lnt.[Lot No] = it.[Lot No] AND
  lnt.[COMPANY] = it.[Company] 
  WHERE it.[COMPANY] = 'North Texas Food Bank Live' AND 
  it.[Posting Date] >= '2021-07-01'   

ORDER BY [Funding Source]