#!/bin/bash

mkdir -p /etc/app

cat <<EOF > /etc/app/app.cnf
environment=${env}
db_endpoint=${db_endpoint}
EOF