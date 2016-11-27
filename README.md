# Social Network Scroller App

The main objective of this app is to test query optimisation  of PostgreSQL database for a rails API. The app offers infinite-scrolling using the will-paginate gem and some javascript. It contains one controller, one model app is designed to be a hybrid: if requested, it returns a JSON like an API. It also has a view which can be accessed via rails server with the index path.


## Running the app on your browser

1. Clone to local reports
2. Run 'bundle install'
3. Run 'Rails Server'

## Run the tests
Run 'rspec' on the terminal

## Database Optimisation

The following tables are meant to show the improvements made to the database performance, as scalability is meant to be a key component of this app's functionality. The database was seeded with 5000 profiles before running EXPLAIN ANALYZE on various possible PostgreSQL queries.

## Without Pagination

Thoughts: As there was only one model, and one table, there were no complex relations to slow the query down. On the other hand, it's providing more profiles than needed and in no order, therefore it could be better.

QUERY PLAN
Seq Scan on profiles  (cost=0.00..158.55 rows=5055 width=138) (actual time=0.059..3.551 rows=5055 loops=1)
Planning time: 53.027 ms
Execution time: 4.234 ms
(3 rows)


## With pagination

Thoughts: Pagination set up the query faster than without pagination and since it is only querying a limited amount of records at a time, it's naturally faster.

QUERY PLAN
Limit  (cost=0.31..0.63 rows=10 width=138) (actual time=0.036..0.041 rows=10 loops=1)
->  Seq Scan on profiles  (cost=0.00..158.55 rows=5055 width=138) (actual time=0.031..0.035 rows=20 loops=1)
Planning time: 0.275 ms
Execution time: 0.079 ms
(4 rows)


## Sorting the profiles

Thoughts: Social media feeds always have some sort of order to them. For this, I figured the most useful ordering system might be the updated_at column. Using sort on this column adds a lot of time. It also adds memory usage.

QUERY PLAN
Limit  (cost=293.09..293.11 rows=10 width=138) (actual time=5.933..5.936 rows=10 loops=1)
->  Sort  (cost=293.06..305.70 rows=5055 width=138) (actual time=5.930..5.932 rows=20 loops=1)
Sort Key: updated_at DESC
Sort Method: top-N heapsort  Memory: 30kB
->  Seq Scan on profiles  (cost=0.00..158.55 rows=5055 width=138) (actual time=0.076..3.826 rows=5055 loops=1)
Planning time: 0.403 ms
Execution time: 6.000 ms
(7 rows)

## Adding an index on the sorted column

Thoughts: In order to set up the index scan, a lot of time is lost up front. Once this is done and the offset increases, there are fewer records to look through which means that the pagination speeds up overall.

QUERY PLAN
Limit  (cost=0.78..1.27 rows=10 width=138) (actual time=0.813..0.824 rows=10 loops=1)
->  Index Scan Backward using index_profiles_on_updated_at on profiles  (cost=0.28..251.12 rows=5055 width=138) (actual time=0.800..0.817 rows=20 loops=1)
Planning time: 20.358 ms
Execution time: 0.980 ms
(4 rows)

QUERY PLAN
Limit  (cost=5.24..5.74 rows=10 width=138) (actual time=0.104..0.128 rows=10 loops=1)
->  Index Scan Backward using index_profiles_on_updated_at on profiles  (cost=0.28..251.12 rows=5055 width=138) (actual time=0.021..0.115 rows=110 loops=1)
Planning time: 0.143 ms
Execution time: 0.207 ms
(4 rows)

## Some General Thoughts

Early on, I had made the decision to use the will_paginate ruby gem. While this made pagination easier, it uses an offset parameter which numerous blogs seems to indicate decreases performance. If I had more time, I would remove the gem and change the query pattern to use a Where clause which


## Database Schema

One table in use: "public.profiles"

```
Table "public.profiles"
Column    |            Type             |                       Modifiers
-------------+-----------------------------+-------------------------------------------------------
id          | integer                     | not null default nextval('profiles_id_seq'::regclass)
name        | character varying           |
geolocation | character varying           |
photo       | character varying           |
created_at  | timestamp without time zone | not null
updated_at  | timestamp without time zone | not null
Indexes:
"profiles_pkey" PRIMARY KEY, btree (id)
"index_profiles_on_updated_at" btree (updated_at)

Thoughts: This is the only table in the database, called "profiles. "It's nice that PostgreSQL automatically creates an index for primary keys, which improves performance.
```
