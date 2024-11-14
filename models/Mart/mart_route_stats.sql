--In a table mart_route_stats.sql we want to see for each route over all time:

--origin airport code

select
    flight_date,
    dep_time,
    origin as airport_code
from prep_flights,
order by flight_date, dep_time, origin;

--destination airport code

select
    flight_date,
    arr_time,
    dest as airport_code
from prep_flights
order by flight_date, arr_time, dest;

--total flights on this route

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*)
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--unique airplanes

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*) as num_flights
    count(unique tail_number) as num_aircraft
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--unique airlines

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*) as flights,
    count(unique aircraft) as num airlines
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--on average what is the actual elapsed time

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*) as flights,
    avg(actual_elapsed_time) as avg_elapsed_time
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--on average what is the delay on arrival

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*) as flights,
    avg(arr_delay) as avg_arr_delay
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--what was the max delay?

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*),
    max(dep_delay),
    max(arr_delay)
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--what was the min delay?

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*),
    min(dep_delay),
    min(arr_delay)
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--total number of cancelled

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*),
    sum(cancelled)
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--total number of diverted

select
    flight_date,
    dep_time,
    origin,
    arr_time,
    dest,
    count(*),
    sum(diverted)
from prep_flights
group by origin, dest
order by flight_date, dep_time, origin;

--add city, country and name for both, origin and destination, airports

with airport_details as
    (select
        faa,
        name,
        city,
        country
    from prep_airports),
departure_details as
    (select
        pf.flight_date,
        pf.dep_time,
        pf.origin,
        ad.name,
        ad.city,
        ad.country,
        count(*)
    from prep_flights pf
    join airport_details ad
    on pf.origin = ad.faa),
arrival_details as
    (select
        pf.flight_date,
        pf.dep_time,
        pf.dest,
        ad.name,
        ad.city,
        ad.country,
        count(*)
    from prep_flights pf
    join airport_details ad
    on pf.dest = ad.faa)
select
    dep.*,
    arr.*
from departure_details dep
join arrival_details arr
on dep.flight_date = arr.flight_date, dep.dep_time = arr.dep_time
group by origin, dest
order by flight_date, dep_time, origin;