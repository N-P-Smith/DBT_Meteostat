--In a table mart_route_stats.sql we want to see for each route over all time:

select *
from {{ref('prep_airports')}}

--origin airport code
--destination airport code
--total flights on this route
--unique airplanes
--unique airlines
--on average what is the actual elapsed time
--on average what is the delay on arrival
--what was the max delay?
--what was the min delay?
--total number of cancelled
--total number of diverted
--add city, country and name for both, origin and destination, airports