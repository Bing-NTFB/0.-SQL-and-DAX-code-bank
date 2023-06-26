SELECT [DW_Id]
      ,[Posting Date]
      ,[Document No]
      ,[Item Ledger Entry No]
      ,[Buy-from Vendor No]
      ,[Buy-from Vendor Name]
      ,[FBC Product Category]
      ,[FBC Product Source]
      , CASE 
      WHEN [FBC Product Source] = 'ARPA' THEN 'PURCHASE - ARPA'
      WHEN [FBC Product Source] IN ('CDBG', 'USDA-CDBG') THEn 'PURCHASE - CDBG'
      WHEN [FBC Product Source] = 'LFPA' THEN 'PURCHASE - LFPA'
      WHEN [FBC Product Source] IN ('TDEM', 'TDEM1', 'TDEM-1', 'TDEM2', 'TDEM-2','TDEM3', 'TDEM-3') THEN 'PURCHASE - TDEM'
      WHEN [FBC Product Source] = 'USDA-CCC' THEN 'DONATION - CCC'
      ELSE 'NTFB'
      END AS [Funding Source Grouping]
      ,[Item No]
      ,[Description]
      ,[Location Code]
      ,[UNC Product Type Code]
      ,[UNC Storage Requirement Code]
      ,[FBC Product Type Code]
      ,[Inventory Posting Group]
      ,[Rec Document Type]
      ,[Inv Document Type]
      ,[Expected Cost]
      ,[Purchase Amount]
      ,[Purchase Amount (Actual)]
      ,[Purchase Amount (Expected)]
      ,[Gross Weight]
      ,[FVAP lb Cost]
      ,[Quantity]
      ,[Unit Cost]
      ,[Nutritious Pounds]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
  FROM [jetceres45dwh].[dbo].[Purchased Food Costs_V]
