
SELECT 
  it.[posting date],
  it.[Gross Weight],
  it.[item no],
  I.[UNC Storage Requirement Code],
  I.[UNC Product Type Code],
  I.[FBC Product Type Code],
  I.[Inventory Posting Description],
  
  FROM [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it
  LEFT JOIN [JetCeres45Dwh].[dbo].[Item_V] i
  ON 
  it.[Item No] = i.[no]
  WHERE 
  IT.[Location Code]= 'PFC' AND
  I.[Inventory Posting Description] NOT IN ('171010 DON USDA CSFP', 
                                    '171010 DON CSFP',
                                    '171014 PUR F4K',
                                    '171008 DON F4K',
                                    '171011 PUR SCH PAN',
                                    '171007 DON SCH PAN')