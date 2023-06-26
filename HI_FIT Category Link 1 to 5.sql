select [Agency No], FY22_Nutritious = -1 *sum([Nutritious Pounds])
, FIT_Category =  case when  -1 *sum([Nutritious Pounds]) <= 0 then 'No Distributions'
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 'Foundational'
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 'Impact'
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 'Transformational'
					   else 'Error' end

, FIT_Number = case when  -1 *sum([Nutritious Pounds]) <= 0 then 0
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 1
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 2
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 3
					   else 0 end
from [Inventory Transactions_V]
where [Item Ledger Entry Type] = 1
and [Posting Date]>= '7-1-2021'
and [Posting Date] <= '6-30-2022'
and isnull([Agency No],'')<>''
group by [Agency No]

-----------------------
select [Agency No], FY22_Nutritious = -1 *sum([Nutritious Pounds])
, FIT_Category =  case when  -1 *sum([Nutritious Pounds]) <= 0 then 'No Distributions'
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 'Foundational'
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 'Impact'
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 'Transformational'
					   else 'Error' end

, FIT_Number = case when  -1 *sum([Nutritious Pounds]) <= 0 then 0
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 1
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 2
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 3
					   else 0 end
from [Inventory Transactions_V]
where [Item Ledger Entry Type] = 1
and [Posting Date]>= '7-1-2021'
and [Posting Date] <= '6-30-2022'
and isnull([Agency No],'')<>''
group by [Agency No]

-----------------------
select [Agency No], FY22_Nutritious = -1 *sum([Nutritious Pounds])
, FIT_Category =  case when  -1 *sum([Nutritious Pounds]) <= 0 then 'No Distributions'
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 'Foundational'
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 'Impact'
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 'Transformational'
					   else 'Error' end

, FIT_Number = case when  -1 *sum([Nutritious Pounds]) <= 0 then 0
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 1
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 2
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 3
					   else 0 end
from [Inventory Transactions_V]
where [Item Ledger Entry Type] = 1
and [Posting Date]>= '7-1-2021'
and [Posting Date] <= '6-30-2022'
and isnull([Agency No],'')<>''
group by [Agency No]

-----------------------
select [Agency No], FY22_Nutritious = -1 *sum([Nutritious Pounds])
, FIT_Category =  case when  -1 *sum([Nutritious Pounds]) <= 0 then 'No Distributions'
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 'Foundational'
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 'Impact'
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 'Transformational'
					   else 'Error' end

, FIT_Number = case when  -1 *sum([Nutritious Pounds]) <= 0 then 0
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 1
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 2
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 3
					   else 0 end
from [Inventory Transactions_V]
where [Item Ledger Entry Type] = 1
and [Posting Date]>= '7-1-2021'
and [Posting Date] <= '6-30-2022'
and isnull([Agency No],'')<>''
group by [Agency No]

-----------------------
select [Agency No], FY22_Nutritious = -1 *sum([Nutritious Pounds])
, FIT_Category =  case when  -1 *sum([Nutritious Pounds]) <= 0 then 'No Distributions'
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 'Foundational'
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 'Impact'
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 'Transformational'
					   else 'Error' end

, FIT_Number = case when  -1 *sum([Nutritious Pounds]) <= 0 then 0
					   when  -1 *sum([Nutritious Pounds]) <= 41500 then 1
					   when  -1 *sum([Nutritious Pounds]) <= 500000 then 2
					   when  -1 *sum([Nutritious Pounds]) > 500000 then 3
					   else 0 end
from [Inventory Transactions_V]
where [Item Ledger Entry Type] = 1
and [Posting Date]>= '7-1-2021'
and [Posting Date] <= '6-30-2022'
and isnull([Agency No],'')<>''
group by [Agency No]