# Virginia Elections API

This API returns data on federal, statewide, and General Assembly elections and candidate in the Commonwealth of Virginia. The API is available from api.virginiaelects.com (the root path redirects to this GitHub repo).


## The Data

The database has been hand-curated by me, using publicly available information from a variety of news sources. However, my primary source of information is the outstanding [Virginia Public Access Project](https://www.vpap.org/) which, apart from being a phenomenal source of information, is a huge inspiration as an organization.

Addresses are match to districts using the [Google Civic Information API](https://developers.google.com/civic-information/). District numbers are parsed from the key names from the "divisions" array.


## Routes & Returned Data

The following are all available API routes and the format of data returned. All routes listed are relative to the root api.virginiaelects.com route. All returned data is JSON.

Routes are divided into three primary categories: elections, candidates, and districts.

*NOTE ON GENERAL ASSEMBLY CANDIDATES*: All non-independent andidates are first associated with a primary election even if they are currently running unopposed; this is a data management issue as I would have to regularly remove candidates from the relationship to a general election each time a race became contested. Additionally, due to the myriad of dates on which conventions take place for committees that opt to nominate candidates by that method, all nomination contests will be classified as primaries with a date corresponding to the statewide primary date. Once a candidate has secured the nomination or the filing deadline for that election has passed, the nominee will be associated with the general election (all independent candidates are immediately associated with the general election).


### /elections

Elections have the following keys:
- electionID: A unique identifier used primarily for relational purposes
- date: Date in YYY-MM-DD format
- type: General, special, or primary. Only special general elections are labeled as special. All primaries, regardless of being linked to a general or special election, are classified as a primary.
- party: For primaries only, a party name will be included.
- office: Office IDs are as follows: president, ushouse, ussenate, vahouse, vasenate
- district: Numerical district for congressional and General Assembly elections; statewide and presidential elections have a null district value, and will not return this key
- candidates: An array of candidates running in that election; not returned on all routes


**/elections**

The root route of the /elections path returns all election data (currently limited to elections within the current calender year), ordered by office then by district.
*Example data:*
```
[
    {
        "electionID": 1,
        "date": "2020-11-03T00:00:00.000Z",
        "type": "general",
        "office": "president"
    },
    {
        "electionID": 21,
        "date": "2020-11-03T00:00:00.000Z",
        "type": "general",
        "office": "ushouse",
        "district": 1
    },
    {
        "electionID": 2291,
        "date": "2019-06-11T04:00:00.000Z",
        "type": "primary",
        "party": "Republican",
        "office": "vahouse",
        "district": 1
    }
]
```

**/elections/address/:address**

Takes an address as a parameter which is passed to the Google Civic Information API to determine associated districts. The district information is parsed from the Civic Info API results and used to search the Virginia Elections API's associated database for elections within those districts. 

Election objects are returned along with an array of candidates running in that election. General election data is returned even when no candidates are associated.

*Example data*
```
[
    {
        "electionID": 441,
        "date": "2019-11-05T05:00:00.000Z",
        "type": "general",
        "office": "vahouse",
        "district": 32
    },
    {
        "electionID": 2941,
        "date": "2019-06-11T04:00:00.000Z",
        "type": "primary",
        "party": "Democratic",
        "office": "vahouse",
        "district": 32,
        "candidates": [
            {
                "firstName": "David",
                "lastName": "Reid",
                "party": "Democratic",
                "website": "https://www.delegatedavidreid.com/"
            }
        ]
    }
]
```

**/elections/office/:office**

Takes an office identifier as a parameter and returns all elections for that office ordered by district.


**/elections/office/:office/district/:district**

Takes in an office identifier and a numerical district as parameters and returns all elections for that office and ditrict combo sorted by district.


**/elections/candidates**

Returns all elections for all offices for the current calendar year along with an array of candidate objects ("candidates" key) for each election. Results are sorted by district. Differs from the /elections root route by inclusion of the candidate array.


### /candidates

Candidates have the following keys:
- candidateID: Unique identifier, generally not returned.
- firstName
- middleName
- lastName
- party
- website
- elections: Array of election objects in which the candidate appears. Not returned in every route. The election object omits the party key, as it is redundant in this instance.


**/candidates/elections**

Returns all candidates in the database along with an array of elections ("elections" key) in which the candidate appears. Results are ordered alphabetically by the candidate's last name.

*Example data*
```
[
    {
        "candidateID": 1031,
        "firstName": "Les",
        "lastName": "Adams",
        "party": "Republican",
        "election": {
            "electionID": 2391,
            "date": "2019-06-11T04:00:00.000Z",
            "type": "primary",
            "office": "vahouse",
            "district": 16
        }
    },
    {
        "candidateID": 1891,
        "firstName": "Dawn",
        "lastName": "Adams",
        "party": "Democratic",
        "election": {
            "electionID": 3201,
            "date": "2019-06-11T04:00:00.000Z",
            "type": "primary",
            "office": "vahouse",
            "district": 68
        }
    }
]
```

**/candidates/address/:address**

Takes in an address parameter which is passed to Google's Civic Information API to determine associated districts. District info is then parsed and the Virginia Elections API's associated database is searched for candidates running in those districts. Results are ordered alphabetically by the candidate's last name.

*Example data*
```
[
    {
        "candidateID": 1861,
        "firstName": "Sheila",
        "lastName": "Bynum-Coleman",
        "party": "Democratic",
        "election": {
            "electionID": 3171,
            "date": "2019-06-11T04:00:00.000Z",
            "type": "primary",
            "office": "vahouse",
            "district": 62
        }
    },
    {
        "candidateID": 11,
        "firstName": "Carrie",
        "lastName": "Coyner",
        "party": "Republican",
        "election": {
            "electionID": 1551,
            "date": "2019-06-11T04:00:00.000Z",
            "type": "primary",
            "office": "vahouse",
            "district": 62
        }
    }
]
```

**/candidates/office/:office**

Takes in an office identifier parameter and returns all candidates running in elections for that office. Results are ordered by district number.


**/candidates/office/:office/district/:district**

Takes in an office identifier and a district number and returns all candidates running in elections for that office and district. Results are ordered by district number.


### /districts

District objects have the following keys:
- cd: Congressional district
- house: Virginia House of Delegates district
- senate: Virginia Senate district
- Open Civic Identifiers: an array of Open Civic Data Identifiers for country, state, congressional district, Virginia Senate, and Virginia House districts ([click here](https://opencivicdata.readthedocs.io/en/latest/ocdids.html) to read more on OCD IDs)


## The Future

**More Data**

Because I am only one person and there are 100 General Assembly districts, each with at least one general election candidate and many with multiple nomination contests, I have only included the most elementary information about each election and candidate. For federal and statewide elections, I plan to include a greater breadth of information, including social media profiles links for each candidate, among other things.

**Web App**

This is a more distant project, but I do intend to utilize this API to roll a web application that will allow individuals to create user accounts that can be used to persist information and better track elections. This would allow individuals to receive notifications when a new candidate enters a race. Ideally this could be completed in time for the 2020 primaries.