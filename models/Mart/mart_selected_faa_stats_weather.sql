--In a table mart_selected_faa_stats_weather.sql we want to see for each airport daily:

select *
from {{ref('prep_airports')}}

--unique number of departures connections
--unique number of arrival connections
--how many flight were planned in total (departures & arrivals)
--how many flights were canceled in total (departures & arrivals)
--how many flights were diverted in total (departures & arrivals)
--how many flights actually occured in total (departures & arrivals)
--(optional) how many unique airplanes travelled on average
--(optional) how many unique airlines were in service on average
--(optional) add city, country and name of the airport
--daily min temperature
--daily max temperature
--daily precipitation
--daily snow fall
--daily average wind direction
--daily average wind speed
--daily wnd peakgust