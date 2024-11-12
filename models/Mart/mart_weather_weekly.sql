--In a table mart_weather_weekly.sql we want to see all weather stats from the prep_weather_daily model aggregated weekly.

select *
from {{ref('prep_airports')}}

--consider whether the metric should be Average, Maximum, Minimum, Sum or Mode