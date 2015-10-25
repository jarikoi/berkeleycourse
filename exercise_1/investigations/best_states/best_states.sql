select h.state, avg(p.raw_score) ms, stddev(p.raw_score) ss, count(*) num_proc from procedures p
join hospital h
where p.providerid=h.providerid
group by h.state
order by num_proc desc, ms desc, ss asc
limit 10
