-- SELECT CANDIDATES BY DISTRICT AND PARTY, USED TO TEST AGAINST VPAP LIST --
select e.district, c.first_name, c.last_name, c.party_id, c.candidate_id, ec.election_id
from election_candidates ec 
left join candidates c
	on c.candidate_id = ec.candidate_id
left join elections e 
	on ec.election_id = e.election_id
where e.office_id = 'vahouse'
and `type` = 'primary'
and e.party_id = 'dem'
order by e.district;