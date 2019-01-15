-- -----------------------------------------------------
-- Table offices
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS offices (
  office_id VARCHAR(15) NOT NULL,
  PRIMARY KEY (office_id))
;


-- -----------------------------------------------------
-- Table parties
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS parties (
  party_id VARCHAR(50) NOT NULL,
  party_name VARCHAR(45) NULL,
  website VARCHAR(255) NULL,
  PRIMARY KEY (party_id))
;


-- -----------------------------------------------------
-- Table elections
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS elections (
  election_id SERIAL,
  date DATE NOT NULL,
  type VARCHAR(45) NOT NULL,
  district INT NULL,
  office_id VARCHAR(15) NOT NULL,
  PRIMARY KEY (election_id),
  CONSTRAINT fk_elections_offices1
    FOREIGN KEY (office_id)
    REFERENCES offices (office_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table candidates
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS candidates (
  candidate_id SERIAL,
  first_name VARCHAR(45) NOT NULL,
  middle_name VARCHAR(45) NULL,
  last_name VARCHAR(45) NOT NULL,
  website VARCHAR(255) NULL,
  party_id VARCHAR(50) NOT NULL,
  PRIMARY KEY (candidate_id),
  CONSTRAINT fk_candidates_parties1
    FOREIGN KEY (party_id)
    REFERENCES parties (party_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table election_candidates
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS election_candidates (
  election_id INT NOT NULL,
  candidate_id INT NOT NULL,
  PRIMARY KEY (election_id, candidate_id),
  CONSTRAINT fk_elections_has_candidates_elections
    FOREIGN KEY (election_id)
    REFERENCES elections (election_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_elections_has_candidates_candidates1
    FOREIGN KEY (candidate_id)
    REFERENCES candidates (candidate_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table election_results
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS election_results (
  election_id INT NOT NULL,
  candidate_id INT NOT NULL,
  num_votes INT NULL,
  winner INT NULL,
  PRIMARY KEY (election_id, candidate_id),
  CONSTRAINT fk_election_results_elections1
    FOREIGN KEY (election_id)
    REFERENCES elections (election_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_election_results_candidates1
    FOREIGN KEY (candidate_id)
    REFERENCES candidates (candidate_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

-- -----------------------------------------------------
-- Data for table offices
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO offices (office_id) VALUES ('president');
INSERT INTO offices (office_id) VALUES ('governor');
INSERT INTO offices (office_id) VALUES ('ltgovernor');
INSERT INTO offices (office_id) VALUES ('ushouse');
INSERT INTO offices (office_id) VALUES ('ussenate');
INSERT INTO offices (office_id) VALUES ('vahouse');
INSERT INTO offices (office_id) VALUES ('vasenate');

COMMIT;


-- -----------------------------------------------------
-- Data for table parties
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO parties (party_id, party_name, website) VALUES ('dem', 'Democratic', NULL);
INSERT INTO parties (party_id, party_name, website) VALUES ('rep', 'Republican', NULL);
INSERT INTO parties (party_id, party_name, website) VALUES ('lib', 'Libertarian', NULL);
INSERT INTO parties (party_id, party_name, website) VALUES ('grn', 'Green', NULL);
INSERT INTO parties (party_id, party_name, website) VALUES ('ind', 'Independent', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table elections
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', NULL, 'president');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', NULL, 'ussenate');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 1, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 2, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 3, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 4, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 5, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 6, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 7, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 8, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 9, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 10, 'ushouse');
INSERT INTO elections (election_id, date, type, district, office_id) VALUES (DEFAULT, '2020-11-3', 'general', 11, 'ushouse');

COMMIT;

