all: sample1 sample2 part1 part2 stop-postgres

sample1: start-postgres
	PART=1 ./app.py < sample.txt
sample2: start-postgres
	PART=2 ./app.py < sample.txt
part1: start-postgres
	PART=1 ./app.py < full.txt
part2: start-postgres
	PART=2 time ./app.py < full.txt

start-postgres:
	sudo service postgresql start

stop-postgres:
	sudo service postgresql stop

setup:
	sudo apt-get -y install postgresql libpq-dev
	pip install -r requirements.txt
	sudo service postgresql start
	sudo -u postgres psql -c "DROP ROLE IF EXISTS ${PGUSER}; CREATE ROLE app WITH LOGIN PASSWORD '${PGPASSWORD}';"
	sudo service postgresql stop

.EXPORT_ALL_VARIABLES:
PGHOST=localhost
PGUSER=app
PGPASSWORD=app
PGDATABASE=template1
