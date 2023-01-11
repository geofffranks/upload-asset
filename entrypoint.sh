#! /bin/bash

set -e

if [ "x$(jq .release ${GITHUB_EVENT_PATH})" == "x" ]; then
    echo "no release object"
    exit 1
fi

WITH_SHA1=${INPUT_WITH_SHA1}
UPLOAD_URL=$(jq .release.upload_url ${GITHUB_EVENT_PATH} | tr -d '"' | sed "s/{?name,label}//g")
UPLOAD_FILE=${INPUT_FILE}
FILE_MIME_TYPE=$(file -b --mime-type ${INPUT_FILE})

if ${WITH_SHA1}; then
    UPLOAD_SHA1_FILE="${UPLOAD_FILE}.sha1"
    sha1sum ${UPLOAD_FILE} > ${UPLOAD_SHA1_FILE}
    curl -s \
         -H "Authorization: token ${GITHUB_TOKEN}" \
         -H "Content-Type: $(file -b --mime-type ${UPLOAD_SHA1_FILE})" \
         --data-binary @"${UPLOAD_SHA1_FILE}" \
         "${UPLOAD_URL}?name=${UPLOAD_SHA1_FILE}"
fi

curl -s \
     -H "Authorization: token ${GITHUB_TOKEN}" \
     -H "Content-Type: ${FILE_MIME_TYPE}" \
     --data-binary @"${UPLOAD_FILE}" \
     "${UPLOAD_URL}?name=${UPLOAD_FILE}"

echo "upload asset: ${UPLOAD_FILE}"
