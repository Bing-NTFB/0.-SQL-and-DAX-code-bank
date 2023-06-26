--1) Create closure calendar

create table #NTFB_Closure_Dates
(ClosureDate Date, ClosureReason varchar(25))

insert into #NTFB_Closure_Dates select '1/1/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '1/3/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '4/15/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '4/16/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '5/28/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '5/30/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '6/22/2022', 'Inventory'
insert into #NTFB_Closure_Dates select '6/23/2022', 'Inventory'
insert into #NTFB_Closure_Dates select '6/24/2022', 'Inventory'
insert into #NTFB_Closure_Dates select '6/25/2022', 'Inventory'
insert into #NTFB_Closure_Dates select '7/2/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '7/5/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '9/3/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '9/5/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '11/24/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '11/25/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '11/26/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '12/23/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '12/24/2022', 'Holiday Weekend'
insert into #NTFB_Closure_Dates select '12/26/2022', 'Holiday'
insert into #NTFB_Closure_Dates select '12/31/2022', 'Holiday Weekend'

--2) Standing Apt Calendar

create table #Apt
([Date] date, WeekNo int, DayNo int
)

declare @EOM date, @counter date, @WeekNo int
set @counter = dateadd(dd,1-day(getdate()), getdate())
set @EOM = dateadd(dd,-1,dateadd(mm,2,@counter))
set @WeekNo = 1 

while (@counter < @EOM	)
	Begin
		if day(@counter) = 1
			begin
				set @WeekNo = 1
			end
	
		insert into #Apt select @counter, @WeekNo, datepart(dw,@counter) - 1

		if datepart(dw,@counter) = 7
			begin
				set  @WeekNo = @WeekNo + 1
			end

		set @counter = dateadd(dd,1,@counter)
	End

--select * from #Apt

--3) Actual Appointments
/*
1 - week no <> 0 and day of week <> 0 => specific day/week
2 - week no = 0 and every x weeks <> 0 => use every week frequency  (*only pickup)
3 - week no = 0 and day of week <> 0 => every week on that day
4 - week no = 0 and day of week = 0 => ?every day every week? (*only pickup)

--drop table #StandingAppointments
*/

select sa.*, AptDate = a.[Date]
,Affected = case when c.ClosureDate is not null then 1 else 0 end
into #StandingAppointments
		from [North Texas Food Bank Live$Standing Appt_ Setup Line] sa
		left join #apt a on sa.[Week No_ in Month] = a.WeekNo and sa.[Day of Week] = a.DayNo
		left join #NTFB_Closure_Dates c on a.[Date] = c.ClosureDate
		where sa.[Week No_ in Month] <> 0 
		and sa.[Day of Week] <> 0
		and [Schedule Template Name] = 'DELIVER'

/*every week NOT every day*/
union all

		select sa.*, a.[Date],Affected = case when c.ClosureDate is not null then 1 else 0 end
		from [North Texas Food Bank Live$Standing Appt_ Setup Line] sa
		left join #apt a on 1 = a.WeekNo and sa.[Day of Week] = a.DayNo
		left join #NTFB_Closure_Dates c on a.[Date] = c.ClosureDate
		where sa.[Week No_ in Month] = 0 
		and [Day of Week] <> 0
		and a.[Date] is not null
		and [Schedule Template Name] = 'DELIVER'
 
		 union all

		select sa.*, a.[Date],Affected = case when c.ClosureDate is not null then 1 else 0 end
		from [North Texas Food Bank Live$Standing Appt_ Setup Line] sa
		left join #apt a on 2 = a.WeekNo and sa.[Day of Week] = a.DayNo
		left join #NTFB_Closure_Dates c on a.[Date] = c.ClosureDate
		where sa.[Week No_ in Month] = 0 
		and [Day of Week] <> 0
		and a.[Date] is not null
		and [Schedule Template Name] = 'DELIVER'

		union all

		select sa.*, a.[Date],Affected = case when c.ClosureDate is not null then 1 else 0 end
		from [North Texas Food Bank Live$Standing Appt_ Setup Line] sa
		left join #apt a on 3 = a.WeekNo and sa.[Day of Week] = a.DayNo
		left join #NTFB_Closure_Dates c on a.[Date] = c.ClosureDate
		where sa.[Week No_ in Month] = 0 
		and [Day of Week] <> 0
		and a.[Date] is not null
		and [Schedule Template Name] = 'DELIVER'


		union all

		select sa.*, a.[Date],Affected = case when c.ClosureDate is not null then 1 else 0 end
		from [North Texas Food Bank Live$Standing Appt_ Setup Line] sa
		left join #apt a on 4 = a.WeekNo and sa.[Day of Week] = a.DayNo
		left join #NTFB_Closure_Dates c on a.[Date] = c.ClosureDate
		where sa.[Week No_ in Month] = 0 
		and [Day of Week] <> 0
		and a.[Date] is not null
		and [Schedule Template Name] = 'DELIVER'


		union all

		select sa.*, a.[Date],Affected = case when c.ClosureDate is not null then 1 else 0 end
		from [North Texas Food Bank Live$Standing Appt_ Setup Line] sa
		left join #apt a on 5 = a.WeekNo and sa.[Day of Week] = a.DayNo
		left join #NTFB_Closure_Dates c on a.[Date] = c.ClosureDate
		where sa.[Week No_ in Month] = 0 
		and [Day of Week] <> 0
		and a.[Date] is not null 
		and [Schedule Template Name] = 'DELIVER'


		--select * from #StandingAppointments


select 
a.[Agency No_], a.[Schedule Template Name], a.[Location Code], a.[AptDate], AptTime = convert(time, a.[Appointment Time]), a.Affected
, NextAptDate = min(b.[AptDate])

from #StandingAppointments a
left join #StandingAppointments b on a.[Agency No_] = b.[Agency No_] and b.Affected = 0 and b.[AptDate] > a.[AptDate]
where month(a.[AptDate]) = month(getdate())
group by a.[Agency No_], a.[Schedule Template Name], a.[Location Code], a.[AptDate], a.Affected,a.[Appointment Time]

