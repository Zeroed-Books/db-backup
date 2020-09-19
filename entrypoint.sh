#!/usr/bin/env sh

set -euf
set -o pipefail

errVarUnset() {
  >&2 echo "\$$1 is not set. Exiting."
  exit 1
}

if [ -z "${ACCESS_KEY_ID+x}" ]; then
  errVarUnset 'ACCESS_KEY_ID'
fi

if [ -z "${BACKUP_FILE+x}" ]; then
  errVarUnset 'BACKUP_FILE'
fi

if [ -z "${BUCKET_NAME+x}" ]; then
  errVarUnset 'BUCKET_NAME'
fi

if [ -z "${REGION+x}" ]; then
  errVarUnset 'REGION'
fi

if [ -z "${SECRET_ACCESS_KEY+z}" ]; then
  errVarUnset 'SECRET_ACCESS_KEY'
fi

cat > "$HOME/.s3cfg" <<EOF
[default]
host_base = ${REGION}.digitaloceanspaces.com
host_bucket = %(bucket)s.${REGION}.digitaloceanspaces.com
EOF

echo -e "Wrote config:\n"
cat "${HOME}/.s3cfg"
echo -e "\n\n"

AWS_ACCESS_KEY_ID="${ACCESS_KEY_ID}" \
  AWS_SECRET_ACCESS_KEY="${SECRET_ACCESS_KEY}" \
  s3cmd -c "${HOME}/.s3cfg" put - "s3://${BUCKET_NAME}/${BACKUP_FILE}"

