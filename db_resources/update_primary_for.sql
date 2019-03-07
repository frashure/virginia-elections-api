
-- check number of primary elections
select * from elections
where type = 'primary';

-- number of results here should match first query
select *
from elections a
inner join elections b
	on a.district = b.district
where a.`type` = 'primary'
	and b.`type` = 'general'
    and a.office_id = b.office_id
    and a.district = b.district
order by a.office_id, a.district;

-- update; affected rows should match first two queries
update elections as a
inner join elections as b
	on a.district = b.district
set a.primary_for = b.election_id
where a.`type` = 'primary'
	and b.`type` = 'general'
    and a.office_id = b.office_id
    and a.district = b.district;