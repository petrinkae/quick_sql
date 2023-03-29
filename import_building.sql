drop table if exists building cascade;

CREATE TABLE building (
	objectid TEXT, 
	created_user TEXT, 
	created_date TIMESTAMP, 
	last_edited_user TEXT, 
	last_edited_date TEXT, 
	folioid TEXT, 
	shape TEXT, 
	type TEXT
);

\copy building from 'data/building.csv' csv header;
