select measureid, measurename, std(relative_score)*std(relative_score) as variance
from procedures
group by measureid, measurename
order by variance desc
limit 10
