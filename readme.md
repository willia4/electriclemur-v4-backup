# Electric Lemur Backup

This docker image will perform a backup of the files important for electriclemur.com to a storage account in Azure. 

### Environment Variables
It requires multiple environment variables to be set: 

- `STORAGE_ACCOUNT_NAME`: the name of the storage account
- `STORAGE_ACCOUNT_CURRENT_CONTAINER`: the name of the container which contains the most recent backup
- `STORAGE_ACCOUNT_PREVIOUS_CONTAINER`: the name of the container which contains the previous backup
- `STORAGE_ACCOUNT_SAS_KEY`: a SAS token that allows reading and writing to both of the above containers

### Volumes
You must mount volumes containing the data to back up.

- `/volumes/sites`: this should be mounted to a directory of "simple sites"; all subdirectories of this volume will be backed up

### Example
Run this container via

```
docker run --rm --name backup \
  -e "STORAGE_ACCOUNT_NAME=..." \
  -e "STORAGE_ACCOUNT_CURRENT_CONTAINER=..." \
  -e "STORAGE_ACCOUNT_PREVIOUS_CONTAINER=..." \
  -e "STORAGE_ACCOUNT_SAS_KEY=.." \
  -v "/volumes/simple_sites:/volumes/sites" \
  willia4/electriclemur_backup:latest \
  /entrypoint.sh
```