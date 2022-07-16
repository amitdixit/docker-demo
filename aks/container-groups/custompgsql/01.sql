CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP 
);

insert into accounts (username, password, email, created_on,last_login)
select
    left(md5(i::text), 10),
    md5(random()::text),
    concat(array_to_string(ARRAY(SELECT chr((97 + round(random() * i)) :: integer) FROM generate_series(1,15)), ''),'@myorg.com'),
    now(),now()
from generate_series(1, 10000) s(i)