export ORDS_HOME=/opt/oracle
export ORDS_CONFIG=/opt/oracle/config_ords
export ORDS_LOGS=${ORDS_CONFIG}/logs
export DB_PORT=1521
export DB_SERVICE=ORCLCDB
export HOSTNAME=10.244.0.4
export SYSDBA_USER=SYS
export SYSDBA_PASSWORD=oracle
export ORDS_PASSWORD=oracle


/usr/local/bin/ords --config ${ORDS_CONFIG} install \
     --log-folder ${ORDS_LOGS} \
     --admin-user ${SYSDBA_USER} \
     --db-hostname ${HOSTNAME} \
     --db-port ${DB_PORT} \
     --db-servicename ${DB_SERVICE} \
     --feature-db-api true \
     --feature-rest-enabled-sql true \
     --feature-sdw true \
     --gateway-mode proxied \
     --gateway-user APEX_PUBLIC_USER \
     --proxy-user \
     --password-stdin <<EOF
${SYSDBA_PASSWORD}
${ORDS_PASSWORD}
EOF
/usr/local/bin/ords  --config /opt/oracle/config_ords serve