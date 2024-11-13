--In a table mart_selected_faa_stats_weather.sql we want to see for each airport daily:

--unique number of departures connections

select
    a.name,
    a.faa,
    count(distinct f.tail_number)
from prep_airports a
join prep_flights f
on a.faa = f.origin
where f.cancelled = 0
group by a.faa
order by a.name;

--unique number of arrival connections

select
    a.name,
    a.faa,
    count(distinct f.tail_number)
from prep_airports a
join prep_flights f
on a.faa = f.dest
where f.cancelled = 0
    and f.diverted = 0
group by a.faa
order by a.name;

--how many flight were planned in total (departures & arrivals)

select
    a.name,
    a.faa,
    count(f.origin)
from prep_airports a
join prep_flights f
on a.faa = f.origin
group by a.faa
order by a.name;

select
    a.name,
    a.faa,
    count(f.dest)
from prep_airports a
join prep_flights f
on a.faa = f.dest
group by a.faa
order by a.name;

--how many flights were canceled in total (departures & arrivals)

select
    a.name,
    a.faa,
    sum(f.cancelled)
from prep_airports a
join prep_flights f
on a.faa = f.origin
group by a.faa
order by a.name;

select
    a.name,
    a.faa,
    sum(f.cancelled)
from prep_airports a
join prep_flights f
on a.faa = f.dest
group by a.faa
order by a.name;

--how many flights were diverted in total (departures & arrivals)

select
    a.name,
    a.faa,
    sum(f.diverted)
from prep_airports a
join prep_flights f
on a.faa = f.origin
group by a.faa
order by a.name;

select
    a.name,
    a.faa,
    sum(f.diverted)
from prep_airports a
join prep_flights f
on a.faa = f.dest
group by a.faa
order by a.name;

--how many flights actually occured in total (departures & arrivals)

select
    a.name,
    a.faa,
    count(*)
from prep_airports a
join prep_flights f
on a.faa = f.origin
where f.cancelled = 0
group by a.faa
order by a.name;

select
    a.name,
    a.faa,
    count(*)
from prep_airports a
join prep_flights f
on a.faa = f.dest
where f.cancelled = 0
    and f.diverted = 0
group by a.faa
order by a.name;

--(optional) how many unique airplanes travelled on average

select
    a.name,
    a.faa,
    count(unique f.tail_number)
from prep_airports a
join prep_flights f
on a.faa = f.origin
where f.cancelled = 0
group by a.faa
order by a.name;

--(optional) how many unique airlines were in service on average

select
    a.name,
    a.faa,
    count(unique f.airline)
from prep_airports a
join prep_flights f
on a.faa = f.origin
group by a.faa
order by a.name;

--(optional) add city, country and name of the airport

select
    name,
    faa,
    city,
    country
from prep_airports
order by name;

--daily min temperature

select,
    a.name,
    a.faa,
    min(w.min_temp_c)
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
group by a.faa
order by a.name;

--daily max temperature

select,
    a.name,
    a.faa,
    max(w.max_temp_c)
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
group by a.faa
order by a.name;

--daily precipitation

select,
    a.name,
    a.faa,
    w.date,
    w.precipitation_mm
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
where w.precipitation_mm > 0
order by w.date;

--daily snow fall

select,
    a.name,
    a.faa,
    w.date,
    w.max_snow_mm
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
where w.max_snow_mm > 0
order by w.date;

--daily average wind direction

select,
    a.name,
    a.faa,
    w.date,
    w.avg_wind_direction
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
order by w.date;

--daily average wind speed

select,
    a.name,
    a.faa,
    w.date,
    w.avg_wind_speed_kmh
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
order by w.date;

--daily wnd peakgust

select,
    a.name,
    a.faa,
    w.date,
    w.wind_peakgust_kmh
from prep_airports a
join prep_weather_daily w
on a.faa = w.station_id
order by w.date;