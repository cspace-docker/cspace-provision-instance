#!/usr/bin/env bash

# cspace-instance.copyme
#
# This is a template file.  Please do the following:
#
# 1. COPY this file, creating a new file named 'cspace-instance.sh'.
# 2. In the newly-created file, CHANGE any or all of the default values below,
#    as directed.

# Passwords for various database users
#
# You SHOULD change the passwords below from their defaults.
# Otherwise, you may be inadvertently giving other people
# unauthorized access to your database.
#
# A superuser account for CollectionSpace database administration.
#
s/${DB_CSADMIN_PASSWORD}/csadmin/
#
# Accounts for reading and writing to the AuthN/AuthZ database
# and 'all other records' database, respectively.
#
s/${DB_CSPACE_PASSWORD}/cspace/
s/${DB_NUXEO_PASSWORD}/nuxeo/
#
# An account for read-only access to the 'all other records' database.
#
s/${DB_READER_PASSWORD}/reader/


# Database server information.
#
# You MUST change at least the DB_HOST value from its default
# if your CollectionSpace server will be accessing a remote
# database server (i.e. not on the same host as CollectionSpace).
#
# Database server hostname (or IP address) and port.
# Defaults are 'localhost' and '5432', respectively.
#
s/${DB_HOST}/localhost/
s/${DB_PORT}/5432/


# Instance ID.
#
# You MUST change the CSPACE_INSTANCE_ID value from its default
# if your CollectionSpace server will be sharing a database
# with one or more other CollectionSpace servers.
#
# Instance IDs help identify the databases and database users
# that belong to a particular CollectionSpace server instance,
# in a configuration where multiple CollectionSpace servers all
# share a single database server.
#
# The instance ID is blank by default. If it is added, by convention,
# instance IDs should begin with an underscore (_). E.g.: _myinstancename
s/${CSPACE_INSTANCE_ID}//
