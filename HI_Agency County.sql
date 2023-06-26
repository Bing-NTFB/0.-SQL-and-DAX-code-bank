select 
AgencyNo= No, AgencyName=upper(Name)
, HubPartner = 'NTFB'--, HubAssignedNo = null
,[Address]= upper([Address]),City= upper(City),[State], [ZIP Code], [FBC County Code]=upper([FBC County Code])
, Latitude= case when Latitude in ('') then null else Latitude end, Longitude = case when  Longitude in ('') then null else  Longitude end
, [UNC Activity Status], [FBC Agency Category Code], [FBC Agency Category Description]
, [Global Dimension 1 Code], [Global Dimension 2 Code]
,CategoryColor = case   when [Global Dimension 1 Code] in ('1200') then 'KIDS'
						when [Global Dimension 1 Code] in ('1400') then 'SENIORS'
						when [Global Dimension 2 Code] in ('PMOBILE') then 'MOBILE'
						ELSE 'MAIN'end
						,[Parent Agency No], [Parent Agency Name]
from Agency_V
where company = 'North Texas Food Bank Live'
union all


---Table has list provided by Ajay --4/18/23
select  AgencyNo, AgencyName=upper(AgencyName)
, HubPartner--, HubAssignedNo
, [Address]= upper([Address]), City= upper(City), StateCode, Zipcode, upper(CountyName)
, Latitiude, Longtitude
, Active = null, CategoryCode = null, null, GlobalCode1 = null, GlobalCode2 = null
,CategoryColor = 'RDO Agency'
,HubPartner, case when HubPartner = 'SL' then 'SHARING LIFE' WHEN HubPartner = 'CCS' THEN 'CROSSROADS COMMUNITY SERVICES' END
from [NTFB-OPS-01].dbo.RDO_Agency
 