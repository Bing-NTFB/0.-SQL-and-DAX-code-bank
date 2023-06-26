select 
        it.[Posting Date]
        ,it.[Global Dimension 1 Code]
        ,it.[FBC County Code]
        ,Apps =  convert(decimal(10,4),0)
        ,Meals = convert(decimal(18,4),it.[Nutritious Pounds]) / -1.2
        ,[Gross Weight] =  convert(decimal(18,4),it.[Gross Weight]) *-1
        from [Inventory Transactions_V] it 
        where it.Company = 'north texas food bank live'
        and it.[Item Ledger Entry Type] = 1
        and it.[Gross Weight] <> 0

 


union all
(
select A.AppDate, Global1, A.County, SNAPApps, Meals=convert(decimal(18,4),Meals), GrossWght = 0
        from (
            select AppDate, Global1 = 'SNAP', County = left(County, len(County) - 6), Meals = sum(Meals)
            from(
                select AppDate, County, [Type], Meals
                from [SNAP By County_V] s
               unpivot
                    (Meals for County in (
                    [Collin Meals],[Dallas Meals],[Delta Meals],[Denton Meals],[Ellis Meals],[Fannin Meals],[Grayson Meals],[Hopkins Meals],[Hunt Meals],[Kaufman Meals],[Lamar Meals],[Navarro Meals],[Rockwall Meals]
                    )) u
                )X
                group by AppDate, County
            ) A
        left join 
            (
            select AppDate, County, SNAPApps=sum(SNAPApps)
            from (
                select AppDate, County, [type] ,SNAPApps
                from [SNAP By County_V] s
               unpivot
                    (SNAPApps for County in (
                    [Collin],[Dallas],[Delta],[Denton],[Ellis],[Fannin],[Grayson],[Hopkins],[Hunt],[Kaufman],[Lamar],[Navarro],[Rockwall]
                    )) u
                )X
                group by AppDate, County
             ) B on a.AppDate = b.AppDate and a.County = b.County
             )