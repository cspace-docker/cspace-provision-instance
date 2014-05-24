FROM rem/cspace-version
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

# ############################################################
# IMPORTANT: This Dockerfile MUST be invoked via
# 'docker run --env-file=cspace-instance.properties ...';
# that is, by referencing the 'cspace-instances.properties'
# file, which sets up required environment variables.
#
# The values in that file can - and should - be edited, each
# time you set up a new CollectionSpace server instance.
#
# (There is a 'cspace-instance.copyme' template file in
# this project, which you can copy and rename to create
# the 'cspace-instances.properties' file.)
# ############################################################

#
# Set the host and port of the PostgreSQL database server
# to which this CollectionSpace server will be connecting.
#
# TODO: Use awk or sed to edit the db.host and db.port values
# in $USER_HOME/$CSPACE_USERNAME/src/services/build.properties

#
# Set the instance ID of this CollectionSpace server instance.
#
# TODO: Use awk or sed to edit the cspace.instance.id value
# in $USER_HOME/$CSPACE_USERNAME/src/services/build.properties

#
# Perform a full source code build and deployment. NOTE: We must build the Application layer first since it creates the configuation tool
# need to create the Service layer's configuration artifacts -i.e, things like the Nuxeo plugins and service bindings.
#
RUN cd $USER_HOME/$CSPACE_USERNAME/src/application && mvn clean install -DskipTests
RUN cd $USER_HOME/$CSPACE_USERNAME/src/services && mvn clean install -DskipTests
RUN cd $USER_HOME/$CSPACE_USERNAME/src/ui && mvn clean install -DskipTests

#
# Deploy configuration artifacts, create and initialize the databases, and populate with AuthN/AuthZ tables
#
RUN cd $USER_HOME/$CSPACE_USERNAME/src/services && ant undeploy deploy create_db import

#
# Finally export port 8180 to our host
#
EXPOSE 8180
