# docker pgcli

A Docker image with pgcli installed on Ubuntu.
Can be used to check Docker container to host PostgreSQL connection.

Usage:

```
dbname=nextcloud
dbuser=nextcloud
dbpass=nextcloud

docker run -it --rm --add-host="host.docker.internal:host-gateway" guoqiao/pgcli postgres://${dbuser}:${dbpass}@host.docker.internal:5432/${dbname}
```

Script to create user and db:

```
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

Some useful postgres commands once you are connected:

```
\?  # show help
\l  # show all dbs
\dt # show all tables
\q  # quit
```
