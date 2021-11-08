select t.id, users.name, t.seat_number from tickets as t inner join users on t.user=users.id and t.train=11 order by t.seat_number asc;

select u.id, u.name, count(*) as trains_count, sum(tr.distance) as total_distance from tickets as t inner join users as u 
on t.user=u.id inner join trains as tr on tr.id=t.train  group by t.user order by total_distance desc limit 1, 6;

select tr.id, types.name, s1.name as src_stn, s2.name as dst_stn, Timediff(arrival, departure) as travel_time from trains as tr 
inner join types on types.id=tr.type inner join stations as s1 on s1.id=source inner join stations as s2 on s2.id=destination order by travel_time desc limit 1, 6;

select types.name, s1.name as src_stn, s2.name as dst_stn, departure, arrival, round(types.fare_rate*distance/1000) as fare 
from trains as tr inner join types on types.id=tr.type inner join stations as s1 on s1.id=source inner join stations as s2 on s2.id=destination order by departure asc;

select tr.id, ty.name, s1.name as src_stn, s2.name as dst_stn, count(tickets.id) as occupied, max_seats as maximum from types as ty inner join trains as tr on tr.type=ty.id inner join stations 
as s1 on s1.id=tr.source inner join stations as s2 on s2.id=tr.destination inner join tickets on tickets.train=tr.id group by tr.id order by tr.id asc;

select tr.id, ty.name, s1.name as src_stn, s2.name as dst_stn, count(tickets.id) as occupied, max_seats as maximum from types as ty inner join trains as tr on tr.type=ty.id inner join stations 
as s1 on s1.id=tr.source inner join stations as s2 on s2.id=tr.destination left join tickets on tickets.train=tr.id group by tr.id order by tr.id asc;