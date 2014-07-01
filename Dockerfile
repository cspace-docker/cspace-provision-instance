#
# cspace-instance Dockerfile
#
# Dockerfile 3 of 3 to install and configure a CollectionSpace
# server instance inside a Docker container.
#

#
# Start from the Docker image built by running the
# 'cspace-version' Dockerfile.
#
FROM collectionspace/cspace-version
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

#
# Set the host and port of the PostgreSQL database server
# to which this CollectionSpace server will be connecting.
#
# TODO: Use awk or sed to edit the db.host and db.port values
# in $USER_HOME/$CSPACE_USERNAME/src/services/build.properties,
# based on values passed into or referenced from this Dockerfile.
#

#
# Set the instance ID of this CollectionSpace server instance.
#
# TODO: Use awk or sed to edit the cspace.instance.id value
# in $USER_HOME/$CSPACE_USERNAME/src/services/build.properties
# based on values passed into or referenced from this Dockerfile.
#

#
# Perform a full source code build and deployment.
#
# NOTE: We must build the Application layer first since it creates the
# configuration tool needed to create the Service layer's configuration
# artifacts; i.e items such as the Nuxeo plugins and service bindings.
#
RUN cd $USER_HOME/$CSPACE_USERNAME/src/application && mvn clean install -DskipTests
RUN cd $USER_HOME/$CSPACE_USERNAME/src/services && mvn clean install -DskipTests
RUN cd $USER_HOME/$CSPACE_USERNAME/src/ui && mvn clean install -DskipTests

#
# Deploy configuration artifacts, create and initialize the databases,
# and populate the AuthN/AuthZ tables.
#
RUN cd $USER_HOME/$CSPACE_USERNAME/src/services && ant undeploy deploy create_db import

#
# Finally export port 8180 to our host
#
EXPOSE 8180
