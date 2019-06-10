-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: us-cdbr-iron-east-01.cleardb.net    Database: heroku_d25b1017699add1
-- ------------------------------------------------------
-- Server version	5.5.62-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidates` (
  `candidate_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `party_id` varchar(50) NOT NULL,
  PRIMARY KEY (`candidate_id`),
  KEY `fk_candidates_parties1_idx` (`party_id`),
  CONSTRAINT `fk_candidates_parties1` FOREIGN KEY (`party_id`) REFERENCES `parties` (`party_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10691 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (1,'Ibraheem',NULL,'Samirah','https://samirah4delegate.com/','dem'),(11,'Carrie',NULL,'Coyner','http://www.carriecoyner.com/','rep'),(21,'Gregg',NULL,'Nelson',NULL,'rep'),(31,'Scott',NULL,'Wyatt',NULL,'rep'),(41,'Chris',NULL,'Peace',NULL,'rep'),(51,'Ben',NULL,'Hixon',NULL,'dem'),(61,'Rich',NULL,'Breeden',NULL,'rep'),(71,'Bryce',NULL,'Reeves',NULL,'rep'),(81,'Eric',NULL,'Stamps','http://ericstamps.com/','dem'),(91,'Morgan',NULL,'Goodman','https://goodmanfordelegate.com/','dem'),(101,'Laura',NULL,'Galante','https://galantefordelegate.com/','dem'),(111,'Tristan',NULL,'Shields','https://tristanshields.com/','dem'),(121,'John','G','Avioli',NULL,'rep'),(131,'David',NULL,'Bourne',NULL,'rep'),(141,'Jenni',NULL,'Kitchen',NULL,'dem'),(151,'Lauren',NULL,'Thompson',NULL,'dem'),(161,'Cathy',NULL,'Copeland','https://www.cathycopeland.org/','dem'),(171,'Brent',NULL,'Finnegan','https://brentfinnegan.com/','dem'),(181,'Paul',NULL,'Milde','http://paulmilde.com/','rep'),(191,'Bob',NULL,'Thomas',NULL,'rep'),(201,'Dan',NULL,'Helmer','https://www.danhelmer.com/','dem'),(211,'Alfonso',NULL,'Lopez','http://www.alfonsolopez.org/','dem'),(221,'JD',NULL,'Spain','https://jdspainfordelegate49.democrat/','dem'),(231,'Sally',NULL,'Hudson','https://www.sallyforvirginia.com/','dem'),(241,'David',NULL,'Toscano','https://davidtoscano.com/','dem'),(251,'Hassan','Minhaj','Ahmad','https://www.hassan4va.com/','dem'),(261,'Akshay',NULL,'Bhamidipati',NULL,'dem'),(271,'Suhas',NULL,'Subramanyam','http://suhasforvirginia.com/','dem'),(281,'Monique','Nicole','Gatling',NULL,'dem'),(291,'Jeion',NULL,'Ward','https://jeionward.com/','dem'),(301,'Mark',NULL,'Downey','https://downeyforvirginia.com/','dem'),(311,'Rebecca',NULL,'Leser','https://www.rebeccaforvirginia.com/','dem'),(321,'Chris',NULL,'Mayfield',NULL,'dem'),(331,'Lynwood',NULL,'Lewis','http://lynwoodlewis.com/','dem'),(341,'Willie',NULL,'Randall',NULL,'dem'),(351,'Eileen',NULL,'Bidell','https://www.bedellforvirginia.com/','dem'),(361,'Ghazala',NULL,'Hashmi',NULL,'dem'),(371,'Veena',NULL,'Lothe','https://www.veenalothe.com/','dem'),(381,'Marques',NULL,'Jones','https://marquesjones.com/','dem'),(391,'John',NULL,'Bell','https://voteforjohnbell.com/','dem'),(401,'Jasmine',NULL,'Moawad-Barrientos',NULL,'dem'),(411,'Lucero',NULL,'Wiley','https://www.lucerowiley.com/','dem'),(421,'Barbara',NULL,'Favola','https://barbarafavola.org/','dem'),(431,'Nicole',NULL,'Merlene','https://www.nicolemerlene.com/','dem'),(441,'Dick',NULL,'Saslaw','http://www.dicksaslaw.com/','dem'),(451,'Yasmine','Parinaz','Taeb','https://yasmineforvirginia.com/','dem'),(461,'Monty',NULL,'Mason','http://www.masonforvirginia.com/','dem'),(471,'Mamie',NULL,'Locke','http://www.senatorlocke.com/','dem'),(481,'Herb',NULL,'Jones','http://herbjonesforvirginia.com/','dem'),(491,'Tommy',NULL,'Norment','http://www.senatornorment.com/','rep'),(501,'Ryan',NULL,'McDougle',NULL,'rep'),(511,'Lionell',NULL,'Spruill Sr','https://www.spruillforsenate.com/','dem'),(521,'Jeff',NULL,'Staples',NULL,'grn'),(531,'Frank',NULL,'Wagner','http://www.wagnervasenate.com/','rep'),(541,'Missy','Cotter','Smasal','https://www.missyforsenate.com/','dem'),(551,'Bill',NULL,'DeSteph','http://www.billdesteph.com/','rep'),(561,'Jennifer',NULL,'McClellan','http://www.jennifermcclellan.com/','dem'),(571,'Glen',NULL,'Sturtevant','http://www.glensturtevant.com/','rep'),(581,'Amanda',NULL,'Pohl','https://pohlforvirginia.com/','dem'),(591,'Amanda',NULL,'Chase','https://www.chase4senate.com/','rep'),(601,'Siobhan',NULL,'Dunnavant','http://dunnavantdelivers.com/','rep'),(611,'Mike',NULL,'Buscher','https://www.buscher4senate.com/','rep'),(621,'Ron',NULL,'Meyer','https://ronmeyer.com/','rep'),(631,'John',NULL,'Cosgrove',NULL,'rep'),(641,'Frank',NULL,'Ruff','http://www.senatorfrankruff.com/','rep'),(651,'Rosalyn',NULL,'Dance',NULL,'dem'),(661,'Louise',NULL,'Lucas',NULL,'dem'),(671,'David',NULL,'Suetterlein',NULL,'rep'),(681,'Bill',NULL,'Stanley','http://stanleyforsenate.com/','rep'),(691,'John',NULL,'Edwards','http://www.johnedwardsva.com/','dem'),(701,'Mark',NULL,'Peake','http://www.peakeforsenate.com/','rep'),(711,'Steve',NULL,'Newman','http://www.senatornewman.com/','rep'),(721,'Annette',NULL,'Hyde','https://annetteservesva.com/','dem'),(731,'Emmett',NULL,'Hanger','http://www.emmetthanger.com/','rep'),(741,'Creigh',NULL,'Deeds','https://www.senatordeeds.com/','dem'),(751,'April',NULL,'Moore','https://www.aprilmooreforsenate.com/','dem'),(761,'Mark',NULL,'Obenshain','http://www.markobenshain.com/','rep'),(771,'Ronnie',NULL,'Ross','https://www.ronnieross.com/','dem'),(781,'Jill',NULL,'Vogel','http://www.senatorjillvogel.com/','rep'),(791,'Richard',NULL,'Stuart','https://www.stuartforsenate.com/','rep'),(801,'Jeremy',NULL,'McPike','http://www.mcpikeforsenate.com/','dem'),(811,'Adam',NULL,'Ebbin','http://www.adamebbin.com/','dem'),(821,'Janet',NULL,'Howell','http://www.janethowell.com/','dem'),(831,'Sharafat',NULL,'Hussain','http://sharafathussainva.com','dem'),(841,'Jennifer',NULL,'Boysko','https://www.jenniferboysko.com/','dem'),(851,'Chap',NULL,'Petersen','https://fairfaxsenator.com/','dem'),(861,'Scott',NULL,'Surovell','http://www.scottsurovell.org/','dem'),(871,'Dave',NULL,'Marsden','http://marsdenforsenate.nationbuilder.com/','dem'),(881,'Ben',NULL,'Chafin','https://benchafin.com','rep'),(891,'George',NULL,'Barker',NULL,'dem'),(901,'Bill',NULL,'Carrico','https://senatorbillcarrico.com/','rep'),(911,'Dean','D','Davison',NULL,'lib'),(921,'James','W','Jobe','https://www.jobefordelegate.com/','lib'),(931,'Terry',NULL,'Kilgore','http://www.delegatekilgore.com/','rep'),(941,'Will',NULL,'Morefield','http://www.morefieldfordelegate.com/','rep'),(951,'Todd',NULL,'Pillon','http://www.toddpillion.com/','rep'),(961,'Israel',NULL,'O\'Quinn','http://www.israeloquinn.com/','rep'),(971,'Jeff',NULL,'Campbell','http://votejeffcampbell.com/','rep'),(981,'Nick',NULL,'Rush','https://www.nickrush.com/','rep'),(991,'Joe',NULL,'McNamara','https://joeforva.com/','rep'),(1001,'Charles',NULL,'Pointdexter','http://www.votepoindexter.com/','rep'),(1011,'Danny',NULL,'Marshall','http://dannymarshall.com/','rep'),(1021,'Todd',NULL,'Gilbert','http://www.delegatetoddgilbert.com/','rep'),(1031,'Les',NULL,'Adams','http://www.lesadams.org/','rep'),(1041,'Chris',NULL,'Head','http://www.delegatechrishead.com/','rep'),(1051,'Michael',NULL,'Webert','https://www.michael-webert.com/','rep'),(1061,'Terry',NULL,'Austin','http://austinfordelegate.com/','rep'),(1091,'Shannnon',NULL,'Kane',NULL,'rep'),(1101,'Kathy',NULL,'Byron','http://www.kathybyron.com/','rep'),(1111,'Scott',NULL,'Garrett','http://www.tscottgarrett.com/','rep'),(1121,'Ronnie',NULL,'Campbell','https://www.voteronniecampbell.com/','rep'),(1131,'Steve',NULL,'Landes','http://www.stevelandes.com/','rep'),(1141,'Tony',NULL,'Wilt','https://delegatewilt.com/','rep'),(1151,'Roxann',NULL,'Robinson','https://www.roxannrobinson.com/','rep'),(1181,'Chris',NULL,'Collins','https://www.delegatecollins.com/','rep'),(1191,'Nick',NULL,'Freitas','http://www.nickjfreitas.com/','rep'),(1201,'DJ',NULL,'Jordan','https://votedj.com/','rep'),(1211,'Dave',NULL,'LaRock','https://www.votelarock.us/','rep'),(1221,'Tim',NULL,'Hugo','https://timhugo.com/','rep'),(1231,'Ian',NULL,'Lovejoy','https://votelovejoy.com/','rep'),(1241,'Bobby',NULL,'Orrock',NULL,'rep'),(1251,'Buddy',NULL,'Fowler','https://www.buddyfowler.com/','rep'),(1261,'John',NULL,'McGuire','https://www.mcguire56.com/','rep'),(1271,'Rob',NULL,'Bell','http://delegaterobbell.com/','rep'),(1281,'Matt',NULL,'Fariss','https://www.mattfariss.com/','rep'),(1291,'James',NULL,'Edmunds','https://www.friendsofjamesedmunds.com/','rep'),(1301,'Tommy',NULL,'Wright',NULL,'rep'),(1311,'Emily',NULL,'Brewer','http://brewerforva.com/','rep'),(1321,'Lee',NULL,'Ware','http://lee-ware.com/','rep'),(1331,'Kirk',NULL,'Cox','http://www.kirkcox.com/','rep'),(1341,'Garrison','R','Coward','https://www.garrisoncoward.com/','rep'),(1351,'Mary','Margaret','Kastelberg','https://www.kastelberg4va.com/','rep'),(1361,'Chris',NULL,'Jones','http://schrisjones.com/','rep'),(1371,'Jay',NULL,'Leftwich','http://jayleftwich.com/','rep'),(1381,'Barry',NULL,'Knight','http://barrydknight.com/','rep'),(1391,'Jason',NULL,'Miyares','http://jasonmiyares.com/','rep'),(1401,'Chris',NULL,'Stolle','https://chrisstolle.com/','rep'),(1411,'Glenn',NULL,'Davis','https://www.glennrdavis.com/','rep'),(1421,'Rocky',NULL,'Holcomb','http://rockyholcomb.com/','rep'),(1431,'William','D','Drennan Jr',NULL,'rep'),(1441,'Mark',NULL,'Cole','http://marklcole.com/','rep'),(1451,'Gordon',NULL,'Helsel',NULL,'rep'),(1461,'David',NULL,'Yancey','http://davidyanceyfordelegate.com/','rep'),(1471,'Brenda',NULL,'Pogge','https://www.brendapogge.com/','rep'),(1481,'Keith',NULL,'Hodges','http://www.keithhodges98.com/','rep'),(1491,'Margaret',NULL,'Ransone','http://www.margaretransone.com/','rep'),(1501,'Rob',NULL,'Bloxom',NULL,'rep'),(1511,'Jennifer','Carrol','Foy','https://www.jennifercarrollfoy.org/','dem'),(1521,'Todd',NULL,'Fearer','http://fearerfordelegate.com/','dem'),(1531,'Wendy',NULL,'Gooditis','https://www.wendygooditis.com/','dem'),(1541,'Sam',NULL,'Rasoul','http://www.sam4roanoke.com/','dem'),(1551,'Chris',NULL,'Hurst','https://www.hurst4delegate.com/','dem'),(1561,'Danica',NULL,'Roem','https://delegatedanicaroem.com/','dem'),(1571,'Kelly',NULL,'Fowler','https://www.delegatefowler.com/','dem'),(1581,'Jennifer','K','Woofter','https://www.jenniferwoofterfordelegate.com/','dem'),(1591,'Larry',NULL,'Barnett','https://www.barnett4delegate.com/','dem'),(1601,'Joshua',NULL,'Cole','https://jgcole.org/','dem'),(1611,'Elizabeth',NULL,'Guzman','https://elizabethguzmanforvirginia.com/','dem'),(1621,'David',NULL,'Reid','https://www.delegatedavidreid.com/','dem'),(1631,'Mavis',NULL,'Taintor','https://www.mavisfordelegate.com/','dem'),(1641,'Kathleen',NULL,'Murphy','http://www.murphyfordelegate.com/','dem'),(1651,'Mark',NULL,'Keam','http://markkeam.com/','dem'),(1661,'Ken',NULL,'Plum','https://www.kenplum.com/','dem'),(1671,'David',NULL,'Bulova','http://www.davidbulova.com/','dem'),(1681,'Kaye',NULL,'Kory','http://www.kayekory.com/','dem'),(1691,'Andres','Felipe','Jimenez','https://virginia38.com/','dem'),(1701,'Vivian',NULL,'Watts','https://www.vivianwatts.com/','dem'),(1711,'Eileen',NULL,'Filler-Corn','http://www.eileenfillercorn.com/','dem'),(1721,'Kathy',NULL,'Tran','https://www.kathyfordelegate.com/','dem'),(1731,'Mark',NULL,'Sickles','http://www.marksickles.com/','dem'),(1741,'Paul',NULL,'Krizek','http://www.paulkrizek.com/','dem'),(1751,'Mark',NULL,'Levine','https://www.markfordelegate.com/','dem'),(1761,'Charniele',NULL,'Herring','http://www.charnieleherring.com/','dem'),(1771,'Patrick',NULL,'Hope','http://www.hopeforvirginia.org/','dem'),(1781,'Rip',NULL,'Sullivan','http://www.ripsullivan.com/','dem'),(1791,'Lee',NULL,'Carter','http://www.carterforvirginia.com/','dem'),(1801,'Hala',NULL,'Ayala','https://www.ayalafordelegate.com/','dem'),(1811,'Luke',NULL,'Torian','http://www.delegatetorian.com/','dem'),(1821,'Marcus',NULL,'Simon','http://marcussimon.com/','dem'),(1831,'Elizabeth',NULL,'Alcorn',NULL,'dem'),(1841,'Tim',NULL,'Hickey','https://sites.google.com/view/timhickeyfordelegate/','dem'),(1851,'Trudy','Bell','Berry','https://www.trudyberry.com/','dem'),(1861,'Sheila',NULL,'Bynum-Coleman',NULL,'dem'),(1871,'Lashrecse',NULL,'Aird',NULL,'dem'),(1881,'Karrie',NULL,'Delaney','www.karriedelaney.com/','dem'),(1891,'Dawn',NULL,'Adams','https://adamsfordelegate.com/','dem'),(1901,'Betsy',NULL,'Carr','http://www.betsycarr.org/','dem'),(1911,'Delores',NULL,'McQuinn','http://mcquinn4senate.weebly.com','dem'),(1921,'Jeff',NULL,'Bourne','http://www.jeffmbourne.com/','dem'),(1931,'Schuyler',NULL,'VanValkenburg','https://www.vanvalkenburg4va.com/','dem'),(1941,'Debra',NULL,'Rodman','https://rodmanfordelegate.com/','dem'),(1951,'Lamont',NULL,'Bagby','https://www.lamontbagby.org/','dem'),(1961,'Roslyn',NULL,'Tyler','https://www.delegatetyler.com/','dem'),(1971,'Cliff',NULL,'Hayes','https://www.cliffhayes.com/','dem'),(1981,'Steve',NULL,'Heretick','https://www.steveheretick.com/','dem'),(1991,'Matthew',NULL,'James','http://www.delegatematthewjames.com/','dem'),(2001,'Nancy',NULL,'Guy',NULL,'dem'),(2011,'Karen',NULL,'Mallard',NULL,'dem'),(2021,'Cheryl',NULL,'Turpin','https://cherylturpinforvb.com/','dem'),(2031,'Jess',NULL,'Foster','https://www.jessfoster.org/','dem'),(2041,'Jay',NULL,'Jones','http://www.jayjones.vote/','dem'),(2051,'Joe',NULL,'Lindsey','http://delegatejoelindsey.com/','dem'),(2061,'Michael',NULL,'Wade','https://www.michaelwadefordelegate.com/','dem'),(2071,'Mike',NULL,'Mullin','http://www.mullinforvirginia.com/','dem'),(2081,'Shelly',NULL,'Simonds','https://www.simondsfordelegate.com/','dem'),(2091,'Cia',NULL,'Price','https://www.pricefordelegate.com/','dem'),(2101,'Francis',NULL,'Edwards','http://www.edwards4delegate.com/','dem'),(2111,'Connie','Haines','Hutchinson','http://www.conniehutchinson.com/','ind'),(2121,'Linnard','Keith','Harris Jr',NULL,'ind'),(2131,'Jennifer',NULL,'Lewis',NULL,'dem'),(2141,'Phil',NULL,'Hernandez','https://www.philforvirginia.com/','dem'),(2151,'Randy',NULL,'Minchew','http://www.delegaterandyminchew.com/','rep'),(2161,'Wayne',NULL,'Powell','https://www.powellsenateva.com/','dem'),(2171,'Amy',NULL,'Laufer','https://www.lauferforvirginia.com/','dem'),(2181,'Geary',NULL,'Higgins',NULL,'rep'),(2191,'Mark',NULL,'Wolfe',NULL,'dem'),(2201,'Kim',NULL,'Howard','http://kim4va.com/','dem'),(2211,'Tina',NULL,'Freitas','https://www.tina4va.com/','rep'),(2221,'Rich',NULL,'Anderson','https://www.richanderson.com','rep'),(9999,'Write',NULL,'In',NULL,'wi'),(10011,'Beverly',NULL,'Harrison',NULL,'dem'),(10021,'Ken',NULL,'Heath',NULL,'ind'),(10031,'Chris',NULL,'Runion',NULL,'rep'),(10041,'William',NULL,'Wampler III',NULL,'rep'),(10051,'David',NULL,'Eaton',NULL,'rep'),(10071,'Richard',NULL,'Fox',NULL,'rep'),(10081,'Marshall',NULL,'Pattie',NULL,'rep'),(10091,'Susan',NULL,'Hippen','https://hippenforva.com/','dem'),(10101,'Zachary',NULL,'Brown','https://www.zacharyforvirginia.com/','dem'),(10111,'Dale',NULL,'Sturdifen',NULL,'rep'),(10121,'Laura',NULL,'Sellers',NULL,'dem'),(10131,'Heather',NULL,'Mitchell','http://mitchellfordelegate.com','rep'),(10141,'Christian',NULL,'Worth','https://www.worthfordelegate.com/','dem'),(10151,'Steven',NULL,'Adragna',NULL,'rep'),(10161,'GayDonna',NULL,'Vandergriff','https://www.gaydonnavandergriff.com/','rep'),(10171,'Irina',NULL,'Khanin',NULL,'dem'),(10181,'Richard',NULL,'Hayden',NULL,'rep'),(10191,'Michael',NULL,'Clinkscale','http://www.clinkscaleforva.com','rep'),(10201,'Kevin',NULL,'Wade',NULL,'dem'),(10211,'Juanita',NULL,'Matkins',NULL,'dem'),(10221,'Lindsey',NULL,'Dougherty','https://www.lindseydougherty.com','dem'),(10231,'Tavoris',NULL,'Marks','http://marksfordelegate.com','dem'),(10241,'Lori',NULL,'Losi','https://losifordelegate.com','rep'),(10251,'Rodney',NULL,'Willet',NULL,'dem'),(10261,'Gayle',NULL,'Johnson',NULL,'dem'),(10271,'Carolyn',NULL,'Weems',NULL,'rep'),(10281,'Danielle',NULL,'Gibeson',NULL,'rep'),(10291,'Qasim',NULL,'Rashid',NULL,'dem'),(10301,'Suzanne',NULL,'Fox','https://suzanneforsenate.com/','rep'),(10311,'Karen',NULL,'Torrent',NULL,'dem'),(10321,'Kelly',NULL,'McGinn',NULL,'rep'),(10331,'Matthew',NULL,'Kelly','https://www.mk4va.com','rep'),(10341,'Flo',NULL,'Ketner','https://floketner.com','dem'),(10351,'Anne',NULL,'Ridgeway',NULL,'dem'),(10361,'Gary',NULL,'Pan',NULL,'rep'),(10371,'Nicholas',NULL,'Bell',NULL,'rep'),(10381,'Kathleen',NULL,'Galvin',NULL,'dem'),(10391,'Martha',NULL,'Mugler',NULL,'dem'),(10401,'Amanda',NULL,'Batten',NULL,'rep'),(10411,'Stan',NULL,'Scott',NULL,'dem'),(10421,'Dakota',NULL,'Claytor',NULL,'dem'),(10431,'Michael',NULL,'Osborne',NULL,'rep'),(10441,'Wendell',NULL,'Walker',NULL,'rep'),(10451,'Alex',NULL,'Askew',NULL,'dem'),(10461,'Johanna',NULL,'Gusman',NULL,'dem'),(10471,'Kecia',NULL,'Evans',NULL,'dem'),(10481,'Raymond',NULL,'Sizemore',NULL,'rep'),(10491,'Melanie',NULL,'Beale',NULL,'rep'),(10501,'Dustin',NULL,'Evans',NULL,'lib'),(10511,'Forrest',NULL,'Hite',NULL,'rep'),(10521,'Joe',NULL,'Morrissey',NULL,'dem'),(10531,'Jen',NULL,'Kiggans',NULL,'rep'),(10541,'David',NULL,'Blanchard','https://blanchardfordelegate.com','dem'),(10551,'Ronald',NULL,'Berman',NULL,'rep'),(10561,'Edgar',NULL,'Perrow',NULL,'rep'),(10571,'Rachel',NULL,'Mace',NULL,'lib'),(10581,'Clinton',NULL,'Jenkins',NULL,'dem'),(10591,'David',NULL,'Zilles',NULL,'dem'),(10611,'Ryan',NULL,'Benton',NULL,'dem'),(10621,'Cardell',NULL,'Padillo Jr',NULL,'dem'),(10631,'Starla',NULL,'Kiser',NULL,'dem'),(10641,'Janice',NULL,'Allen',NULL,'ind'),(10651,'Kevin',NULL,'Washington',NULL,'dem'),(10661,'Don',NULL,'Scott',NULL,'dem'),(10671,'Michael',NULL,'Bartley','https://votebartley.wordpress.com','lib'),(10681,'Pete',NULL,'Wells','https://petewellsforliberty.org','lib');
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election_candidates`
--

DROP TABLE IF EXISTS `election_candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_candidates` (
  `election_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  PRIMARY KEY (`election_id`,`candidate_id`),
  KEY `fk_elections_has_candidates_candidates1_idx` (`candidate_id`),
  KEY `fk_elections_has_candidates_elections_idx` (`election_id`),
  CONSTRAINT `fk_elections_has_candidates_candidates1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_elections_has_candidates_elections` FOREIGN KEY (`election_id`) REFERENCES `elections` (`election_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_candidates`
--

LOCK TABLES `election_candidates` WRITE;
/*!40000 ALTER TABLE `election_candidates` DISABLE KEYS */;
INSERT INTO `election_candidates` VALUES (981,1),(1531,1),(741,11),(1531,21),(1571,31),(1571,41),(1581,51),(1561,61),(1561,71),(261,81),(671,91),(1611,101),(1611,111),(1621,121),(1621,131),(371,141),(1641,161),(1641,171),(1651,181),(1651,191),(521,201),(1671,211),(1671,221),(1681,231),(1691,251),(1691,261),(1691,271),(1041,291),(1711,301),(1711,311),(1711,321),(1721,331),(1721,341),(1731,351),(1731,361),(1741,371),(1251,391),(1761,421),(1761,431),(1771,441),(1771,451),(1131,461),(1141,471),(1151,481),(1151,491),(1161,501),(1171,511),(1171,521),(1201,541),(1201,551),(1211,561),(1221,571),(1871,581),(1231,591),(1241,601),(1781,611),(1781,621),(1261,631),(2161,641),(1901,651),(1301,661),(1311,671),(1321,681),(1331,691),(1341,701),(1351,711),(1361,721),(2211,731),(1371,741),(1381,751),(1381,761),(1391,771),(1391,781),(1401,791),(1411,801),(1421,811),(1441,821),(2021,831),(2021,841),(1461,851),(1481,861),(1491,871),(1501,881),(1511,891),(1081,921),(131,931),(151,941),(1521,951),(2321,961),(181,971),(191,981),(201,991),(211,1001),(261,1011),(271,1021),(281,1031),(291,1041),(301,1051),(311,1061),(331,1091),(341,1101),(361,1121),(381,1141),(391,1151),(411,1181),(421,1191),(431,1201),(451,1211),(521,1221),(621,1231),(661,1241),(671,1251),(681,1261),(701,1271),(711,1281),(721,1291),(731,1301),(761,1311),(771,1321),(781,1331),(2661,1341),(851,1351),(881,1361),(901,1371),(931,1381),(941,1391),(951,1401),(961,1411),(971,1421),(991,1431),(1001,1441),(1061,1461),(1101,1481),(1111,1491),(1121,1501),(141,1511),(191,1521),(221,1531),(231,1541),(241,1551),(251,1561),(331,1571),(341,1581),(391,1591),(401,1601),(431,1611),(441,1621),(451,1631),(461,1641),(471,1651),(481,1661),(491,1671),(3001,1681),(3001,1691),(511,1701),(531,1711),(541,1721),(551,1731),(561,1741),(571,1751),(581,1761),(591,1771),(601,1781),(3101,1791),(631,1801),(3121,1811),(651,1821),(701,1831),(711,1841),(731,1851),(751,1871),(791,1881),(801,1891),(811,1901),(821,1911),(831,1921),(841,1931),(1741,1941),(861,1951),(871,1961),(891,1971),(911,1981),(951,2001),(961,2011),(3461,2021),(3331,2031),(1011,2041),(1021,2051),(3361,2061),(1051,2071),(1061,2081),(1071,2091),(1111,2101),(1531,2111),(821,2121),(321,2131),(1121,2141),(221,2151),(1871,2161),(1581,2171),(1781,2181),(3101,2191),(3461,2201),(2211,2211),(631,2221),(271,10011),(1521,10021),(2471,10031),(3491,10041),(3491,10051),(2471,10071),(2471,10081),(3461,10091),(1731,10101),(2161,10111),(3541,10121),(141,10131),(361,10141),(541,10151),(841,10161),(411,10171),(561,10181),(571,10191),(3121,10201),(681,10211),(3171,10221),(3171,10231),(2661,10241),(851,10251),(941,10261),(2101,10271),(3541,10291),(1451,10301),(1771,10311),(251,10321),(1311,10341),(421,10351),(461,10361),(511,10371),(1681,10381),(3361,10391),(2791,10401),(1161,10411),(1341,10421),(2321,10431),(2451,10441),(971,10451),(1691,10461),(3331,10471),(1031,10481),(2791,10491),(311,10501),(241,10511),(1901,10521),(2101,10531),(2451,10551),(2451,10561),(531,10571),(881,10581),(351,10591),(3701,10611),(3701,10621),(161,10631),(371,10641),(1091,10651),(921,10661),(1061,10671),(831,10681);
/*!40000 ALTER TABLE `election_candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election_results`
--

DROP TABLE IF EXISTS `election_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_results` (
  `election_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `num_votes` int(11) DEFAULT NULL,
  `winner` int(11) DEFAULT NULL,
  PRIMARY KEY (`election_id`,`candidate_id`),
  KEY `fk_election_results_elections1_idx` (`election_id`),
  KEY `fk_election_results_candidates1_idx` (`candidate_id`),
  CONSTRAINT `fk_election_results_candidates1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_election_results_elections1` FOREIGN KEY (`election_id`) REFERENCES `elections` (`election_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_results`
--

LOCK TABLES `election_results` WRITE;
/*!40000 ALTER TABLE `election_results` DISABLE KEYS */;
INSERT INTO `election_results` VALUES (1531,1,3739,1),(1531,21,2162,0),(1531,2111,370,0),(1531,9999,13,0),(2471,10031,1299,1),(2471,10071,744,0),(2471,10081,1041,0);
/*!40000 ALTER TABLE `election_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elections`
--

DROP TABLE IF EXISTS `elections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elections` (
  `election_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` varchar(45) NOT NULL,
  `district` int(11) DEFAULT NULL,
  `office_id` varchar(15) NOT NULL,
  `party_id` char(3) DEFAULT NULL,
  `primary_for` int(11) DEFAULT NULL,
  PRIMARY KEY (`election_id`),
  UNIQUE KEY `election_id_UNIQUE` (`election_id`),
  KEY `fk_elections_offices1_idx` (`office_id`),
  KEY `party_id` (`party_id`),
  KEY `primary_for` (`primary_for`),
  CONSTRAINT `elections_ibfk_1` FOREIGN KEY (`party_id`) REFERENCES `parties` (`party_id`),
  CONSTRAINT `elections_ibfk_2` FOREIGN KEY (`primary_for`) REFERENCES `elections` (`election_id`),
  CONSTRAINT `fk_elections_offices1` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3711 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elections`
--

LOCK TABLES `elections` WRITE;
/*!40000 ALTER TABLE `elections` DISABLE KEYS */;
INSERT INTO `elections` VALUES (1,'2020-11-03','general',NULL,'president',NULL,NULL),(11,'2020-11-03','general',NULL,'ussenate',NULL,NULL),(21,'2020-11-03','general',1,'ushouse',NULL,NULL),(31,'2020-11-03','general',2,'ushouse',NULL,NULL),(41,'2020-11-03','general',3,'ushouse',NULL,NULL),(51,'2020-11-03','general',4,'ushouse',NULL,NULL),(61,'2020-11-03','general',5,'ushouse',NULL,NULL),(71,'2020-11-03','general',6,'ushouse',NULL,NULL),(81,'2020-11-03','general',7,'ushouse',NULL,NULL),(91,'2020-11-03','general',8,'ushouse',NULL,NULL),(101,'2020-11-03','general',9,'ushouse',NULL,NULL),(111,'2020-11-03','general',10,'ushouse',NULL,NULL),(121,'2020-11-03','general',11,'ushouse',NULL,NULL),(131,'2019-11-05','general',1,'vahouse',NULL,NULL),(141,'2019-11-05','general',2,'vahouse',NULL,NULL),(151,'2019-11-05','general',3,'vahouse',NULL,NULL),(161,'2019-11-05','general',4,'vahouse',NULL,NULL),(171,'2019-11-05','general',5,'vahouse',NULL,NULL),(181,'2019-11-05','general',6,'vahouse',NULL,NULL),(191,'2019-11-05','general',7,'vahouse',NULL,NULL),(201,'2019-11-05','general',8,'vahouse',NULL,NULL),(211,'2019-11-05','general',9,'vahouse',NULL,NULL),(221,'2019-11-05','general',10,'vahouse',NULL,NULL),(231,'2019-11-05','general',11,'vahouse',NULL,NULL),(241,'2019-11-05','general',12,'vahouse',NULL,NULL),(251,'2019-11-05','general',13,'vahouse',NULL,NULL),(261,'2019-11-05','general',14,'vahouse',NULL,NULL),(271,'2019-11-05','general',15,'vahouse',NULL,NULL),(281,'2019-11-05','general',16,'vahouse',NULL,NULL),(291,'2019-11-05','general',17,'vahouse',NULL,NULL),(301,'2019-11-05','general',18,'vahouse',NULL,NULL),(311,'2019-11-05','general',19,'vahouse',NULL,NULL),(321,'2019-11-05','general',20,'vahouse',NULL,NULL),(331,'2019-11-05','general',21,'vahouse',NULL,NULL),(341,'2019-11-05','general',22,'vahouse',NULL,NULL),(351,'2019-11-05','general',23,'vahouse',NULL,NULL),(361,'2019-11-05','general',24,'vahouse',NULL,NULL),(371,'2019-11-05','general',25,'vahouse',NULL,NULL),(381,'2019-11-05','general',26,'vahouse',NULL,NULL),(391,'2019-11-05','general',27,'vahouse',NULL,NULL),(401,'2019-11-05','general',28,'vahouse',NULL,NULL),(411,'2019-11-05','general',29,'vahouse',NULL,NULL),(421,'2019-11-05','general',30,'vahouse',NULL,NULL),(431,'2019-11-05','general',31,'vahouse',NULL,NULL),(441,'2019-11-05','general',32,'vahouse',NULL,NULL),(451,'2019-11-05','general',33,'vahouse',NULL,NULL),(461,'2019-11-05','general',34,'vahouse',NULL,NULL),(471,'2019-11-05','general',35,'vahouse',NULL,NULL),(481,'2019-11-05','general',36,'vahouse',NULL,NULL),(491,'2019-11-05','general',37,'vahouse',NULL,NULL),(501,'2019-11-05','general',38,'vahouse',NULL,NULL),(511,'2019-11-05','general',39,'vahouse',NULL,NULL),(521,'2019-11-05','general',40,'vahouse',NULL,NULL),(531,'2019-11-05','general',41,'vahouse',NULL,NULL),(541,'2019-11-05','general',42,'vahouse',NULL,NULL),(551,'2019-11-05','general',43,'vahouse',NULL,NULL),(561,'2019-11-05','general',44,'vahouse',NULL,NULL),(571,'2019-11-05','general',45,'vahouse',NULL,NULL),(581,'2019-11-05','general',46,'vahouse',NULL,NULL),(591,'2019-11-05','general',47,'vahouse',NULL,NULL),(601,'2019-11-05','general',48,'vahouse',NULL,NULL),(611,'2019-11-05','general',49,'vahouse',NULL,NULL),(621,'2019-11-05','general',50,'vahouse',NULL,NULL),(631,'2019-11-05','general',51,'vahouse',NULL,NULL),(641,'2019-11-05','general',52,'vahouse',NULL,NULL),(651,'2019-11-05','general',53,'vahouse',NULL,NULL),(661,'2019-11-05','general',54,'vahouse',NULL,NULL),(671,'2019-11-05','general',55,'vahouse',NULL,NULL),(681,'2019-11-05','general',56,'vahouse',NULL,NULL),(691,'2019-11-05','general',57,'vahouse',NULL,NULL),(701,'2019-11-05','general',58,'vahouse',NULL,NULL),(711,'2019-11-05','general',59,'vahouse',NULL,NULL),(721,'2019-11-05','general',60,'vahouse',NULL,NULL),(731,'2019-11-05','general',61,'vahouse',NULL,NULL),(741,'2019-11-05','general',62,'vahouse',NULL,NULL),(751,'2019-11-05','general',63,'vahouse',NULL,NULL),(761,'2019-11-05','general',64,'vahouse',NULL,NULL),(771,'2019-11-05','general',65,'vahouse',NULL,NULL),(781,'2019-11-05','general',66,'vahouse',NULL,NULL),(791,'2019-11-05','general',67,'vahouse',NULL,NULL),(801,'2019-11-05','general',68,'vahouse',NULL,NULL),(811,'2019-11-05','general',69,'vahouse',NULL,NULL),(821,'2019-11-05','general',70,'vahouse',NULL,NULL),(831,'2019-11-05','general',71,'vahouse',NULL,NULL),(841,'2019-11-05','general',72,'vahouse',NULL,NULL),(851,'2019-11-05','general',73,'vahouse',NULL,NULL),(861,'2019-11-05','general',74,'vahouse',NULL,NULL),(871,'2019-11-05','general',75,'vahouse',NULL,NULL),(881,'2019-11-05','general',76,'vahouse',NULL,NULL),(891,'2019-11-05','general',77,'vahouse',NULL,NULL),(901,'2019-11-05','general',78,'vahouse',NULL,NULL),(911,'2019-11-05','general',79,'vahouse',NULL,NULL),(921,'2019-11-05','general',80,'vahouse',NULL,NULL),(931,'2019-11-05','general',81,'vahouse',NULL,NULL),(941,'2019-11-05','general',82,'vahouse',NULL,NULL),(951,'2019-11-05','general',83,'vahouse',NULL,NULL),(961,'2019-11-05','general',84,'vahouse',NULL,NULL),(971,'2019-11-05','general',85,'vahouse',NULL,NULL),(981,'2019-11-05','general',86,'vahouse',NULL,NULL),(991,'2019-11-05','general',87,'vahouse',NULL,NULL),(1001,'2019-11-05','general',88,'vahouse',NULL,NULL),(1011,'2019-11-05','general',89,'vahouse',NULL,NULL),(1021,'2019-11-05','general',90,'vahouse',NULL,NULL),(1031,'2019-11-05','general',91,'vahouse',NULL,NULL),(1041,'2019-11-05','general',92,'vahouse',NULL,NULL),(1051,'2019-11-05','general',93,'vahouse',NULL,NULL),(1061,'2019-11-05','general',94,'vahouse',NULL,NULL),(1071,'2019-11-05','general',95,'vahouse',NULL,NULL),(1081,'2019-11-05','general',96,'vahouse',NULL,NULL),(1091,'2019-11-05','general',97,'vahouse',NULL,NULL),(1101,'2019-11-05','general',98,'vahouse',NULL,NULL),(1111,'2019-11-05','general',99,'vahouse',NULL,NULL),(1121,'2019-11-05','general',100,'vahouse',NULL,NULL),(1131,'2019-11-05','general',1,'vasenate',NULL,NULL),(1141,'2019-11-05','general',2,'vasenate',NULL,NULL),(1151,'2019-11-05','general',3,'vasenate',NULL,NULL),(1161,'2019-11-05','general',4,'vasenate',NULL,NULL),(1171,'2019-11-05','general',5,'vasenate',NULL,NULL),(1181,'2019-11-05','general',6,'vasenate',NULL,NULL),(1191,'2019-11-05','general',7,'vasenate',NULL,NULL),(1201,'2019-11-05','general',8,'vasenate',NULL,NULL),(1211,'2019-11-05','general',9,'vasenate',NULL,NULL),(1221,'2019-11-05','general',10,'vasenate',NULL,NULL),(1231,'2019-11-05','general',11,'vasenate',NULL,NULL),(1241,'2019-11-05','general',12,'vasenate',NULL,NULL),(1251,'2019-11-05','general',13,'vasenate',NULL,NULL),(1261,'2019-11-05','general',14,'vasenate',NULL,NULL),(1271,'2019-11-05','general',15,'vasenate',NULL,NULL),(1281,'2019-11-05','general',16,'vasenate',NULL,NULL),(1291,'2019-11-05','general',17,'vasenate',NULL,NULL),(1301,'2019-11-05','general',18,'vasenate',NULL,NULL),(1311,'2019-11-05','general',19,'vasenate',NULL,NULL),(1321,'2019-11-05','general',20,'vasenate',NULL,NULL),(1331,'2019-11-05','general',21,'vasenate',NULL,NULL),(1341,'2019-11-05','general',22,'vasenate',NULL,NULL),(1351,'2019-11-05','general',23,'vasenate',NULL,NULL),(1361,'2019-11-05','general',24,'vasenate',NULL,NULL),(1371,'2019-11-05','general',25,'vasenate',NULL,NULL),(1381,'2019-11-05','general',26,'vasenate',NULL,NULL),(1391,'2019-11-05','general',27,'vasenate',NULL,NULL),(1401,'2019-11-05','general',28,'vasenate',NULL,NULL),(1411,'2019-11-05','general',29,'vasenate',NULL,NULL),(1421,'2019-11-05','general',30,'vasenate',NULL,NULL),(1431,'2019-11-05','general',31,'vasenate',NULL,NULL),(1441,'2019-11-05','general',32,'vasenate',NULL,NULL),(1451,'2019-11-05','general',33,'vasenate',NULL,NULL),(1461,'2019-11-05','general',34,'vasenate',NULL,NULL),(1471,'2019-11-05','general',35,'vasenate',NULL,NULL),(1481,'2019-11-05','general',36,'vasenate',NULL,NULL),(1491,'2019-11-05','general',37,'vasenate',NULL,NULL),(1501,'2019-11-05','general',38,'vasenate',NULL,NULL),(1511,'2019-11-05','general',39,'vasenate',NULL,NULL),(1521,'2019-11-05','general',40,'vasenate',NULL,NULL),(1531,'2019-02-19','special',86,'vahouse',NULL,NULL),(1561,'2019-06-11','primary',17,'vasenate','rep',1291),(1571,'2019-05-03','primary',97,'vahouse','rep',1091),(1581,'2019-06-11','primary',17,'vasenate','dem',1291),(1611,'2019-06-11','primary',18,'vahouse','dem',301),(1621,'2019-06-11','primary',20,'vahouse','rep',321),(1641,'2019-06-11','primary',26,'vahouse','dem',381),(1651,'2019-06-11','primary',28,'vahouse','rep',401),(1671,'2019-06-11','primary',49,'vahouse','dem',611),(1681,'2019-06-11','primary',57,'vahouse','dem',691),(1691,'2019-06-11','primary',87,'vahouse','dem',991),(1711,'2019-06-11','primary',96,'vahouse','dem',1081),(1721,'2019-06-11','primary',6,'vasenate','dem',1181),(1731,'2019-06-11','primary',10,'vasenate','dem',1221),(1741,'2019-06-11','primary',12,'vasenate','dem',1241),(1761,'2019-06-11','primary',31,'vasenate','dem',1431),(1771,'2019-06-11','primary',35,'vasenate','dem',1471),(1781,'2019-06-11','primary',13,'vasenate','rep',1251),(1871,'2019-06-11','primary',11,'vasenate','dem',1231),(1901,'2019-06-11','primary',16,'vasenate','dem',1281),(2021,'2019-06-11','primary',33,'vasenate','dem',1451),(2101,'2019-06-11','primary',7,'vasenate','rep',1191),(2161,'2019-06-11','primary',15,'vasenate','rep',1271),(2211,'2019-06-11','primary',24,'vasenate','rep',1361),(2321,'2019-06-11','primary',5,'vahouse','rep',171),(2451,'2019-06-11','primary',23,'vahouse','rep',351),(2471,'2019-04-27','primary',25,'vahouse','rep',371),(2661,'2019-06-11','primary',68,'vahouse','rep',801),(2791,'2019-06-11','primary',96,'vahouse','rep',1081),(3001,'2019-06-11','primary',38,'vahouse','dem',501),(3101,'2019-06-11','primary',50,'vahouse','dem',621),(3121,'2019-06-11','primary',52,'vahouse','dem',641),(3171,'2019-06-11','primary',62,'vahouse','dem',741),(3331,'2019-06-11','primary',88,'vahouse','dem',1001),(3361,'2019-06-11','primary',91,'vahouse','dem',1031),(3461,'2019-06-11','primary',7,'vasenate','dem',1191),(3491,'2019-06-11','primary',4,'vahouse','rep',161),(3541,'2019-06-11','primary',28,'vasenate','dem',1401),(3701,'2019-06-01','primary',80,'vahouse','dem',921);
/*!40000 ALTER TABLE `elections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offices` (
  `office_id` varchar(15) NOT NULL,
  PRIMARY KEY (`office_id`),
  UNIQUE KEY `office_id_UNIQUE` (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES ('governor'),('ltgovernor'),('president'),('ushouse'),('ussenate'),('vahouse'),('vasenate');
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parties`
--

DROP TABLE IF EXISTS `parties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parties` (
  `party_id` varchar(50) NOT NULL,
  `party_name` varchar(45) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  UNIQUE KEY `party_id_UNIQUE` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parties`
--

LOCK TABLES `parties` WRITE;
/*!40000 ALTER TABLE `parties` DISABLE KEYS */;
INSERT INTO `parties` VALUES ('dem','Democratic',NULL),('grn','Green',NULL),('ind','Independent',NULL),('lib','Libertarian',NULL),('rep','Republican',NULL),('wi','Write In',NULL);
/*!40000 ALTER TABLE `parties` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-09 16:36:36
