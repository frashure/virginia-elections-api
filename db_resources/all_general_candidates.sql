select e.office_id, e.district, c.first_name, c.last_name, c.party_id
from elections e
	left join election_candidates ec
		on e.election_id = ec.election_id
	left join candidates c
		on ec.candidate_id = c.candidate_id
where e.election_id in (
	select election_id
	from election_candidates
    where type = 'general'
    group by election_id
    having count(candidate_id) > 0);