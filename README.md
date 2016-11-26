# Social Network Scroller App

The app offers infinite-scrolling using the will-paginate gem and some javascript. It contains one controller, one model app is designed to be a hybrid: if requested, it returns a JSON like an API. It also has a view which can be accessed via rails server with the index path.

## Running the app on your browser

1. Clone to local reports
2. Run 'bundle install'
3. Run 'Rails Server'

## Run the tests
Run 'rspec' on the terminal

## Database Optimisation

The following tables are meant to show the improvements made to the database performance, as scalability is meant to be a key component of this app's functionality.

## Without Pagination

QUERY PLAN
------------------------------------------------------------------------------------------------------
Seq Scan on profiles  (cost=0.00..2.55 rows=55 width=139) (actual time=0.724..0.977 rows=55 loops=1)
Planning time: 175.320 ms
Execution time: 39.898 ms
(3 rows)

Thoughts: As there was only one model, and one table, there were no complex relations to slow the query down.

## With pagination

QUERY PLAN
--------------------------------------------------------------------------------------------------------
Limit  (cost=4.04..4.06 rows=10 width=139) (actual time=0.083..0.088 rows=10 loops=1)
->  Sort  (cost=4.01..4.15 rows=55 width=139) (actual time=0.078..0.081 rows=20 loops=1)
Sort Key: id DESC
Sort Method: top-N heapsort  Memory: 30kB
->  Seq Scan on profiles  (cost=0.00..2.55 rows=55 width=139) (actual time=0.008..0.024 rows=55 loops=1)
Planning time: 0.200 ms
Execution time: 0.140 ms
(7 rows)

Thoughts: Pagination set up the query faster than without pagination and since it is only querying a limited amount of records at a time, it's naturally faster. Using sort on the table's id column adds some time. It also adds memory usage which consistent in other tests.

# With Active Model Serializer

QUERY PLAN
--------------------------------------------------------------------------------------------------------
Limit  (cost=4.04..4.06 rows=10 width=139) (actual time=8.256..8.261 rows=10 loops=1)
->  Sort  (cost=4.01..4.15 rows=55 width=139) (actual time=8.252..8.255 rows=20 loops=1)
Sort Key: id DESC
Sort Method: top-N heapsort  Memory: 30kB
->  Seq Scan on profiles  (cost=0.00..2.55 rows=55 width=139) (actual time=7.679..8.088 rows=55 loops=1)
Planning time: 42.842 ms
Execution time: 8.380 ms
(7 rows)

Thoughts: I know that serializing can help speed up requests and while I figured that it would only work to solve cases where foreign keys were involved. The only thing I wondered was whether the serializer's ability to provide only the necessary columns would speed up the performance. The hypothesis was correct and this query took much longer to conduct.

# After Removing Active Model Serializer

QUERY PLAN
--------------------------------------------------------------------------------------------------------
Limit  (cost=4.04..4.06 rows=10 width=139) (actual time=0.102..0.106 rows=10 loops=1)
->  Sort  (cost=4.01..4.15 rows=55 width=139) (actual time=0.098..0.102 rows=20 loops=1)
Sort Key: id DESC
Sort Method: top-N heapsort  Memory: 30kB
->  Seq Scan on profiles  (cost=0.00..2.55 rows=55 width=139) (actual time=0.019..0.032 rows=55 loops=1)
Planning time: 0.517 ms
Execution time: 0.169 ms
(7 rows)

Thoughts: Things got much faster again.

## Database Schema

Table "public.profiles"
   Column    |            Type             |                       Modifiers
-------------+-----------------------------+-------------------------------------------------------
 id          | integer                     | not null default nextval('profiles_id_seq'::regclass)
 name        | character varying           |
 geolocation | character varying           |
 photo       | character varying           |
 created_at  | timestamp without time zone | not null
 updated_at  | timestamp without time zone | not null
Indexes: "profiles_pkey" PRIMARY KEY, btree (id)

Thoughts: This is the only table in the database, called "profiles. "It's nice that PostgreSQL automatically creates an index for primary keys, which improves performance.
