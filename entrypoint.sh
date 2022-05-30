#!/bin/bash

CURRENT_CONTAINER_URL="https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${STORAGE_ACCOUNT_CURRENT_CONTAINER}"
PREVIOUS_CONTAINER_URL="https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${STORAGE_ACCOUNT_PREVIOUS_CONTAINER}"

echo "Updating previous backup..."
azcopy sync "${CURRENT_CONTAINER_URL}${STORAGE_ACCOUNT_SAS_KEY}" "${PREVIOUS_CONTAINER_URL}${STORAGE_ACCOUNT_SAS_KEY}" --delete-destination=true

echo "Updating current sites backup..."
azcopy sync /volumes/sites "${CURRENT_CONTAINER_URL}/sites${STORAGE_ACCOUNT_SAS_KEY}" --delete-destination=true

echo "Creating a location to store mongo backups"
mkdir -p /mongo

echo "Dumping mongo database"
mongodump -h "$MONGO_HOST" -u "$MONGO_USERNAME" -p "$MONGO_PASSWORD" -o /mongo

echo "Compressing mongo backup"
tar -cvzf /root/mongo.tar.gz /mongo

echo "Updating current mongo backup..."
azcopy copy /root/mongo.tar.gz "${CURRENT_CONTAINER_URL}/database/mongo.tar.gz${STORAGE_ACCOUNT_SAS_KEY}" --put-md5 --overwrite=true
exit 0