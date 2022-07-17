# docker pgcli

A Docker image with pgcli installed on Ubuntu LTS 20.04 (focal).

Available on [Docker Hub](https://hub.docker.com/repository/docker/guoqiao/pgcli).

Can be used to connect to PostgreSQL installed on a host from a Docker container.

Usage Example:

```bash
dbname=nextcloud
dbuser=nextcloud
dbpass=nextcloud

docker run -it --rm --add-host="host.docker.internal:host-gateway" guoqiao/pgcli postgres://${dbuser}:${dbpass}@host.docker.internal:5432/${dbname}
```

Script to create user and db:

```bash
#!/bin/bash

# create db and user for an app with same name, without password

set -xue

app=$1

dbuser=$app
dbname=$app

sudo su --login postgres << EOF

createuser --echo ${dbuser};
createdb   --echo --owner ${dbuser} ${dbname};

EOF
```

Allow Docker containers to connect to PostgreSQL installed on Docker host:

```bash
sudo vim /etc/postgresql/12/main/postgresql.conf
# listen on any address, instead of localhost only
listen_addresses = '*'

sudo vim /etc/postgresql/12/main/pg_hba.conf
# add rule to allow user `foo` from Docker containers connect to db `foo` without checking password
host    sameuser        all             172.16.0.0/12           trust

# restart service with any of these
sudo service postgresql restart
sudo systemctl restart postgresql.service
# on host where service managers are not available, e.g.: synolog nas
sudo su -l postgres -c "pg_ctl reload"
```

Some useful postgres commands once you are connected:

```
\?  # show help
\l  # show all dbs
\dt # show all tables
\q  # quit
```
