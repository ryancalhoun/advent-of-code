#!/usr/bin/env python3
import psycopg2
import os

conn = psycopg2.connect('')
cur = conn.cursor()

start = 1
batch = 100000
match = os.environ.get('PART') == '1' and '00000%' or '000000%'
seed = input()

while True:

  cur.execute(
    "SELECT s FROM generate_series(%s,%s) AS s WHERE md5(%s || s) LIKE %s LIMIT 1",
    (start, start+batch, seed, match)
  )
  r = cur.fetchone()

  if r:
    print(r[0])
    break

  start += batch

