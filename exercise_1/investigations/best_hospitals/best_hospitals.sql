select p.providerid, h.hospitalname, avg(p.raw_score) ms, stddev(p.raw_score) ss, count(*) num_proc from procedures p
join hospital h
where p.providerid=h.providerid
group by p.providerid, h.hospitalname
order by ms desc,  num_proc desc, ss asc
limit 10
