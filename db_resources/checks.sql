
-- check for duplicates
select * from election_candidates ec
left join elections e
on e.election_id = ec.election_id
left join candidates c 
on ec.candidate_id = c.candidate_id
where ec.candidate_id in (
select candidate_id from election_candidates
group by candidate_id
having count(candidate_id) > 1);

-- check for candidates not in election_candidates
select * from candidates
where candidate_id not in (
select candidate_id from election_candidates);