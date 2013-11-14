BEGIN TRANSACTION;

/* To run: psql acris < schema.sql */

/*
 * There's bad data in the CSV.  Do
 *
 * sed -i tmp s:02/29/0200:02/28/0200: ACRIS_-_Real_Property_Master.csv
 *
 * To clean it.
 */
CREATE TABLE "ACRIS_-_Real_Property_Master" (
	"Document ID"	TEXT PRIMARY KEY,
	"Record_type"	TEXT,
	"CRFN"	BIGINT,
	"Recorded_borough"	SMALLINT,
	"Doc_type"	TEXT,
	"Document Date"	DATE,
	"Document_amt"	REAL,
	"Recorded_datetime"	DATE,
	"Modified date"	DATE,
	"Reel_yr"	INTEGER,
	"Reel_nbr"	INTEGER,
	"Reel_pg"	INTEGER,
	"Percent_trans"	REAL,
	"Good_through date"	TEXT
);

/**
 * Then load data:
 *
 * COPY "ACRIS_-_Real_Property_Master" FROM '/Users/talos/Programming/acris/ACRIS_-_Real_Property_Master.csv' WITH CSV HEADER;
 **/

CREATE TABLE "ACRIS_-_Real_Property_References" (
	"Document ID"	TEXT REFERENCES "ACRIS_-_Real_Property_Master" ("Document ID"),
	"Record_type"	TEXT,
	"CRFN"	TEXT,
	--"Doc_id_ref"	TEXT REFERENCES "ACRIS_-_Real_Property_Master" ("Document ID"),
	"Doc_id_ref"	TEXT,
	"Reel_yr"	INTEGER,
	"Reel_borough"	INTEGER,
	"Reel_nbr"	INTEGER,
	"Reel_pg"	INTEGER,
	"Good_through date"	TEXT
);

/**
 * COPY "ACRIS_-_Real_Property_References" FROM '/Users/talos/Programming/acris/ACRIS_-_Real_Property_References.csv' WITH CSV HEADER;
 *
 * There's (surprise) some bad data: the CRFN 'SIMUL REC' for example, as well
 * as the "Doc_id_ref" 'FT_1150008404315', which makes a proper FK impossible.
 **/

CREATE TABLE "ACRIS_-_Real_Property_Parties" (
	"Document ID"	TEXT REFERENCES "ACRIS_-_Real_Property_Master" ("Document ID"),
	"Record_type"	TEXT,
	"Party_type"	SMALLINT,
	"Name"	TEXT,
	"Addr1"	TEXT,
	"Addr2"	TEXT,
	"Country"	TEXT,
	"City"	TEXT,
	"State"	TEXT,
	"Zip"	TEXT,
	"Good_through date"	TEXT
);

/**
 * COPY "ACRIS_-_Real_Property_Parties" FROM '/Users/talos/Programming/acris/ACRIS_-_Real_Property_Parties.csv' WITH CSV HEADER;
 *
 **/

CREATE TABLE "ACRIS_-_Real_Property_Legals" (
	"Document ID"	TEXT REFERENCES "ACRIS_-_Real_Property_Master" ("Document ID"),
	"Record_type"	TEXT,
	"Borough"	SMALLINT,
	"Block"	INTEGER,
	"Lot"	INTEGER,
	"Easement"	TEXT,
	"Partial_lot"	TEXT,
	"Air_rights"	TEXT,
	"Subterranean_rights"	TEXT,
	"Property_type"	TEXT,
	"Street_number"	TEXT,
	"Street_Name"	TEXT,
	"Addr_unit"	TEXT,
	"Good_through	date"	TEXT
);

/**
 * COPY "ACRIS_-_Real_Property_Legals" FROM '/Users/talos/Programming/acris/ACRIS_-_Real_Property_Legals.csv' WITH CSV HEADER;
 *
 * Missing reference key "2013071600491002"
 **/

END TRANSACTION;
