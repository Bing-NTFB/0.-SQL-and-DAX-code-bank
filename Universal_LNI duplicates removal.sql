/*
Original Inventory Trasaction table call
*/
SELECT 
    it.DW_Id,
    it.[Lot No],
    it.[Pallet No],
    it.[Item No],
    it.[Gross Weight],
    it.[Item Ledger Entry type]
FROM [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it

WHERE 
    it.[COMPANY] = 'North Texas Food Bank Live' AND 
    it.[Posting Date] >= '2023-06-01' AND 
    it.[Posting Date] <= '2023-07-01' AND
    it.[Gross Weight] != 0 AND
    it.[Item Ledger Entry Type] = 0 

/*
Original Inventory Trasaction table call
notice it will cause duplication at it.item no due to the structure of lni. 
create a column highlighting all the duplicated ones. 
*/
SELECT 
    it.DW_Id AS [IT.DW_ID],
   -- lni.[FBC Product Category Code], 
    --lni.[UNC Product Category Code],
    --lni.[FBC Product Source Code],
    --lni.[UNC Product Source Code],
    lni.[Lot No] AS [LNI.LOT no],
    lni.[Item No] AS [LNI.Item no],
       CONCAT(lni.[Lot No], '_', it.[Pallet No], '_', it.[Item No]) AS [Combined Lot Pallet Item],
    it.[Pallet No],
    it.[Item No] as [IT.item no],
    it.[Gross Weight],
    it.[Item Ledger Entry type],
    CASE
        WHEN COUNT(*) OVER (PARTITION BY CONCAT(lni.[Lot No], '_', it.[Pallet No], '_', it.[Item No]), it.[Gross Weight]) > 1 THEN 'Highlighted'
        ELSE ''
    END AS [Duplication Status]
FROM [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it
LEFT JOIN [JetCeres45Dwh].[dbo].[Lot No Information_V] lni ON
    lni.[Lot No] = it.[Lot No] 
WHERE 
    it.[COMPANY] = 'North Texas Food Bank Live' AND 
    it.[Item Ledger Entry Type] = '0' AND
    it.[Posting Date] >= '2023-06-01' AND 
    it.[Posting Date] <= '2023-07-01' AND
    it.[Gross Weight] != 0 --AND
    --it.DW_Id = 7615761

ORDER BY it.DW_Id


SELECT 
    [IT.DW_ID],
    [LNI.LOT no],
    [LNI.Item no],
    [Combined Lot Pallet Item],
    [Pallet No],
    [IT.item no],
    [Gross Weight],
    [Item Ledger Entry type],
    CASE
        WHEN [RowNumber] > 1 THEN 'Highlighted'
        ELSE ''
    END AS [Duplication Status]
FROM (
    SELECT 
        it.DW_Id AS [IT.DW_ID],
        lni.[Lot No] AS [LNI.LOT no],
        lni.[Item No] AS [LNI.Item no],
        CONCAT(lni.[Lot No], '_', it.[Pallet No], '_', it.[Item No]) AS [Combined Lot Pallet Item],
        it.[Pallet No],
        it.[Item No] AS [IT.item no],
        it.[Gross Weight],
        it.[Item Ledger Entry type],
        ROW_NUMBER() OVER (PARTITION BY CONCAT(lni.[Lot No], '_', it.[Pallet No], '_', it.[Item No]), it.[Gross Weight] ORDER BY it.DW_Id) AS [RowNumber]
    FROM [JetCeres45Dwh].[dbo].[Inventory Transactions_V] it
    LEFT JOIN [JetCeres45Dwh].[dbo].[Lot No Information_V] lni ON
        lni.[Lot No] = it.[Lot No] 
    WHERE 
        it.[COMPANY] = 'North Texas Food Bank Live' AND 
        it.[Item Ledger Entry Type] = '0' AND
        it.[Posting Date] >= '2023-06-01' AND 
        it.[Posting Date] <= '2023-07-01' AND
        it.[Gross Weight] != 0
) AS Subquery
ORDER BY [IT.DW_ID]
