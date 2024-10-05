#!/bin/bash

ENV_NAME="${ENV_NAME:=prod}"
CERT_FILE="${CERT_FILE:=/opt/osctrl/config/osctrl.crt}"
HOST="${HOST:=nginx}"
OSCTRL_USER="${OSCTRL_USER:=admin}"
OSCTRL_PASS="${OSCTRL_PASS:=admin}"
WAIT="${WAIT:=5}"

######################################### OSCTRL_PASS #########################################
if [[ -n "$OSCTRL_PASS_FILE" ]]; then
  OSCTRL_PASS=$(cat ${OSCTRL_PASS_FILE})
fi

######################################### Wait until DB is up #########################################
until /opt/osctrl/bin/osctrl-cli check-db
do
  echo "DB is not ready"
  sleep $WAIT
done

######################################### Create environment #########################################
/opt/osctrl/bin/osctrl-cli --db env add \
  --name "${ENV_NAME}" \
  --hostname "${HOST}" \
  --certificate "${CERT_FILE}"
if [ $? -eq 0 ]; then
  echo "Created environment ${ENV_NAME}"
else
  echo "Environment ${ENV_NAME} exists"
fi

######################################### Create admin user #########################################
/opt/osctrl/bin/osctrl-cli --db user add \
  --admin \
  --username "${OSCTRL_USER}" \
  --password "${OSCTRL_PASS}" \
  --environment "${ENV_NAME}" \
  --fullname "${OSCTRL_USER}"

if [ $? -eq 0 ]; then
  echo "Created ${OSCTRL_USER} user"
else
  echo "The user ${OSCTRL_USER} exists"
fi

echo "The environment ${ENV_NAME} is ready"

echo "
##############################################################################
#                Successfully created an osctrl user and env
#
# osctrl admin user: ${OSCTRL_USER}
# osctrl env name: ${ENV_NAME}
##############################################################################
"

# Start a shell to avoid re-running this script
/bin/bash
