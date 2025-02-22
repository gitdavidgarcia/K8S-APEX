#!/bin/bash
export DB_PORT
export DB_SERVICE
export HOSTNAME
export SYSDBA_USER
export SYSDBA_PASSWORD

set -e
/liquibase/sqlcl/bin/sql ${SYSDBA_USER}/${SYSDBA_PASSWORD}@${HOSTNAME}:${DB_PORT}/${DB_SERVICE} << EOF
	lb clear-checksums
	lb update -changelog-file=changelog_master.xml
EOF
