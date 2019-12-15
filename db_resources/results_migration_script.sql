-- TODO: 
-- 	rename offices to vasenate, vahouse
--  select unique general candidates into stage_candidates
-- 	delete superfluous WI candidate from stage_candidates

use vaelects;

-- new results table to hold results from VASBE CSV file
create table results_csv (
	id int not null auto_increment,
	first_name varchar(255),
	middle_name varchar(255),
	last_name varchar(255),
	suffix varchar(5),
    party varchar(50),
    office varchar(50),
    district varchar(50),
	votes int,
    primary key (id)
);

-- delete local races
delete
from stage_results
where office not in ('house of delegates', 'state senate');

select c.first_name, c.last_name, r.last_name
from candidates c
	left join results_csv r
		on c.last_name = r.last_name
where r.last_name is not null
group by c.last_name;

select first_name, last_name
from candidates
where last_name not in (
	select distinct(last_name)
    from stage_results);

-- verify no local races exist
select *
from stage_results
where office not in ('house of delegates', 'state senate');
-- if so, delete
delete
from stage_results
where office not in ('house of delegates', 'state senate');

-- update empty sbe_id for write in votes
update stage_results
set sbe_id = 'WI'
where last_name = 'WRITE IN VOTES'
and sbe_id = '';

-- update party for WI
update stage_results
set party = 'Republican'
where party = '';

-- update office to match current format
update stage_results
set office = 'vahouse'
where office = 'House of Delegates';
update stage_results
set office = 'vasenate'
where office = 'State Senate';

-- update party to match current format
update stage_results
set party = 'rep'
where party = 'Republican';
update stage_results
set party = 'dem'
where party = 'Democratic';

select office, district, party
from stage_results
group by office, district, party;

select first_name, last_name, party, sum(votes)
from stage_results
group by sbe_id;

-- Group by office, district, and sbe_id for selecting into new results table
select office, district, party, sbe_id, first_name, last_name, sum(votes)
from stage_results
group by office, district, party, sbe_id;

-- creat candidate staging table
create table stage_candidates (
	candidate_id int not null auto_increment,
    sbe_id varchar(255),
	first_name varchar(255),
    middle_name varchar(255),
    last_name varchar(255),
    suffix varchar(255),
    party varchar(8),
    primary key (candidate_id)
);

insert into stage_candidates(sbe_id, first_name, middle_name, last_name, suffix, party)
select distinct sbe_id, first_name, middle_name, last_name, suffix, party
from stage_results
where election_type = 'general'
and last_name != 'write in votes';

-- select elections into staging table from stage_results
insert into stage_elections (`date`, office_id, district, `type`)
select '2019-11-05', office, district, election_type
from stage_results
where election_type = 'general'
group by office, district;

-- select candidates into stage_elections_candidates from stage_results & stage_elections
insert into stage_election_candidates (election_id, candidate_id)
select e.election_id, c.candidate_id
from stage_results r 
	left join stage_candidates c 
		on r.sbe_id = c.sbe_id
	left join stage_elections e 
		on r.office = e.office_id
        and r.district = e.district
where r.election_type = 'general'
and r.last_name != 'write in votes'
group by r.sbe_id
order by r.office, r.district;

select election_id, count(candidate_id)
from stage_election_candidates
group by election_id;

insert into candidates (candidate_id, first_name, middle_name, last_name, suffix, party_id)
select candidate_id, first_name, middle_name, last_name, suffix, party
from stage_candidates;

insert into elections (election_id, date, type, district, office_id)
select election_id, date, type, district, office_id
from stage_elections;

insert into election_candidates (election_id, candidate_id)
select election_id, candidate_id
from stage_election_candidates;

-- select all candidates, results, and corresponding candidate and election IDs for insert into results table
select c.candidate_id, c.sbe_id, e.election_id, r.first_name, r.middle_name, r.last_name, r.party, r.office, r.district, sum(r.votes)
from results_csv r 
	left join stage_candidates c 
		on r.first_name = c.first_name
        and r.middle_name = c.middle_name
        and r.last_name = c.last_name
	left join stage_election_candidates e
		on c.candidate_id = e.candidate_id
group by c.first_name, c.middle_name, c.last_name, r.office, r.district
order by election_id;

select distinct e.election_id, r.office, r.district
from results_csv r 
	left join stage_elections e
		on r.office = e.office_id
		and r.district = e.district
order by r.office, r.district;

update results_csv
set district = replace(district, district, cast(district as unsigned));

-- TODO
-- give write ins candidate_id of 0
-- add write in to stage_election_candidates for whichever election has write ins 