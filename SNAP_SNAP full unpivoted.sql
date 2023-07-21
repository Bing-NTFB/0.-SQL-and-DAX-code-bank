-- CTE for County
WITH CountyUnpivot AS (
    SELECT 
        [DW_Id], [Fiscal Year], [Month], [AppDate], [Type], 
        [Quarter], Total, Date, DW_Batch, DW_SourceCode, DW_TimeStamp, 
        County = ColumnName, AppValue = Value
    FROM
        (SELECT 
            DW_Id, [Fiscal Year], Month, AppDate, Type, 
            [Quarter], Total, Date, DW_Batch, DW_SourceCode, DW_TimeStamp,
            Collin, Dallas, Delta, Denton, Ellis, Fannin, Grayson, 
            Hopkins, Hunt, Kaufman, Lamar, Navarro, Rockwall
        FROM
            [JetCeres45Dwh].[dbo].[SNAP By County_V]) AS SourceTable
    UNPIVOT
        (Value FOR ColumnName IN 
            (Collin, Dallas, Delta, Denton, Ellis, Fannin, Grayson, 
            Hopkins, Hunt, Kaufman, Lamar, Navarro, Rockwall)
        ) AS UnpivotTable
),

-- CTE for Meals
MealsUnpivot AS (
    SELECT 
        DW_Id, 
        County = REPLACE(ColumnName, ' Meals', ''), 
        MealsValue = Value
    FROM 
        (SELECT 
            DW_Id, 
            [Collin Meals], [Dallas Meals], [Delta Meals], 
            [Denton Meals], [Ellis Meals], [Fannin Meals], 
            [Grayson Meals], [Hopkins Meals], [Hunt Meals], 
            [Kaufman Meals], [Lamar Meals], [Navarro Meals], 
            [Rockwall Meals], [Total Meals]
        FROM 
            [JetCeres45Dwh].[dbo].[SNAP By County_V]) AS SourceTable
    UNPIVOT
        (Value FOR ColumnName IN 
            ([Collin Meals], [Dallas Meals], [Delta Meals], 
            [Denton Meals], [Ellis Meals], [Fannin Meals], 
            [Grayson Meals], [Hopkins Meals], [Hunt Meals], 
            [Kaufman Meals], [Lamar Meals], [Navarro Meals], 
            [Rockwall Meals], [Total Meals])
        ) AS UnpivotTable
),

-- CTE for FA Meals
FAMealsUnpivot AS (
    SELECT 
        DW_Id, 
        County = REPLACE(ColumnName, ' FA Meals', ''), 
        FAMealsValue = Value
    FROM 
        (SELECT 
            DW_Id, 
            [Collin FA Meals], [Dallas FA Meals], [Delta FA Meals], 
            [Denton FA Meals], [Ellis FA Meals], [Fannin FA Meals], 
            [Grayson FA Meals], [Hopkins FA Meals], [Hunt FA Meals], 
            [Kaufman FA Meals], [Lamar FA Meals], [Navarro FA Meals], 
            [Rockwall FA Meals], [Total FA Meals]
        FROM 
            [JetCeres45Dwh].[dbo].[SNAP By County_V]) AS SourceTable
    UNPIVOT
        (Value FOR ColumnName IN 
            ([Collin FA Meals], [Dallas FA Meals], [Delta FA Meals], 
            [Denton FA Meals], [Ellis FA Meals], [Fannin FA Meals], 
            [Grayson FA Meals], [Hopkins FA Meals], [Hunt FA Meals], 
            [Kaufman FA Meals], [Lamar FA Meals], [Navarro FA Meals], 
            [Rockwall FA Meals], [Total FA Meals])
        ) AS UnpivotTable
)

-- Final Query
SELECT 
    C.DW_Id, C.[Fiscal Year], C.Month, C.AppDate, C.Type, 
    C.[Quarter], C.Total, C.Date, C.DW_Batch, C.DW_SourceCode, C.DW_TimeStamp, 
    C.County, C.AppValue, M.MealsValue, F.FAMealsValue
FROM 
    CountyUnpivot C 
    LEFT JOIN MealsUnpivot M ON C.DW_Id = M.DW_Id AND C.County = M.County
    LEFT JOIN FAMealsUnpivot F ON C.DW_Id = F.DW_Id AND C.County = F.County
ORDER BY 
    C.DW_Id, C.County;
