# Zeroed Books DB Backup

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/zeroedbooks/db-backup)](https://hub.docker.com/r/zeroedbooks/db-backup)

Docker image used to back up the Zeroed Books database to a Digitalocean space.
The image is a wrapper around the [`s3cmd`][s3cmd] tool, with a little
configuration to make the tool point to DigitalOcean instead of S3.

## Parameters

The image expects a database dump to be provided via stdin. This would
typically be piped in from the backup program being used. In addition to the
actual database dump, the following environment variables are also required.

Name                | Description
--------------------|---------------------------------------------------------
`ACCESS_KEY_ID`     | Access key for the target space
`BACKUP_FILE`       | The name of the backup file relative to the space's root
`BUCKET_NAME`       | The name of the space to upload to
`REGION`            | The Digitalocean region that the target space exists in
`SECRET_ACCESS_KEY` | The secret access key for the target space

## Usage

The following is a skeleton for the invocation of the command without the
required environment variables.

```bash
cmd_to_dump_db_backup | docker run --interactive zeroedbooks/db-backup
```

[s3cmd]: https://s3tools.org/s3cmd

