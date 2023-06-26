/*SNAP table - meals and apps by month and county*/
(
select A.AppDate, ProgramGroup, A.County, SNAPApps, Meals
		from (
			select AppDate, ProgramGroup = 'SNAP', County = left(County, len(County) - 6), Meals = sum(Meals)
			from(
				select AppDate, County, [Type], Meals
				from [SNAP By County_V] s
				
			   unpivot
					(Meals for County in (
					[Collin Meals],[Dallas Meals],[Delta Meals],[Denton Meals],[Ellis Meals],[Fannin Meals],[Grayson Meals],[Hopkins Meals],[Hunt Meals],[Kaufman Meals],[Lamar Meals],[Navarro Meals],[Rockwall Meals]
					)) u
				)X
				where AppDate >= '7-1-2019'
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
				where AppDate >= '7-1-2019'
				group by AppDate, County
				
			 ) B on a.AppDate = b.AppDate and a.County = b.County
			 ) 






