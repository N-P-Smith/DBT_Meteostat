--unique number of departures connections

select *
from prep_flights;

--unique number of arrival connections

select
	origin,
	count(*)
from prep_flights
group by origin;

--how many flight were planned in total (departures & arrivals)

select
	origin,
	count(*) as num_unique_dep,
	count(sched_dep_time) as dep_planned
from prep_flights
group by origin;

select
	dest,
	count(*) as num_unique_arr,
	count(sched_arr_time) as arr_planned
from prep_flights
group by dest;

--how many flights were canceled in total (departures & arrivals)

select
	origin,
	count(*) as num_unique_dep,
	count(sched_dep_time) as dep_planned,
	sum(cancelled) as dep_cancelled
from prep_flights
group by origin;

select
	dest,
	count(*) as num_unique_arr,
	count(sched_arr_time) as arr_planned,
	sum(cancelled) as arr_cancelled
from prep_flights
group by dest;

--how many flights were diverted in total (departures & arrivals)

select
	origin,
	count(*) as num_unique_dep,
	count(sched_dep_time) as dep_planned,
	sum(cancelled) as dep_cancelled,
	sum(diverted) as dep_diverted
from prep_flights
group by origin;

select
	dest,
	count(*) as num_unique_arr,
	count(sched_arr_time) as arr_planned,
	sum(cancelled) as arr_cancelled,
	sum(diverted) as arr_diverted
from prep_flights
group by dest;

--how many flights actually occured in total (departures & arrivals)

select
	origin,
	count(*) as num_unique_dep,
	count(sched_dep_time) as dep_planned,
	sum(cancelled) as dep_cancelled,
	sum(diverted) as dep_diverted,
	count(dep_time) as dep_flights
from prep_flights
group by origin;

select
	dest,
	count(*) as num_unique_arr,
	count(sched_arr_time) as arr_planned,
	sum(cancelled) as arr_cancelled,
	sum(diverted) as arr_diverted,
	count(arr_time) as arr_flights
from prep_flights
group by dest;

--(optional) how many unique airplanes travelled on average

select
	origin,
	count(*) as num_unique_dep,
	count(sched_dep_time) as dep_planned,
	sum(cancelled) as dep_cancelled,
	sum(diverted) as dep_diverted,
	count(dep_time) as dep_flights,
	count(distinct tail_number) as num_dep_planes
from prep_flights
group by origin;

select
	dest,
	count(*) as num_unique_arr,
	count(sched_arr_time) as arr_planned,
	sum(cancelled) as arr_cancelled,
	sum(diverted) as arr_diverted,
	count(arr_time) as arr_flights,
	count(distinct tail_number) as num_arr_planes
from prep_flights
group by dest;

--(optional) how many unique airlines were in service on average

select
	origin,
	count(*) as num_unique_dep,
	count(sched_dep_time) as dep_planned,
	sum(cancelled) as dep_cancelled,
	sum(diverted) as dep_diverted,
	count(dep_time) as dep_flights,
	count(distinct tail_number) as num_dep_planes,
	count(distinct airline)	as num_dep_airlines
from prep_flights
group by origin;

select
	dest,
	count(*) as num_unique_arr,
	count(sched_arr_time) as arr_planned,
	sum(cancelled) as arr_cancelled,
	sum(diverted) as arr_diverted,
	count(arr_time) as arr_flights,
	count(distinct tail_number) as num_arr_planes,
	count(distinct airline) as num_arr_airlines
from prep_flights
group by dest;

--add city, country and name of the airport

with departures as 
	(select
		origin as faa,
		count(*) as num_unique_dep,
		count(sched_dep_time) as dep_planned,
		sum(cancelled) as dep_cancelled,
		sum(diverted) as dep_diverted,
		count(dep_time) as dep_flights,
		count(distinct tail_number) as num_dep_planes,
		count(distinct airline)	as num_dep_airlines
	from prep_flights
	group by origin),
arrivals as
	(select
		dest as faa,
		count(*) as num_unique_arr,
		count(sched_arr_time) as arr_planned,
		sum(cancelled) as arr_cancelled,
		sum(diverted) as arr_diverted,
		count(arr_time) as arr_flights,
		count(distinct tail_number) as num_arr_planes,
		count(distinct airline) as num_arr_airlines
	from prep_flights
	group by dest),
total_stats as
	(select
		d.faa,
		num_unique_dep,
		num_unique_arr,
		(dep_planned + arr_planned) as total_planned,
		(dep_cancelled + arr_cancelled) as total_cancelles,
		(dep_diverted + arr_diverted) as total_diverted,
		(dep_flights + arr_flights) as total_flights
	from departures d
	join arrivals a
	on d.faa = a.faa)
select
	ap.city,
	ap.country,
	ap.name,
	t.*
from total_stats t
left join prep_airports ap
using (faa)