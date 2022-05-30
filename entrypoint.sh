#!/bin/bash

CURRENT_CONTAINER_URL="https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${STORAGE_ACCOUNT_CURRENT_CONTAINER}"
PREVIOUS_CONTAINER_URL="https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${STORAGE_ACCOUNT_PREVIOUS_CONTAINER}"

echo "Updating previous backup..."
azcopy sync "${CURRENT_CONTAINER_URL}${STORAGE_ACCOUNT_SAS_KEY}" "${PREVIOUS_CONTAINER_URL}${STORAGE_ACCOUNT_SAS_KEY}" --delete-destination=true

echo "Updating current backup..."
azcopy sync /volumes/sites "${CURRENT_CONTAINER_URL}/sites${STORAGE_ACCOUNT_SAS_KEY}" --delete-destination=true

exit 0