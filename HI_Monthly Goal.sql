 select 
 b.[From Date], 
 b.Dept, 
 b.Program, 
 Goal= isnull(r.Goal, b.Goal),
 [Goal Type]=isnull(r.[Goal Type],b.[Goal Type])
 from (
select 
[From Date], 
Dept, 
Program, 
Goal =  [Value],  
[Goal Type]
from [Monthly Goals_V]
where  [Goal Measure] = 'Meals'
and [Goal Type] in ( 'Reforecasted', 'budget')
and [Fiscal Year] = 2023
 ) R
 
 right join 
 
 (
select 
[From Date], 
Dept, 
Program, 
Goal =  [Value],  
[Goal Type]

from [Monthly Goals_V]
where [Goal Measure] = 'meals' and [Goal Type]='budget'
and [From Date] >= '7-1-2019'
 ) B 
 
 on r.[From Date] = b.[From Date]
 and r.Dept = b.Dept
 and r.Program = b.Program